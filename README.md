PATHMAN - A path manager for MATLAB
===================================

MATLAB finds functions/classes/packages by searching the current working
directory, followed by the list of directories in its path variable.
Directories can be added or removed from the path via the `addpath`
and `rmpath` functions.

PATHMAN is a MATLAB tool intended to make managing the path easier, so
you can separate code into small packs, and use those packs as
necessary, without worrying about where they exist on the drive.

For example, say I have a set of useful functions in a directory called
`myfolder/mypack`.  To make PATHMAN aware of `mypack` I can say

    pathman install myfolder/mypack [as mypack]

on the MATLAB command line. `as mypack` is optional since the directory
containing the code is called `mypack`.  If I wanted to install `mypack`
from a directory called `src` instead, then I would write

    pathman install myfolder/src as mypack

**NOTE**: *Unfortunately, it is required that the directory specified in
the install statement is RELATIVE to the current working directory.  If
an absolute path is used, the update function (see below) will fail.
This is due to MATLAB's lack of a good function for retrieving an
absolute path. (Simply using java directly to achieve this can also fail
if you change MATLAB's working directory after java is loaded).*

Later, if I want to use the functions from `mypack`, I simply call

    pathman use mypack

and the functions are added to my path.

Now, suppose I go an edit the functions in mypack, at their original
location.  Now, calling `pathman use mypack` will load the old versions.
To update I simply call

    pathman update mypack

before `use`ing it.

To remove the pack from the path,

    pathman unuse mypack

Note that PATHMAN path changes do not persist after the end of session
so `unuse`ing packs is largely optional.

More details can be found by looking at the

    help(pathman) % or
    pathman help

on the MATLAB command-line after installation.


Installation
------------

After cloning the repository, navigate to the `pathman` directory in
MATLAB (the directory containing `install.m`). Then run

    install INSTALLPATH

where INSTALLPATH is a location permanently on the MATLAB path (eg.
~/Documents/MATLAB is often on the search path by default).

At this point, a config file will open in the MATLAB editor.  You will
see the line

    conf.ROOT = ~/Documents/MATLAB/PATHMANPACKAGES

Set this value to the location where you wish to store the copies of
installed packs.  This location does not need to be on the path.


Path Setup for Packs
--------------------

When you install or update a pack, PATHMAN copies the entire source
directory to a directory in the ROOT directory discussed above.  It
supplies a default script to add and remove the package to the path.
This script simply does

    addpath(genpath(pd))
    % or
    rmpath(genpath(pd))

where `pd` is the location of the copied source directory.  To customize
this behaviour, create two functions in the top of your source directory:
`addtopath.m` and `rmfrompath.m`.  These functions should accept one
string argument, which specifies the root directory of the source for
the pack.

For example, if my pack structure was

    mypack/
       src/
       example/
       README.txt

and I only wanted PATHMAN to add the `src` subdirectory to the path,
then I could have

    % addtopath.m
    function addtopath(pd)
        addpath(fullfile(pd, 'src'))
    end

    % rmfrompath.m
    function rmfrompath(pd)
        rmpath(fullfile(pd, 'src'))
    end

.pathmanignore
--------------

Finally, a pack may have files you don't want copied to the
PATHMANPACKAGES directory.  In the example above, suppose
`mypack/example` contained a large amount of data.  Since we are only
adding `src` to path anyway, PATHMAN doesn't need to copy anything else.

Therefore, if I create a file in the top level of the source tree,
`.pathmanignore` I can specify files and folders that should not be
copied. (*Note, they actually are copied, but are subsequently deleted.
Therefore, it would save the space taken by the copy, but not the time,
if you had a big data file*).

So by creating `.pathmanignore`

    example
    README.txt

then the corresponding source folder in PATHMANPACKAGES becomes

    mypack.pack/
        src/

Alternatively, if we simply wanted to treat src as a package, we could
just use

    pathman install mypack/src as mypack

without worrying about a `.pathmanignore` file.


More Information
----------------

The remainder of PATHMAN functionality is documented in the help.

    pathman help % or
    help(pathman)
