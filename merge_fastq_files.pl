#!/usr/bin/perl -w

############################################################

use Getopt::Long;
use File::Basename;


#my %parameters;
#getopts( 'bcfile:read1:read2:out:', \%parameters );    #Takes parameters
GetOptions ("bcfile=s" => \$bcfile,    # numeric
                    "read1=s"   => \$read1,      # string
                    "out=s"  => \$out,
                    "read2=s"  => \$read2
                    );  # flag

unless ( $bcfile && $read1 && $out ) {
    print "Usage: perl merge_fastq_reads.pl 
        -bcfile barcode file in fastq format
        -read1 fastq file with reads from left
        -read2 fastq file with reads from right (if sequences are not paired-ends, this option is not needed)
        -out output file (this will be one fastq file with barcodes, read1 and read2 merged together)\n";
    exit;
}




################Check INPUT FILE########################
$barcodefile = $bcfile;
unless ( open( READ0, "$barcodefile" ) ) {
print "Error: Unable to open file $barcodefile.\n";
exit;
}
###########################################################
                                                                      

################Check INPUT FILE########################
$read1file = $read1;
unless ( open( READ1, "$read1file" ) ) {
print "Error: Unable to open file $read1file.\n";
exit;
}
###########################################################
                                                                      

################Check INPUT FILE########################
$read2file = $read2;
unless ( open( READ2, "$read2file" ) ) {
$paired = "no";
#exit;
}else{$paired="yes"}
###########################################################
                                                                      

###################Create OUTPUT###########################
$outfile = $out;
unless ( open( OUT, ">$outfile" ) ) {
print "Error: Unable to open output file $outfile.\n";
exit;
}
###########################################################


read_fastq($paired);


sub read_fastq {
    
    $paired = shift;
    
    $linecount = 1;
    
    my $bcline;
    
    while ( $bcline = <READ0> ) {
        
        $read1line = <READ1>;
        
             chomp($bcline);
             chomp($read1line);
                
        if ($linecount != 3){
   
            if ($paired eq "yes"){
                $read2line = <READ2>;
                chomp($read2line);
               
                print OUT "$bcline"."$read1line"."$read2line\n";
            }else{
                chomp($bcline);
                print OUT "$bcline"."$read1line\n";
            }
        }else{
            
            if ($paired eq "yes"){
                $read2line = <READ2>;
                chomp($read2line);
            }
            
            print OUT "$bcline\n";
            }
        
        
        if($linecount == 4){
   
            $linecount = 1;
            
        }else{$linecount++;}
        
    }


}
