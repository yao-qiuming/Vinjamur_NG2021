# Locus specific per nulceotide Tn5 cleavage by ATAC-seq 
# Input: reads_file .bedpe file 
# Input: locus_file "ID chr start end" format
# The padding variable allows to broaden the locus 
# Normalizes for sequencing depth through mapped_reads variable 

from __future__ import print_function
import sys

locus_file = sys.argv[1]
reads_file = sys.argv[2]
mapped_reads = int(sys.argv[3])

padding = 0
locus_dict = {}
footprint_dict = {}
scaling_factor = mapped_reads / 1000000
file_id = (reads_file.split('.'))[0]

infile = open(locus_file)
for line in infile:
    line = line.strip().split()
    ID = line[0]
    chrom = line[1]
    start_locus = int(line[2]) - padding
    end_locus = int(line[3]) + padding
    locus_ID = ID + '_' +  chrom + '_' + str(start_locus) + '_' + str(end_locus)
    locus_size = end_locus - start_locus
    footprint_dict[locus_ID] = [0] * locus_size
    if chrom not in locus_dict:
        locus_dict[chrom] = [locus_ID]
    else:
        locus_dict[chrom].append(locus_ID) 

#print(locus_dict)
    
infile = open(reads_file)
for rawline in infile:
    line = rawline.strip().split()
    chrom = line[0]
    start_read = int(line[1]) 
    end_read = int(line[5])    
    if chrom in locus_dict:
        for locus in locus_dict[chrom]:
            locus = locus.split('_')
            ID = locus[0]
            start_locus = int(locus[2])
            end_locus = int(locus[3])
            locus_ID = ID + '_' + chrom + '_' + str(start_locus) + '_' + str(end_locus)
            if start_read >= start_locus and start_read < end_locus:
                relative_read_start = start_read - start_locus
                footprint_dict[locus_ID][relative_read_start] = footprint_dict[locus_ID][relative_read_start] + 1
                print(rawline)
            if end_read >= start_locus and end_read < end_locus:
                relative_read_end = end_read - start_locus
                footprint_dict[locus_ID][relative_read_end] = footprint_dict[locus_ID][relative_read_end] + 1 
                print(rawline)
                
for locus_ID in footprint_dict:
    footprint_list = footprint_dict[locus_ID]
    for footprint in footprint_list:
        footprint = footprint #/ scaling_factor
        print(footprint, file=open(file_id + '_'+locus_ID + '_footprint.txt', "a"))

for locus_ID in footprint_dict:
    footprint_list = footprint_dict[locus_ID]
    locus = locus_ID.split('_')
    chrom = locus[1]
    start = int(locus[2])
    end = start + 1
    #for footprint in footprint_list:
    for i in range(0, len(footprint_list)):
        footprint = footprint_list[i]
        #footprint = footprint #/ scaling_factor
        start_locus = int(start + i)
        end_locus = start_locus + 1
        footprintstring = chrom+"\t"+str(start_locus)+"\t"+str(end_locus)+"\t"+str(int(footprint))
        print(footprintstring, file=open(file_id + '_'+locus_ID + '_footprint.bedgraph', "a"))
