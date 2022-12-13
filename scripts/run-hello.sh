#!/bin/sh

rm -f hello
iverilog -o hello test/hello.v
vvp hello

