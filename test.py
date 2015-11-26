import base64, re, requests, subprocess, os, os.path, validator

def check_integrity():
    if not os.path.exists("cmos/files.sha256sums"):
        # Maybe not available for this week.
        return True

    cmdraw = """

    sha256sum -c --quiet cmos/files.sha256sums
    || (echo;echo "Seems like you modified some files?
             Run 'git checkout <file>' to get a fresh copy.";echo)

    """

    cmd = ' '.join(line.strip() for line in cmdraw.splitlines())

    os.system(cmd)

def upload_to_canvas(assignment_code, submission):
    # Prompt for access token
    token = raw_input('Paste your Canvas authentication token: ')

    # Upload to Canvas
    payload = {
        'access_token': token,
        'submission[submission_type]': 'online_text_entry',
        'submission[body]': base64.b64encode(submission)
    }
    ex_url = 'https://birmingham.instructure.com/api/v1/courses/15627/assignments/'+assignment_code+'/submissions'
    submission_info = requests.post(ex_url, params=payload).json()

    # Check for errors with the upload
    if 'errors' in submission_info.keys():
        print 'The submission to Canvas failed, please show a demonstrator the following error:'
        print submission_info['errors']
    else:
        print 'There were no errors during execution, please check Canvas to confirm your assignment was submitted.'

def ensure_file(file, message):
    if not os.path.exists(file):
        print(message)
        exit(1)

ensure_file_default = lambda file: ensure_file(file, 'The file "' + file + '" could not be found. Exiting...')
run_command = lambda command: subprocess.call(command, shell=True)
remove_file = lambda file: run_command('rm -rf ' + file)
packages = ['str', 'quickcheck', 'unix']

# assignment_code :: str
# week            :: str
# exercise        :: str (usually '1', '2' or '3')
def test(assignment_code, week, exercise, extra_links=[],*checks):
    # Helper functions
    no_assmt_msg = """
File %s not found. You can create a skeleton
file by going into the %s directory,
and then running `ocaml gen-skeleton.ml`.

Exiting...
""".strip()
    ensure_file_assmt = lambda file: ensure_file(file, no_assmt_msg % (file, os.path.dirname(file)))
	  # File names
    ex_folder = 'exercise-' + exercise
    ex_name = 'ex'+exercise
    ex_full_name = 'wk' + week + ex_name
    ex_hash = ex_full_name + '_hash'
    ex_runner = ex_name + '_run'
    ex_tester = ex_name + '_test'
    ex_binary = ex_name + '_bin'

    week_has_common = os.path.exists("cmos/common.cmo")

    # Ensure needed files exist
    required_files = (([
            ('cmos', 'common', 'cmo'),
            ('cmos', 'common', 'cmi'),
        ] if week_has_common else [])
        + [
            ('..', 'bench', 'cmo'),
            ('..', 'bench', 'cmi'),
            (ex_folder, ex_full_name, 'ml'),
            (ex_folder, ex_full_name, 'mli'),
            ('cmos', ex_runner, 'cmo'),
            ('cmos', ex_runner, 'cmi'),
            ('cmos', ex_tester, 'cmo'),
            ('cmos', ex_tester, 'cmi')
        ])

    ensure_file_assmt(ex_folder + '/' + ex_full_name + '.ml')
    for folder, file, extension in required_files:
        ensure_file_default(folder + '/' + file + '.' + extension)

    issues = validator.validate(ex_folder + '/' + ex_full_name + '.ml', *checks)

    if issues:
        print 'Issues with your program:'
        print issues
        exit()

    check_integrity()

    # Prep for compilation
    for folder, file, extension in required_files:
        run_command('cp ' + folder + '/' + file + '.' + extension + ' .')

    # Compile and run the test program
    ocamlfind_call = [
        'ocamlfind',

        'ocamlc',

        '-o',
        ex_binary,

        '-linkpkg',
        '-package',
        ','.join(packages + extra_links),

        'common.cmo' if week_has_common else '',
        'bench.cmo',
        ex_tester + '.cmo',
        ex_full_name + '.mli',
        ex_full_name + '.ml',
        ex_runner + '.cmo'
    ]
    run_command(' '.join(ocamlfind_call))

    # Check if compilation succeeded
    ensure_file(ex_binary, "Couldn't compile your file. Above should the error(s)")

    # Clean up post-compilation
    files_to_remove = map(lambda (_, file, extension): file + '.' + extension, required_files)

    # Test the code
    run_command('./' + ex_binary)

    # Remove the generated and copied files
    remove_file(ex_binary)
    remove_file(ex_full_name + '.cm?')
    remove_file(' '.join(files_to_remove))

    # Check if the tests passed
    print ''
    ensure_file(ex_hash, 'Your code failed the tests, see above for reasons why.')
    print 'Your code passed the tests!'

    # Read hash file's contents
    with open(ex_hash, 'r') as hash_file:
        submission = hash_file.read()

    # Delete the hash file
    remove_file(ex_hash)

    upload_to_canvas(assignment_code, submission)

def test_yum(assignment_code, week, exercise):
    # File names
    ex_folder = 'exercise-' + exercise
    ex_name = 'ex'+exercise
    ex_full_name = 'wk' + week + ex_name
    ex_hash = ex_full_name + '_hash'
    ex_runner = ex_name + '_run'
    ex_binary = ex_name + '_bin'

    # Ensure needed files exist
    required_files = [
            ('..', 'bench', 'cmo'),
            ('..', 'bench', 'cmi'),
            (ex_folder, ex_full_name, 'proof'),
            ('cmos', ex_runner, 'cmo'),
            ('cmos', ex_runner, 'cmi'),
        ]

    for folder, file, extension in required_files:
        ensure_file_default(folder + '/' + file + '.' + extension)

    check_integrity()

    # Prep for compilation
    for folder, file, extension in required_files:
        run_command('cp ' + folder + '/' + file + '.' + extension + ' .')

    # Compile and run the test program
    ocamlfind_call = [
        'ocamlfind',

        'ocamlc',

        '-o',
        ex_binary,

        '-linkpkg',
        '-package',
        ','.join(packages),

        'bench.cmo',
        ex_runner + '.cmo'
    ]
    run_command(' '.join(ocamlfind_call))

    # Check if compilation succeeded
    ensure_file(ex_binary, "Couldn't compile your file. Above should the error(s)")

    # Clean up post-compilation
    files_to_remove = map(lambda (_, file, extension): file + '.' + extension, required_files)

    # Test the code
    run_command('./' + ex_binary)

    # Remove the generated and copied files
    remove_file(ex_binary)
    remove_file(' '.join(files_to_remove))

    # Check if the tests passed
    print ''
    ensure_file(ex_hash, 'Your code failed the tests, see above for reasons why.')
    print 'Your code passed the tests!'

    # Read hash file's contents
    with open(ex_hash, 'r') as hash_file:
        submission = hash_file.read()

    # Delete the hash file
    remove_file(ex_hash)

    upload_to_canvas(assignment_code, submission)

