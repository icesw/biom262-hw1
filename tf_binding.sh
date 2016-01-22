#!/bin/bash
#PBS -q hotel
#PBS -N tf_binding.sh
#PBS -l nodes=1:ppn=1
#PBS -l walltime=0:10:00
#PBS -m abe

cd ~/code/biom262-2016/weeks/week01/data

# Wendy Chen did exercise #1-3
# Exercise 1
awk -F "\t" '{ if ($4 == "nfkb") {print} }' tf.bed > tf.nfkb.bed
# Exercise 2
awk -F "\t" '{ if ($2 == "transcript") {print} }' gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf
# Exercise 3
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf

# Audrey Hong did exercise #4,5
# Exercise 4
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
# Exercise 5
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
# Exercise 6
# The paper proposed that there are canonical (MATCH > 0.75) and non-canonical (MATCH < 0.75) 11-mer motif of NF-kB. We want to use both (canonical and non-canonical) sequences to align back to our ChIP-seq result to validate whether our data are reasonable. They proposed that canonical sequence is RGGRNNHHYYB, and non-canonical sequences can be found in figure 4b, varying with different dimer formation.To align, first we have to separate positive and negative strands of our fasta file, this can be achieved by "grep -A". Then we use "grep -E" to match the canonical or non-canonical sequences to the fasta file of us. Below are some codes to achieve above goal:
grep -A 1 '+' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta > pos.fasta
grep -A 1 '-' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta > neg.fasta
grep -c -E '[AG]GG[AG][ATCG][ATCG][TCA][TCA][CT][CT][CGT]' pos.fasta
grep -c -E '[ACG][AG][AG][TGA][TGA][ATCG][ATCG][CT]CC[TC]' neg.fasta
# The above are for canonical sequence, non-canonical sequences in fig 4b can be applied in the same way.
# End of Exercise 6

echo "Hello I am a message in standard error (stderr)" >&2

echo "Hello I am a message in standard out (stdout)"

