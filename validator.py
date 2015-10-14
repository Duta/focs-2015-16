import re, subprocess, os

def validate(path, *checks):
    stripped_path = path + '_stripped'
    ensure_runhaskell_installed()
    subprocess.call('runhaskell ../StripComments.hs ' + path + ' ' + stripped_path, shell=True)
    if not os.path.exists(stripped_path):
        return "Illegal syntax - couldn't strip comments from file"
    with open(stripped_path) as stripped_file:
        program = stripped_file.read()
    subprocess.call('rm -rf ' + stripped_path, shell=True)

    res = None
    for check in checks:
        res = check(program)
        if res: break
    return res

def check_for_recursion(program):
    return "You can't use recursion" if re.search(r'\blet\s+rec\s+', program) else None

def check_for_illegal_modules(program):
    res = [m for m
        in re.findall(r'(?P<name>\w+)\s*\.', program) + re.findall(r'\bopen\s+(?P<name>\w+)', program)
        if m != 'Common']
    return "Illegal modules " + str(res) + " used" if res else None

def ensure_runhaskell_installed():
    """
    Test if runhaskell is installed. If not, and we're on a lab machine, try to
    install it.
    """

    import subprocess

    if subprocess.call("which runhaskell > /dev/null", shell=True) == 0:
        # Returned no error, so installed.
        return

    # runhaskell is not installed.

    if subprocess.check_output("hostname").strip() == "focs":
        print("")
        print("runhaskell is not installed; attempting to install.")
        print("")

        cmd = "echo focs | sudo --stdin apt-get install -y ghc libghc-parsec3-dev"
        print("+ " + cmd)
        status = os.system(cmd)
        if status != 0:
            raise Exception("Install failed (status %s); ask a demonstrator." % (status,))

        return
    else:
        print("")
        print("runhaskell is not installed and lab machine not detected.")
        print("Please install it and the Parsec library yourself.")
        print("")
        raise Exception("runhaskell not installed")

