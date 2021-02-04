#!/bin/bash
#SBATCH -n 4                              
#SBATCH -t 5-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G



#Sequencing data obtained from CUT&RUN experiments were analyzed using the following scripts. 
#The workflow was largely adapted from previous protocols (PMID: 29651053,PMID: 29606353), 
#with the addition of data filtering based on recently published findings of the ENCODE project (PMID: 31249361, PMID: 22955616)

module load FastQC/0.11.3
module load Trimmomatic/0.36
module load Bowtie2/2.2.9
module load Samtools/1.3.1
module load Picard/2.8.0
module load Bedtools/2.27.1
module load Deeptools/3.0.2
module load Macs2/2.1.1.20160309

