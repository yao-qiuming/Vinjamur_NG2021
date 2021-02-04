#!/bin/bash
#SBATCH -n 4                              
#SBATCH -t 2-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G

module load gcc/6.2.0 samtools/1.3.1 bowtie2/2.2.9

#index folder
BOWTIE2_IDX=./bowtie2_indexes/hg19 


#bowtie2 --end-to-end --no-unal --no-mixed --no-discordant --dovetail --phred33 -p 4  -x $BOWTIE2_IDX -1 DB6301_trimmed/ZNF_HA_30_2_1P.fq.gz -2 DB6301_trimmed/ZNF_HA_30_2_2P.fq.gz -S DB6301_aligned/hg19/ZNF_HA_30_2.sam

bowtie2 --end-to-end --no-unal --no-mixed --no-discordant --dovetail --phred33 -p 4  -x ${BOWTIE2_IDX} -1 Sample1_trimmed_1P.fq.gz -2 Sample1_trimmed_2P.fq.gz -S Sample1.sam