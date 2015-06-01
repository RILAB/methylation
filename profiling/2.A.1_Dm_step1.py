
source()





a2 = read_BS_bed("/group/jrigrp4/BS_teo20/BSMAP_output/JRA2_TGACCA_methratio.txt")


x1 = pybedtools.BedTool(a)


for i in range(50):
    sys.stdout.write('\r')
    # the exact output you're looking for:
    sys.stdout.write("Reading [%-50s] %d%%" % ('-'*i, 2*i))
    sys.stdout.flush()
    sleep(0.25)


def read_gene(filename):
    temp = []
    with open(filename, 'r') as infile:
        line1 = infile.readline()
        for line in infile:
            tokens = line.split()
            temp.append([tokens[0], int(tokens[3]) - 1, tokens[4], tokens[5]])
    return temp



gene = read_gene("/home/jolyang/dbcenter/AGP/AGPv3/AGPv3_gene.txt")
onegene = pybedtools.BedTool(['1', '1000','50000'])
