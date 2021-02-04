#!/bin/bash
#SBATCH -n 1                              
#SBATCH -t 3-00:00                         # in D-HH:MM format
#SBATCH -p medium                           # Run in short partition
#SBATCH --mem=32G


module load picard/2.8.0
module load gcc/6.2.0 bedtools/2.27.1
module load samtools/1.3.1


# This is to visualize the signals within the locus. Bedgraph will be the output

outputfolder="output"

inputbamfile="znf410sample.bam"
sampleID="znf410sample"


java -jar $PICARD/picard-2.8.0.jar SortSam I=$inputbamfile O=${sampleID}.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true

java -jar $PICARD/picard-2.8.0.jar MarkDuplicates I=${sampleID}.sorted.bam O=${sampleID}.dedup.sorted.bam M=${sampleID}.dedup.txt REMOVE_DUPLICATES=true

samtools sort -n -o ${outputfolder}/${sampleID}.namesorted.bam ${sampleID}.dedup.sorted.bam
bedtools bamtobed -i ${outputfolder}/${sampleID}.namesorted.bam -bedpe > ${outputfolder}/${sampleID}.namesorted.bedpe

python locus_specific_footprinting_cal.py CHD4_ZNF-bind_locus.txt ${outputfolder}/${sampleID}.namesorted.bedpe 10282707 >  ${outputfolder}/temp.txt
python locus_specific_footprinting_cal.py CHD4_ZNF-bind_locus_2.txt ${outputfolder}/${sampleID}.namesorted.bedpe 10282707 >  ${outputfolder}/temp.txt


echo Ending time is $(date)
