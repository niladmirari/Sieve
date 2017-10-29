package Sieve;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(new loadArch writeArch diff merge isArchMetabolic get_reserved writeReservedArch);
=pod

use strict;
use utf8;   use Data::Dumper; use warnings;
use Sieve;   use YAML;

my $Grab= [
 { name =>"jhon" , id => 30},
 { name =>"shindy" , id => 34},
 { name =>"tom" , id => 19},
];
  
     my $s = new Sieve("id");
     #$s->loadArch("test.yaml");
     $s->loadArch("result.yaml");
     my $this_diff = $s->diff($Grab); # this make Write data = Diff data
     if ( scalar @{$this_diff} > 0  ) { # get how many changed
        $s->merge(); # this method will Write DATA = Diff + Arch  
        $s->writeArch("result.yaml");
        print Dumper $this_diff;
     } else {
        print " there was no new data from Grab \n";
     }
=cut


use Sieve::Data;
use Data::Dumper ;
#use YAML; 
use YAML::Syck;
 local $YAML::Syck::ImplicitUnicode = 1;


sub new {
  my $pkg = shift;
  my $self; { my %hash; $self = bless(\%hash, $pkg); }
  my $options = {};
     $self->{_ARCH_DATA} = {};
     
     $self->{_Ancient_DATA} = {};
     $self->{_Reserved_Arch_DATA} = {};
     
     $self->{_Merge_DATA} = {};
  
   $self->{_Write_DATA} = {};
  $self->{_SieveDataOnject} = new Sieve::Data(shift);
  
  
  $self->{_filesize} = 0;
  $self->{_isArchMetabolic} = 0;


return $self;
}

sub loadArch {
   my $self = shift;
   my $file_name = shift;
   
   if (-e $file_name) {
    #$self->{_ARCH_DATA} =  YAML::LoadFile($file_name);
    $self->{_ARCH_DATA} =  LoadFile($file_name);
    $self->{filesize} = -s $file_name;
   } else {
   	warn " no loadable file exits ... \n";
    $self->{_ARCH_DATA} = [];
   }
   
   
   
 }
 
sub isArchMetabolic {
   my $self = shift;
   
   my @tmp = @{$self->{_ARCH_DATA}};
   if ( scalar @tmp >= 100 ) {
   	   @reserved = @tmp[0..98];
   	   @ancient = @tmp[99..scalar @tmp -1];
   	   $self->{_Reserved_Arch_DATA} = \@reserved;
       $self->{_Ancient_DATA} =       \@ancient;
    return 1;
   } else {
    return 0;
   } 
   
=pod
    #aicientize 
    
     if ($s->isArchMetabolic() ) { # there are more than 100 items in ARCH
     warn "Arch is big ill try remove Arch to Ancient data ... \n"; 
          my $aGrab =$s->get_ancient() ;
          my $as = new Sieve("id");
           $as->loadArch($itrator->{file}."_Ancient");
           my $this_diff = $as->diff($aGrab); # this make Write data = Diff data
           if ( scalar @{$this_diff} > 0  ) { # get how many changed
           $as->merge(); # this method will Write DATA = Diff + Arch  
           $as->writeArch($itrator->{file}."_Ancient");
           $as->writeReservedArch($itrator->{file});
           } else {
           print " there was no new data from Grab \n";
        }
     }
=cut
   
}

sub get_ancient {
   my $self = shift;
     return \@ancient;
}

sub get_reserved {
   my $self = shift;
     return \@reserved;
}

sub writeArch {
   my $self = shift;
   #YAML::DumpFile(shift, $self->{_Write_DATA});
   DumpFile(shift, $self->{_Write_DATA});
}

sub writeReservedArch {
   my $self = shift;
   #YAML::DumpFile(shift,  \@reserved);
   DumpFile(shift,  \@reserved);
}

sub diff {
   my $self = shift;
   my $G = shift;
   
   #die Dumper ref $self->{_ARCH_DATA};
   $self->{_SieveDataOnject}->set($G,$self->{_ARCH_DATA});
   
   $self->{_SieveDataOnject}->sortby();
   $self->{_Write_DATA} = $self->{_SieveDataOnject}->diffby(); # return diff this example return by shindy 
}


sub merge {
   my $self = shift;
   $self->{_Write_DATA} = $self->{_SieveDataOnject}->merge(); # return diff this example return by shindy
}



1;
__END__
