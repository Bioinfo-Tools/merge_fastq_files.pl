merge_fastq_files.pl
====================

A simple Perl script made for merging reads and barcodes generated by Illumina sequencing in fastq format.

#Usage

    Usage: perl merge_fastq_reads.pl 
            -bcfile barcode file in fastq format
            -read1 fastq file with reads from left
            -read2 fastq file with reads from right (if sequences are not paired-ends, this option is not needed)
            -out output file (this will be one fastq file with barcodes, read1 and read2 merged together)


#Example

Bellow are the contents of 3 example files (barcode.fastq, read1.fastq, and read2.fastq).

barcode.fastq:

	@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 2:N:0:
	ACTAAGAA
	+
	########
	@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 2:Y:0:
	ATGCAAAA
	+
	########

read1.fastq

	@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 1:N:0:
	NTGTGCCAGCAGCCGCGGTAATACGGAGGATGCGAGCGTTATCCGGATTTATTGGGCTTAAAGGGTGCGTAGGCGGAATGTCAAGTCAGCGGTAAAATTG
	+
	#1+ADDDD?FFDFIFIG??CFDFIIFIFI;*9BACFFEBEA?DDD><9?BB>A3>?(59::>A35(8?&8?9(4099&2:3+:@:>B344&&)0?AA###
	@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 1:Y:0:
	NAGAGCCAGCACCCGCCCAAACACAGACGATGCGATCCCAACCCCGTCCTCTTCTCTGTAAACGGCCCCTATACGGCTGGGAAAGTCAAGAGACAAATCT
	+
	####################################################################################################

read2.fastq

	@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 3:N:0:
	GGGGACTACGCGGGTATCTAATCCTGTTCGATCCCCCCGCTTTCGGGCCTCAGCGTCAGTTGGGTGCCGGTAGGCTGCCTTCGCAATCGGAGTTTTGGCT
	+
	<<<<@;??@###########################################################################################
	@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 3:Y:0:
	GGGGACTACAGCGGTACCTAATCCTGTTTGATACCCATGCTTCCGAGCCTCCGCCTCACTGCGCCTCCGGTAGGCTGACTTCACTATAGGAGTCCGCCCC
	+
	==<A1)A<2+2+<AC8)?>2<?@#############################################################################

You can run this script for the example files shown above:

    perl merge_fastq_reads.pl -bcfile barcode.fastq -read1 read1.fastq -read2 read2.fastq -out result.fastq


The result for this example will be in the result.fastq file:

result.fastq:

	@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 2:N:0:@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 1:N:0:@HWI-ST382:168:D2CFKACXX:7:1101:2388:1994 3:N:0:
	ACTAAGAANTGTGCCAGCAGCCGCGGTAATACGGAGGATGCGAGCGTTATCCGGATTTATTGGGCTTAAAGGGTGCGTAGGCGGAATGTCAAGTCAGCGGTAAAATTGGGGGACTACGCGGGTATCTAATCCTGTTCGATCCCCCCGCTTTCGGGCCTCAGCGTCAGTTGGGTGCCGGTAGGCTGCCTTCGCAATCGGAGTTTTGGCT
	+
	#########1+ADDDD?FFDFIFIG??CFDFIIFIFI;*9BACFFEBEA?DDD><9?BB>A3>?(59::>A35(8?&8?9(4099&2:3+:@:>B344&&)0?AA###<<<<@;??@###########################################################################################
	@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 2:Y:0:@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 1:Y:0:@HWI-ST382:168:D2CFKACXX:7:1101:2839:1990 3:Y:0:
	ATGCAAAANAGAGCCAGCACCCGCCCAAACACAGACGATGCGATCCCAACCCCGTCCTCTTCTCTGTAAACGGCCCCTATACGGCTGGGAAAGTCAAGAGACAAATCTGGGGACTACAGCGGTACCTAATCCTGTTTGATACCCATGCTTCCGAGCCTCCGCCTCACTGCGCCTCCGGTAGGCTGACTTCACTATAGGAGTCCGCCCC
	+
	############################################################################################################==<A1)A<2+2+<AC8)?>2<?@#############################################################################
