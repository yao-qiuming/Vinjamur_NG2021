import sys
import matplotlib.pyplot as plt
motif_bed_file = sys.argv[1]
motif_bin_file = sys.argv[2]
#Example:
#motif_bed_file = "hg19_MA0752.1_ZNF410_1e5.bed"
#motif_bin_file = "hg19_MA0752.1_ZNF410_1e5.bed__3000__100__cutoff_1.csv"
csv_file = "reassigned"+"__"+motif_bin_file

#figure_file = output_name+".png"
#csv_file = output_name+".csv"
chromosome_order=['chr1','chr2','chr3','chr4','chr5','chr6','chr7','chr8','chr9','chr10',
                 'chr11','chr12','chr13','chr14','chr15','chr16','chr17','chr18','chr19','chr20',
                 'chr21','chr22','chrX','chrY']

chromosome_size={"chr1":249250621,
"chr2":243199373,
"chr3":198022430,
"chr4":191154276,
"chr5":180915260,
"chr6":171115067,
"chr7":159138663,
"chrX":155270560,
"chr8":146364022,
"chr9":141213431,
"chr10":135534747,
"chr11":135006516,
"chr12":133851895,
"chr13":115169878,
"chr14":107349540,
"chr15":102531392,
"chr16":90354753,
"chr17":81195210,
"chr18":78077248,
"chr20":63025520,
"chrY":59373566,
"chr19":59128983,
"chr22":51304566,
"chr21":48129895}

def calculate_block_index(position,blocklen,blockoverlap):
    return int(position/(blocklen-blockoverlap))

def calculate_block_indexes_region(startposition,endposition,blocklen,blockoverlap):
    EPSILON=0.01
    startblock=calculate_block_index(startposition,blocklen,blockoverlap)
    endblock=calculate_block_index(endposition-EPSILON,blocklen,blockoverlap)
    startblock=int((startposition-EPSILON-blocklen)/(blocklen-blockoverlap))+1
    return (startblock,endblock)

def calculate_coordinates_from_block(chromnum, blocknum, chromosome_block_start_numbers_map, blocklen,blockoverlap):
    startblock=chromosome_block_start_numbers_map[chromnum]
    startposition=(blocknum-startblock)*(blocklen-blockoverlap)
    endposition=startposition+blocklen
    return (startposition,endposition)

def motif_within_bin(motifchrom,motifstart,motifend, chrom, start, end):
    result = False
    if motifchrom == chrom and motifstart>=start and motifstart<end:
        result = True
    return result

density_map={}
with open(motif_bin_file,'r') as inputfile:
    for inputline in inputfile:
        inputline=inputline.strip()
        if inputline!='':
            inputitems=inputline.split(",")
            count = int(inputitems[0])
            coorstr = inputitems[1].strip()
            pos1 = coorstr.find(":")
            pos2 = coorstr.find("-")
            chrom = coorstr[0:pos1]
            start = int(coorstr[pos1+1:pos2])
            end = int(coorstr[pos2+1:])
            key = (chrom, start,end)
            density_map[key]=count


with open(motif_bed_file,'r') as inputfile:
    for inputline in inputfile:
        inputline=inputline.strip()
        if inputline!='':
            hit_bin_list=[]
            maxcount=0
            maxbin=("chr1",0,0)
            inputitems=inputline.split("\t")
            chrnum=inputitems[0]
            startposition=int(inputitems[1].strip())
            endposition=int(inputitems[2].strip())
            for binid in density_map.keys():
                count = density_map[binid]
                if motif_within_bin(chrnum,startposition,endposition,binid[0],binid[1],binid[2]):
                    hit_bin_list.append(binid)
                    if count>maxcount:
                        maxcount=count
                        maxbin=binid
            for binid in hit_bin_list:
                if binid!=maxbin and density_map[binid]>0:
                    density_map[binid]=density_map[binid]-1
            
'''
blocklen = window_size
blockoverlap = window_overlap
chromosome_block_numbers_map={}
chromosome_block_start_numbers_map={}
previous_accum=0
for chrnum in chromosome_order:
    chrsize=int(chromosome_size[chrnum])
    blocknum=calculate_block_index(chrsize,blocklen,blockoverlap)+1
    chromosome_block_numbers_map[chrnum]=blocknum
    chromosome_block_start_numbers_map[chrnum]=previous_accum
    previous_accum=previous_accum+blocknum
   
density_vector=[0]*sum(chromosome_block_numbers_map.values())
with open(motif_bed_file,'r') as inputfile:
    for inputline in inputfile:
        inputline=inputline.strip()
        if inputline!='':
            inputitems=inputline.split("\t")
            chrnum=inputitems[0]
            startposition=int(inputitems[1].strip())
            endposition=int(inputitems[2].strip())
            (startblock,endblock)=calculate_block_indexes_region(startposition,endposition,blocklen,blockoverlap)
            startblock=chromosome_block_start_numbers_map[chrnum]+startblock
            endblock=chromosome_block_start_numbers_map[chrnum]+endblock
            for i in range(startblock,endblock+1):
                density_vector[i]=density_vector[i]+1
density_map={}
for chromnum in chromosome_order:
    for i in range(0, chromosome_block_numbers_map[chromnum]):
        blocknum=chromosome_block_start_numbers_map[chromnum]+i
        (start, end) = calculate_coordinates_from_block(chromnum, blocknum, chromosome_block_start_numbers_map, blocklen,blockoverlap)
        coorstr=str(chromnum)+":"+str(start)+"-"+str(end)
        value=density_vector[blocknum]
        if value>=count_cut_off:
            density_map[coorstr]=value
'''

density_map2={}
for binid in density_map.keys():
    count = density_map[binid]
    coorstr = binid[0]+":"+str(binid[1])+"-"+str(binid[2])
    density_map2[coorstr]=count

out_csv = open(csv_file,"w")
d = density_map2
plot_vector = []
for w in sorted(d, key=d.get, reverse=True):
    #print(w, d[w])
    plot_vector.append(d[w])
    outstring=str(d[w])+","+w+"\n"
    out_csv.write(outstring)
out_csv.close()
'''
fig = plt.figure(figsize=(10,10))
ax = fig.add_subplot(111)
plt.plot(plot_vector,'ko')
plt.xlabel('1kb block')
plt.ylabel('motif count')
plt.savefig(figure_file)
'''
