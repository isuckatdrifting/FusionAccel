
The design files are located at
C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir:

   - mem_ctrl.veo:
        veo template file containing code that can be used as a model
        for instantiating a CORE Generator module in a HDL design.

   - mem_ctrl.xco:
       CORE Generator input file containing the parameters used to
       regenerate a core.

   - mem_ctrl_flist.txt:
        Text file listing all of the output files produced when a customized
        core was generated in the CORE Generator.

   - mem_ctrl_readme.txt:
        Text file indicating the files generated and how they are used.

   - mem_ctrl_xmdf.tcl:
        ISE Project Navigator interface file. ISE uses this file to determine
        how the files output by CORE Generator for the core can be integrated
        into your ISE project.

   - mem_ctrl.gise and mem_ctrl.xise:
        ISE Project Navigator support files. These are generated files and
        should not be edited directly.

   - mem_ctrl directory.

In the mem_ctrl directory, three folders are created:
   - docs:
        This folder contains Virtex-6 FPGA Memory Interface Solutions user guide
        and data sheet.

   - example_design:
        This folder includes the design with synthesizable test bench.

   - user_design:
        This folder includes the design without test bench modules.

The example_design and user_design folders contain several other folders
and files. All these output folders are discussed in more detail in
Spartan-6 FPGA Memory Controller user guide (ug388.pdf) located in docs folder.
    