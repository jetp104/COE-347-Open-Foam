#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Frontera CLX nodes
#
#   *** Serial Job in Small Queue***
# 
# Last revised: 22 June 2021
#
# Notes:
#
#  -- Copy/edit this script as desired.  Launch by executing
#     "sbatch clx.serial.slurm" on a Frontera login node.
#
#  -- Serial codes run on a single node (upper case N = 1).
#       A serial code ignores the value of lower case n,
#       but slurm needs a plausible value to schedule the job.
#
#  -- Use TACC's PyLauncher utility to run multiple serial 
#       executables at the same time, execute "module load pylauncher" 
#       followed by "module help pylauncher".
#----------------------------------------------------

#SBATCH -J 400-half           # Job name
#SBATCH -o 400-half.o%j       # Name of stdout output file
#SBATCH -e 400-half.e%j       # Name of stderr error file
#SBATCH -p small           # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 6:00:00        # Run time (hh:mm:ss)
#SBATCH -A CTS24005       # Project/Allocation name (req'd if you have more than 1)

# Any other commands must follow all #SBATCH directives...
module load openfoam/7.0

# Launch serial code...
./Allrun         # Do not use ibrun or any other MPI launcher
