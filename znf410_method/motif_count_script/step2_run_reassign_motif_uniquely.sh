#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 0-05:00                         # in D-HH:MM format
#SBATCH -p short                           # Run in short partition
#SBATCH --mem=32G
#SBATCH -o run_reassign_motif_uniquely_07252020.out
#SBATCH -e run_reassign_motif_uniquely_07252020.err


module load gcc/6.2.0
module load python/3.7.4


#source znf410project/bin/activate
#pip install matplotlib

echo Running on host $(hostname)
echo Starting time is $(date)

python reassign_motif_uniquely.py hg19_MA0752.1_ZNF410_1e5.bed hg19_MA0752.1_ZNF410_1e5.bed__3000__100__cutoff_0.csv

awk -F'[,:-]' '{print $2 "\t" $3 "\t" $4 "\t" $1}' reassigned__hg19_MA0752.1_ZNF410_1e5.bed__3000__100__cutoff_0.csv > reassigned__hg19_MA0752.1_ZNF410_1e5.bed__3000__100__cutoff_0.bed

echo Ending time is $(date)
