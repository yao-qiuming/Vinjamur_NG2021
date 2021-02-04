#!/bin/bash
#SBATCH -n 4                              
#SBATCH -t 5-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


#check sequence quality for paired-end reads

zcat *.fastq.gz
fastqc Sample1_Read1.fastq
fastqc Sample1_Read2.fastq
