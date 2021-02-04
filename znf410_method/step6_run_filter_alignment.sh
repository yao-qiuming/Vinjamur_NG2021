#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 1-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load gcc/6.2.0 bedtools/2.27.1
module load samtools/1.3.1


#repeat this for all samples (and controls)
samtools view -b -q 10 Sample_1.dedup.sorted.bam > Sample_1.dedup.filtered.bam