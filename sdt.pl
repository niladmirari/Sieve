use strict;
use utf8;   use Data::Dumper;
use warnings;

use Sieve::Data;

my $Grab= [
 { name =>"jhon" , id => "30"},
 { name =>"shindy" , id => "34"},
 { name =>"tom" , id => "19"},
];

my $Arch= [
 { name =>"jhon" , id => "30"},
 { name =>"tom" , id => "19"},
 { name =>"cathy" , id => "15"},
 { name =>"mike" , id => "12"},
 { name =>"jake" , id => "16"},
];

my  $d = new Sieve::Data("id");
  $d->set($Grab,$Arch);
  $d->sortby();
 print Dumper $d->diffby(); # return diff this example return by shindy
#print Dumper  $d->merge(); # merged data
















