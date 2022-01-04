# Autotools Template

Useful templates for your autotools needs!

## What is autotools?

Autotools is composed of 3 programs developed by the GNU organization: aclocal, that checks on what software is installed on your machine to use it, autoconf, that configures the build environment for the compilation, and automake, that generates a makefile to build your program.

If you want to learn more about Autotools, you can read its [official documentation](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html).

* [Getting Started](#getting-started)
  * [Install dependencies](#install-dependencies)
  * [Download the files](#download-the-files)
  * [Preparing the build](#preparing-the-build)
* [Further configurations](#configuring-autotools)
  * [Contents of an autotoolkit](#contents-of-an-autotoolkit)
  * [Configuring autoconf](#configuring-autoconf)
* [Best Practices](#best-practices)
  * [Using a src directory for source code](#using-a-src-directory-for-source-code)
  * [Creating an autogen script](#creating-an-autogen-script)

## Getting Started

### Install dependencies

Firstly, we'll need to install some dependencies!

**Debian/Ubuntu**
```bash
# apt install build-essential git
```

**Arch Linux**
```bash
# pacman -S base-devel git
```

**RedHat/Fedora/SUSE**
```bash
# dnf groupinstall "development tools" git
```

### Download the files

Then you'll just need to download this repository in your project.
Just use these commands:
```bash
git submodule add https://github.com/khyrthy/autotools-template
rm autotools-template/README.md
mv autotools-template/* .
```

### Preparing the build

To prepare the build, you'll need to run these 3 commands:
```
aclocal
autoconf
automake --add-missing
```

Firstly, aclocal will head over your system and scan for things it needs. Then, autoconf will parse the configure.ac file and make the well-known `./configure` file. Lastly, automake will output a few files `configure` will need, and the `add-missing` option will add some missing files that are required.

## Further configurations

### Contents of an autotoolkit

An autotoolkit is composed of 2 primary files: `configure.ac` and `Makefile.am`.  
* `configure.ac` is used to configure the project: name, version, support, language, etc
* `Makefile.am` is used to configure the project : output binaries, input programs, and even custom Makefile rules!

The toolkit contains also some secondary files, like `Changelog`, `INSTALL`, or `NEWS`. These files are just used as description files: to get user information

### Configuring autoconf

Firstly, you'll need to configure `autoconf`.  
Autoconf is used to configure the makefile, so the build program is not issuing errors, because Autoconf configured everything before. Autoconf generates the famous `./configure` file you've already seen in almost every big C program.

To configure autoconf, you need to edit `configure.ac`.

```
AC_INIT([Your Program], [Your Version], [Your Program Support Address])
```
This line tells to autoconf which program it is configuring, and in which version.

```
AM_INIT_AUTOMAKE
```
This lines tells to autoconf to start initializing automake

```
AC_PROG_XXX
```
These lines tells to autoconf the language of your program, so it can call some interpreter. For example, `AC_PROG_CXX` and `AC_PROG_CPP` tells that we are coding in C++.

```
AC_CONFIG_FILES
```
This line tells to autoconf what file to generate. Most of the time, it's a Makefile.

### Configuring automake

Automake is the tool we will be needing to create Makefiles, so we need to configure it.
We have to tell what are the binaries you want to output, and what are their sources. To do this, we need to edit `Makefile.am`



```
bin_PROGRAMS =
```
In this line, you want to tell to automake every binary you want to make. For example `helloworld` will make a helloworld binary in our output directory.

For each binary you want to make, you need to tell automake how you want to make them:
```
xxx_SOURCES = 
```
Here you need to give automake the path of your source program. (`helloworld.c` for example)

## Best practices

If you want to optimize your workflow, you can follow that few advices and tips to clean it:

### Using a src directory for source code

It can be interesting to put all the source code of your project into a `./src` directory. Then, you can add `src/` prefix to the source code into your `Makefile.am`, and add this line:
```
AUTOMAKE_OPTIONS = subdir-objects
```

### Creating an autogen script

Instead of running aclocal, automake and autoconf commands each time, you should consider making an `autogen.sh` script that will run them for you. Here is a simple `autogen.sh` example:

```bash
#!/bin/bash

echo "Running aclocal..."
aclocal
echo "Running autoconf..."
autoconf
echo "Running automake..."
automake --add-missing
```
