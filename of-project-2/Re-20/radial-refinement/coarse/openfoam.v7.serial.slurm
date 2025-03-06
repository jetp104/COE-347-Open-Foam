#!/bin/bash

# See https://docs.tacc.utexas.edu/hpc/frontera/#scripts 
# for more details

#SBATCH -J pp-coarse      # Job name
#SBATCH -o tutorial.o%j       # Name of stdout output file
#SBATCH -e tutorial.e%j       # Name of stderr error file

### #SBATCH -p normal          # Queue (partition) name

#SBATCH -p development          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes
#SBATCH -n 1               # Total # of mpi tasks
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)


#SBATCH -A CTS24005       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module load openfoam/7.0
module list

pwd
date

./Allrun

date

