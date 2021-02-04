#!/bin/bash
#SBATCH -n 4                              
#SBATCH -t 5-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load trimmomatic/0.36

java -jar trimmomatic-0.36.jar PE -threads 4 -trimlog trim.log -phred33 Sample1_Read1.fastq.gz Sample1_Read2.fastq.gz -baseout path-for-output/Sample1_trimmed.fq.gz ILLUMINACLIP:/adapters/TruSeq3-PE.fa:2:15:4:4:true SLIDINGWINDOW:4:15 MINLEN:25