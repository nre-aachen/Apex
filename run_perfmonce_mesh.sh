#!/usr/bin/env zsh

### Job name
#BSUB -J apex_big_transient

### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o transient.%J.%I

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N 

### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 01:80

### Request memory you need for your job in TOTAL in MB
#BSUB -M 128192

### Use esub for Open MPI
#BSUB -a openmpi

### Use a specific machine
#BSUB -m mpi-s-bull

cd $HOME/projects/Apex
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_17920.i
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_133920.i
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_430080.i
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_995600.i
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_3248000.i
