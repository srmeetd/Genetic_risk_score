#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
my $weights=undef;
my $dosages=undef;
my $grs=undef;
GetOptions(
  "weights=s"    => \$weights,
  "dosages=s"    => \$dosages,
  "grs=s"        => \$grs,
);
if($weights && $dosages && $grs){
open(my $in,$weights) or die $!;
my %beta=();
my %ea=();
my %nea=();
while(<$in>){
    chomp;
    my @F=split(' ');
    if($F[3] > 0){
        $beta{$F[0]}=$F[3];
        $ea{$F[0]}=$F[1];
        $nea{$F[0]}=$F[2];
    }else{
        $beta{$F[0]}=-$F[3];
        $ea{$F[0]}=$F[2];
        $nea{$F[0]}=$F[1];
    }
}
close($in);
open($in,$dosages) or die $!;
open(my $out,">",$grs);
print $out "id\tscore\n";
my $line=<$in>;
chomp $line;
my @head=split(' ',$line);
for(my $i=1;$i<@head;$i++){
  my @G=split("_",$head[$i]);
  if(!exists $beta{$G[0]}){
    print "Warning, no weight for SNP ".$head[$i]."\n";
  }
}
while(<$in>){
    chomp;
    my @F=split(' ');
    my $score=0;
    for(my $i=1;$i<@F;$i++){
        my @G=split("_",$head[$i]);
        if(uc($ea{$G[0]}) eq uc($G[2]) && uc($nea{$G[0]}) eq uc($G[1])){
            $score+=$F[$i]*$beta{$G[0]};
        }elsif(uc($ea{$G[0]}) eq uc($G[1]) && uc($nea{$G[0]}) eq uc($G[2])){
            $score+=(2-$F[$i])*$beta{$G[0]};
        }else{
            print "Error\n";
        }
    }
    print $out $F[0]."\t".$score."\n";
}
close($out);
close($in);
}else{
    print "\n\tUsage\n\t--weights\tsnp weightings\n\t--dosages\tdosage file\n\t--grs\t\toutput filename\n\n";
}
