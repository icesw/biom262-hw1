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

#Wendy Chen did exercise #1-3
# Exercise 1
awk -F "\t" '{ if ($4 == "nfkb") {print} }' tf.bed > tf.nfkb.bed
# Exercise 2
awk -F "\t" '{ if ($2 == "transcript") {print} }' gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf
# Exercise 3
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf

# Audrey Hong did exercise #4,5
# Exercise 4
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

# Exercise 5
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

echo "Hello I am a message in standard error (stderr) >&2

echo "Hello I am a message in standard out (stdout)"

