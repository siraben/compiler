#!/bin/sh
set -e
cc -DLISP=1 -O2 -o vm vm.c && ./vm > binary_lisp_output
cc -O2 -o vm vm.c && ./vm > binary_output
git diff --no-index binary_lisp_output binary_output
