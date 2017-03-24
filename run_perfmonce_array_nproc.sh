#!/usr/bin/env zsh
 
### Job name and array definition: run jobs with ID (1,2,3,5)
### Note: all jobs may run parallely
#BSUB -J "myArray_nproc[1-8]"
 
### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o perfomance_array_nproc.%J.%I
 
### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 1:23

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N 
 
### Request memory you need for your job in TOTAL in MB
#BSUB -M 10240

### Use esub for Open MPI
#BSUB -a openmpi
 
### which one array job is this?
echo LSB_JOBINDEX: $LSB_JOBINDEX


 case "$LSB_JOBINDEX" in
    1)
       mpirun -n 1 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;
 
    2)
        mpirun -n 2 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    3)
        mpirun -n 4 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    4)
       mpirun -n 8 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    5)
        mpirun -n 16 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    6)
        mpirun -n 32 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    7)
        mpirun -n 64 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;

    8)
        mpirun -n 128 ./Apex-opt -i problems/performance_test/d_steady_perth_1900800.i
    ;;
 
esac


