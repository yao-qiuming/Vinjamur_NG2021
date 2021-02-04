#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 1-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load picard/2.8.0
module load gcc/6.2.0 bedtools/2.27.1


java -jar picard-2.8.0.jar SortSam I=Sample1.sam O= Sample1.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true
java -jar picard-2.8.0.jar MarkDuplicates I=Sample1.sorted.bam O=Sample1.dedup.sorted.bam M=Sample1.dedup.txt REMOVE_DUPLICATES=true
bedtools bamtobed -i $sampleID.dedup.sorted.bam > $sampleID.dedup.sorted.bed
cat Sample1.dedup.sorted.bed | awk -v OFS='\t' '{len = $3 - $2; print $0, len }' > Sample1.dedup.sorted.final.bed


####Examples

#sampleID=HUDEP2_HA_30_1

#java -jar $PICARD/picard-2.8.0.jar SortSam I=DB6301_aligned/hg19/$sampleID.sam O=DB6301_aligned/hg19/$sampleID.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true

#java -jar $PICARD/picard-2.8.0.jar MarkDuplicates I=DB6301_aligned/hg19/$sampleID.sorted.bam O=DB6301_aligned/hg19/$sampleID.dedup.sorted.bam M=DB6301_aligned/hg19/$sampleID.dedup.txt REMOVE_DUPLICATES=true

#bedtools bamtobed -i DB6301_aligned/hg19/$sampleID.dedup.sorted.bam > DB6301_aligned/hg19/$sampleID.dedup.sorted.bed

#cat DB6301_aligned/hg19/$sampleID.dedup.sorted.bed | awk -v OFS='\t' '{len = $3 - $2; print $0, len }' > DB6301_aligned/hg19/$sampleID.dedup.sorted.final.bed


#sampleID=ZNF_HA_30_1

#java -jar $PICARD/picard-2.8.0.jar SortSam I=DB6301_aligned/hg19/$sampleID.sam O=DB6301_aligned/hg19/$sampleID.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true

#java -jar $PICARD/picard-2.8.0.jar MarkDuplicates I=DB6301_aligned/hg19/$sampleID.sorted.bam O=DB6301_aligned/hg19/$sampleID.dedup.sorted.bam M=DB6301_aligned/hg19/$sampleID.dedup.txt REMOVE_DUPLICATES=true

#bedtools bamtobed -i DB6301_aligned/hg19/$sampleID.dedup.sorted.bam > DB6301_aligned/hg19/$sampleID.dedup.sorted.bed

#cat DB6301_aligned/hg19/$sampleID.dedup.sorted.bed | awk -v OFS='\t' '{len = $3 - $2; print $0, len }' > DB6301_aligned/hg19/$sampleID.dedup.sorted.final.bed

