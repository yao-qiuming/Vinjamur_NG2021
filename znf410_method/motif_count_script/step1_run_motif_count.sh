#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 0-02:00                         # in D-HH:MM format
#SBATCH -p short                           # Run in short partition
#SBATCH --mem=4G
#SBATCH -o run_motif_count_3000_0_0.out
#SBATCH -e run_motif_count_3000_0_0.err


module load gcc/6.2.0
module load python/3.7.4
#source znf410project/bin/activate
#pip install matplotlib

echo Running on host $(hostname)
echo Starting time is $(date)

python motif_count.py hg19_MA0752.1_ZNF410_1e5.bed 3000 0 0

echo Ending time is $(date)
