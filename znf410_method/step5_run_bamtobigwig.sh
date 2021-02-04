#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 1-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load gcc/6.2.0 bedtools/2.27.1
module load samtools/1.3.1

#This is for visualization in IGV, otherwise, skip this step.

samtools index Sample1.dedup.sorted.bam
bamCoverage --bam Sample1.dedup.sorted.bam -o Sample1.dedup.sorted.bw --binSize 10
