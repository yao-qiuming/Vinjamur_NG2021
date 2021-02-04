#!/bin/bash
#SBATCH -n 4                              
#SBATCH -t 5-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=64G

module load gcc/6.2.0  python/2.7.12
module load macs2/2.1.1.20160309


sampleID=Sample
controlID=Control
outputID=Sample_vs_Control
macs2 callpeak -f BAMPE -t ${sampleID}_Replicate-1.dedup.filtered.bam ${sampleID}_Replicate-2.dedup.filtered.bam ${sampleID}_Replicate-3.dedup.filtered.bam \
    -c ${controlID}_Replicate-1.dedup.filtered.bam ${controlID}_Replicate-2.dedup.filtered.bam ${controlID}_Replicate-3.dedup.filtered.bam \
    -B -g hs -q 0.05 -n ${outputID}


###Examples

#sampleID=ZNF_HA_30
#controlID=ZNF_IgG_30
#controlID2=HUDEP2_HA_30
#outputID=ZNF_vs_IgG_HUDEP2_30

#macs2 callpeak -f BAMPE -t DB6301_aligned/hg19/${sampleID}_2.dedup.sorted.bam DB6301_aligned/hg19/${sampleID}_3.dedup.sorted.bam \
#    -c DB6301_aligned/hg19/${controlID}_1.dedup.sorted.bam DB6301_aligned/hg19/${controlID}_2.dedup.sorted.bam DB6301_aligned/hg19/${controlID}_3.dedup.sorted.bam \
#    DB6301_aligned/hg19/${controlID2}_1.dedup.sorted.bam DB6301_aligned/hg19/${controlID2}_2.dedup.sorted.bam DB6301_aligned/hg19/${controlID2}_3.dedup.sorted.bam \
#    -B -g hs -q 0.05 -n ./DB6301_macs2/$outputID 

#sampleID=ZNF_HA_60
#controlID=ZNF_IgG_60
#controlID2=HUDEP2_HA_60
#outputID=ZNF_vs_IgG_HUDEP2_60

#macs2 callpeak -f BAMPE -t DB6301_aligned/hg19/${sampleID}_1.dedup.sorted.bam DB6301_aligned/hg19/${sampleID}_2.dedup.sorted.bam \
#    -c DB6301_aligned/hg19/${controlID}_1.dedup.sorted.bam DB6301_aligned/hg19/${controlID}_2.dedup.sorted.bam DB6301_aligned/hg19/${controlID}_3.dedup.sorted.bam \
#    DB6301_aligned/hg19/${controlID2}_1.dedup.sorted.bam DB6301_aligned/hg19/${controlID2}_2.dedup.sorted.bam DB6301_aligned/hg19/${controlID2}_3.dedup.sorted.bam \
#    -B -g hs -q 0.05 -n ./DB6301_macs2/$outputID


