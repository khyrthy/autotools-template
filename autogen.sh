#!/bin/bash

echo "Generating automatically compilation-needed files.."

# You can remove this warning by deleting these lines below
echo "WARNING: Before running this script, please make sure configure.ac and Makefile.am files are well configured, so this script runs without any error."
read -p "Please press RETURN to continue or CTRL+C to cancel:"
echo ""

# Run the commands
echo -n "Running aclocal..."
aclocal
echo "OK"

echo -n "Running autoconf..."
autoconf
echo "OK"

echo -n "Running automake..."
automake --add-missing
echo "OK"
