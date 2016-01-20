#!/bin/csh
#PBS -q hotel
#PBS -N tf_binding.sh
#PBS -l nodes=10:ppn=2
#PBS -l walltime=0:50:00
#PBS -o output.sh
#PBS -e error.txt
#PBS -V
#PBS -M audrey793@gmail.com
#PBS -m abe
#PBS -A audrey793
cd /oasis/tscc/scratch/ucsd-train29
mpirun -v -machinefile $PBS_NODEFILE -np 20 <./mpi.out>
echo "Hello I am a message in standard out (stdout)"
