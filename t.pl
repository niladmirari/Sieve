use strict;
use utf8;   use Data::Dumper; use warnings;
use Sieve;   use YAML;

  
     my $s = new Sieve("id");
     my $file =q{Armer.yaml};
     $s->loadArch($file);

     if ($s->isArchMetabolic() ) {
     warn " big ill try remove Arch to Ancient data ... \n"; 
          my $aGrab =$s->get_ancient() ;
          my $as = new Sieve("id");
           $as->loadArch("Ancient_" .$file);
           my $this_diff = $as->diff($aGrab); # this make Write data = Diff data
           if ( scalar @{$this_diff} > 0  ) { # get how many changed
           $as->merge(); # this method will Write DATA = Diff + Arch  
           $as->writeArch("Ancient_" .$file);
           $as->writeReservedArch($file);
           } else {
           print " there was no new data from Grab \n";
        }
     }

