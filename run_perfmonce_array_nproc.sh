#!/usr/bin/env zsh
 
### Job name and array definition: run jobs with ID (1,2,3,5)
### Note: all jobs may run parallely
#BSUB -J "myArray_nproc[1-4]"
 
### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o perfomance_array_nproc.%J.%I
 
### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 3:00

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N 
 
### Request memory you need for your job in TOTAL in MB
#BSUB -M 1024


### Use esub for Open MPI
#BSUB -a openmpi

### Use a specific machine
#BSUB -m mpi-s-bull
 
### which one array job is this?
echo LSB_JOBINDEX: $LSB_JOBINDEX


 case "$LSB_JOBINDEX" in
    
    1)
        #BSUB -n 8
       mpirun -n 8 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    2)
        #BSUB -n 16
        mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    3)
        #BSUB -n 32
        mpirun -n 32 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    4)
        #BSUB -n 64
        mpirun -n 64 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

esac


