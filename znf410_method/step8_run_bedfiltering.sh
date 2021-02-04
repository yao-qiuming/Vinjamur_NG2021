#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 1-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load gcc/6.2.0 bedtools/2.27.1
module load samtools/1.3.1



#Genomic regions annotated as part of the ENCODE project blacklist (PMID: 31249361, PMID: 22955616) 
#as problematic regions for alignment of high-throughput functional genomics data 
#were excluded from analysis using files ENCFF001TDO (hg19, Birney lab, EBI) and ENCFF547MET (mm10, Kundaje lab, Stanford) and BEDtools (PMID: 20110278).
bedtools intersect -a Test_vs_control_peaks.bed -b blacklist.bed -v > Test_vs_control_blacklist-filtered.bed