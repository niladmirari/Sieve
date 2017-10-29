 #! /usr/bin/perl

use lib qw{/home/ussr/Dropbox/Sieve/};
use lib qw{/home/ussr/Dropbox/littleCPAN/};
use MyNotify::Invoke;

use utf8; 
use Sieve;

# authodocs
use YAML;
# faster ?
use YAML::Syck;


use Sieve::Grab;
use Sieve::URLlabels;
use strict; use Data::Dumper;

use encoding 'utf-8';

 my $u = new Sieve::URLlabels();

foreach my $itrator (@{$u->labels()}) {
	
	print "[+]" , $itrator->{label} ,"\n";
	 my $data =  (-s $itrator->{file});
	 print "   size  ", $data ,"\n";
	 print "   item  ", scalar @{YAML::LoadFile($itrator->{file})} ,"\n";

} 