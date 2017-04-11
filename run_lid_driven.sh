#!/usr/bin/env zsh

### Job name
#BSUB -J lid_driven

### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o job_logs/lid_driven.%J.%I

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N 

### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 03:00

### Request memory you need for your job in TOTAL in MB
#BSUB -M 1024

### Request the number of compute slots you want to use
#BSUB -n 16

### Use esub for Open MPI
#BSUB -a openmpi

### Use a specific machine
#BSUB -m mpi-s-bull

cd $HOME/projects/Apex
mpirun -n 16 ./Apex-opt -i problems/lid_driven.i
