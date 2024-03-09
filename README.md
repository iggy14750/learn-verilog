
Learning Verilog
================

This repository will contain some of the files that I will write as I learn the Verilog language.

Most of these little designs are exercises from the book "Learn Verilog by Example" by Blaine Readler. This text may be mentioned elsewhere as "VBE".

For others' benefit, as well as that of my future self,
I shall describe some of the details of getting this code working.

Icarus Verilog
--------------

A Free and Open Source Verilog simulator.
Find the homepage [here](http://iverilog.icarus.com/page), 
and User Guide [here](https://iverilog.fandom.com/wiki/User_Guide),
but most importantly, install from your package manager as "iverilog".

Verilator
---------

I am also playing around with Verilator in this project,
as well as Icarus.
I haven't yet settled on one, so they are both used in the Makefile
in inconsistent ways at this time.

GTKWave
-------

A Free and Open Source waveform viewer.

Make
----

Everything is run with Makefiles.
In general, to compile everything and run all included testbenches, simply run "make".

References
----------

- https://itsembedded.com/dhd/verilator_1/
- https://itsembedded.com/dhd/verilator_4/
- https://github.com/chipsalliance/uvm-verilator
- https://www.reddit.com/r/FPGA/comments/146r7yc/c_verification_testbench_bestpractice_resources/
- https://www.reddit.com/r/FPGA/comments/rkoe3q/how_good_is_verilator_for_big_industry_designs/
- https://www.reddit.com/r/FPGA/comments/qem4a7/verilator_suggestions_for_verification_framework/
- https://verilator.org/guide/latest/exe_verilator_coverage.html
- https://github.com/verilator/verilator/issues/3151
- https://www.foresys.com/design-services/fpga-design/

(The following are not really for this repo, need to be moved somewhere else)
- https://github.com/captn3m0/plaintext-everything?tab=readme-ov-file
- https://github.com/driusan/PoormanIssueTracker


