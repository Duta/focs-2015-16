Elements of Functional Computing
================================

Contains assignments for the UoB EFC module, 2015-16.

Folder Structure:
-----------------

```
focs-2015-16
|-- README.md
|-- StripComments.hs
|-- bench.cmi
|-- bench.cmo
|-- prepare_env.csh
|-- test.py
|-- validator.py
`-- week-3
    |-- exercise-1
    |   `-- gen-skeleton.ml
    |-- exercise-2
    |   `-- gen-skeleton.ml
    `-- exercise-3
        `-- gen-skeleton.ml
```

Getting Set Up:
---------------

The first thing you'll need is [git](http://git-scm.com/downloads).

You may well have this installed already. To check, open a terminal and type:

    git --version

If you get a message about 'git' not being found, then you'll need to [install it](http://git-scm.com/downloads).

Start a terminal session, and do the following steps:

 - First, navigate to the folder in which you store your work files:

   `cd path/to/your/work/folder`

 - Next, we download the files:

   `git clone https://github.com/Duta/focs-2015-16`

 - This will have created a folder called `focs-2015-16`:

   `cd focs-2015-16`

Inside `focs-2015-16` will be files in the structure shown in the above image.

Let's get the week 3's 1st exercise:

    cd week-3/exercise-1

    ocaml gen-skeleton.ml

This will create a new file in the exercise-1 folder called `wk3ex1.ml`.

This looks like this:

```ocaml
let sort5 = failwith "To do: Implement sort5";;
```

This is a starting point for you to complete the exercise.

Downloading New Assignments:
----------------------------

Very occasionally (okay, every week) you'll be set new assignments.

To download them, make sure you're in the `focs` folder, and type:

    git pull

This will download any new assignments, making sure you're up to date.

You may also need to do this from time to time if we add or change test scripts.

Installing Prerequisites:
------------------------

### `Requests` Python module

Python is a requirement for the marking script to function.
On the computer you wish to use to upload your assignments you need to have OCaml installed, Python installed and the requests module installed for Python.

The lab machines already contain a copy of Python. To install 'requests' for the marking script to use, please run the following commands on the terminal.
You can do the same on the virtual machine image.

	git clone git://github.com/kennethreitz/requests.git
	cd requests
	python setup.py install --user

You can then safely delete the `requests` folder.

### Dependencies for the UG04/LG04 computer labs

The default installation of OCaml is too old. To access the new installation you need to type these commands every time you use the lab machines:

	module load OCaml
	module load OPAM

Note that `ocaml` will still run even if you forget to do this but you will get strange errors!

Next you need to initialise your OPAM repository and upgrade it and install the missing dependencies. **You only need to do this once!**

	opam init
	opam upgrade
	opam install quickcheck

You will also need to upgrade your environment, as indicated by OPAM:

	eval `opam config env`

Once you've done all this the first time, in subsequent sessions you can simply type:

	./prepare_env.csh

To get your terminal up and running again.

Getting a Canvas Access Token:
------------------------------

In order for the marking script to upload your submission, you need to have an authentication token. This token will provide access to your canvas account, and should be treated as a password. Never share your access token with someone else, and it’s suggested that you only make this token available for a day, and generate a new one every time you submit an assignment.

 - First, navigate to your profile settings on Canvas.

	https://birmingham.instructure.com/profile/settings

 - Toward the bottom of this page, click to generate a new access token.

![Access_Token](http://puu.sh/cg4h4/484c9902b8.jpg)

 -Give the token a name under the "Purpose" entry box, select a suitable date (Generally the next day) and generate the token.

![Generate_Token](http://puu.sh/cg4om/55cc8a6efa.jpg)

 - You will be faced with a page that has your full token. Take a note of it as you’ll need it when running the testing script.

Testing and Submitting Assignments:
-----------------------------------

To test your assignments, you need to be in the `week-n` folder (e.g. `week-2`)
in a terminal session, and run the testing script for the exercise you're working on.

As an example, this is how you'd test week 3's 1st exercise:

    cd path/to/your/work/folder/focs-2015-16/week-3
    python test_ex1.py

The output should be self-explanatory. If you pass the test, it will ask you to
generate an access token for canvas, and will upload your file (along with a
hash value used for detecting plagiarism) to canvas. See the instructions above about
how to get the token. Once it is displayed in a Canvas window copy-and-paste it into
the terminal window then hit return.

**Please don't try and upload your assignments to canvas manually!
If you do, you'll get a mark of 0.**

The list of current testing scripts is:

    focs-2015-16/week-3/test_ex1.py
    focs-2015-16/week-3/test_ex2.py
    focs-2015-16/week-3/test_ex3.py

If everything works out correctly you should see no further output. If there are any errors please contact us immediately!
