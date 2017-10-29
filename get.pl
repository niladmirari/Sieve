#!/usr/bin/env perl                                                             

use strict;
use Sieve::Grab;

use encoding 'utf-8';
use Data::Dumper;
{
    package Data::Dumper;
    sub qquote { return shift; }
}
$Data::Dumper::Useperl = 1;

  my $g = new Sieve::Grab();
  print Dumper  $g->get(q{http://163.44.92.33/topics/3084?page=1});
     
