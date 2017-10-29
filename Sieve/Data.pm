=pod

use strict;  # FOR AIMING MORE LOGRESS PROJECT 
use utf8;   use Data::Dumper;
use warnings;

use Sieve::Data;

my $Grab= [
 { name =>"jhon" , $sortkey  => "30"},
 { name =>"shindy" , $sortkey  => "3"},
 { name =>"tom" , $sortkey  => "19"},
];

my $Arch= [
 { name =>"jhon" , $sortkey  => "30"},
 { name =>"tom" , $sortkey  => "19"},
 { name =>"cathy" , $sortkey  => "15"},
 { name =>"mike" , $sortkey  => "12"},
 { name =>"jake" , $sortkey  => "16"},
];

my  $d = new Sieve::Data();
  $d->set($Grab,$Arch);
  $d->sortby("$sortkey");
 print Dumper $d->diffby("$sortkey"); # return diff this example return by shindy
#print Dumper  $d->merge(); # merged data

=cut

package Sieve::Data; # version 1
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(new set items sortby diffby merge);


use strict; use Data::Dumper;use utf8;
sub new {
  my $pkg = shift;
  my $self; { my %hash; $self = bless(\%hash, $pkg); }
  my $options = {};
  $self->{sortkey} = shift;

  $self->{_GRAB_DATA} = [];
  $self->{_ARCH_DATA} = [];
  $self->{_DIFF_DATA} = [];

 return $self;
}


sub set {
   my $self = shift;
   my $GRAB = shift;
   my $ARCH = shift;
   if (   ref($GRAB)   ne "ARRAY"  or  ref($ARCH)   ne "ARRAY"  ) {
       die caller() ," this data is not arrey ref.\n";
   }

  $self->{_GRAB_DATA} = $GRAB;
  $self->{_ARCH_DATA} = $ARCH;
}
sub items {
   my $self = shift;
}

sub sortby{
   my $self = shift;
   my $sortkey =  $self->{sortkey} ;
   my @GRABsorted = sort {+$b->{"$sortkey"} <=> +$a->{"$sortkey"}} @{$self->{_GRAB_DATA}} ;  
   $self->{_GRAB_DATA}  = \@GRABsorted;
   my @ARCHsorted = sort {+$b->{"$sortkey" } <=> +$a->{"$sortkey" }} @{$self->{_ARCH_DATA}} ;  
   $self->{_ARCH_DATA}  = \@ARCHsorted;
}

sub  diffby { # return DIFF
   my $self = shift;
   my $Grab = $self->{_GRAB_DATA};
   my $Arch = $self->{_ARCH_DATA};
   my $sortkey = $self->{sortkey} ;

   
   # Grab : Arch = 1 : 2  
   my $GrabCount = scalar @$Grab ;
   my $ArchCount = scalar @$Arch ;
   my @compressArch = @$Arch;
   if ($ArchCount > $GrabCount * 2 ) {#決め打ちでいいのか・・・？
     @compressArch = @compressArch[0..$GrabCount * 2];  
   }
 
   # check same value
   my $cnt = {}; 

   foreach my $Grabkey (@$Grab){ 
     $cnt->{$Grabkey->{$sortkey }} = 0;
   }
   foreach my $Grabkey (@$Grab){
     foreach my $Archkey (@compressArch){
       if ( $Grabkey->{$sortkey } == $Archkey->{$sortkey})   {
          $cnt->{$Grabkey->{$sortkey }} = +1; # if Grabkey found in Archkey then make flags
       }
    }
   }

   my $Diff = [];
   foreach my $diffkeys (keys %$cnt) {
   if ($cnt->{$diffkeys} == 0) {
       # diff datas $sortkey 
       foreach my $Grabkey (@$Grab){
           if (  $Grabkey ->{$sortkey }  ==  $diffkeys) {
          push   @{$Diff} , $Grabkey ;
       }#foreach
       }
     }#if
   }
   $self->{_DIFF_DATA} = $Diff;
}

sub merge{
   my $self = shift;
   my @commit = ();
   push @commit , @{$self->{_DIFF_DATA}} ;
   push @commit , @{$self->{_ARCH_DATA}} ;
   return \@commit ;
}

1;
__END__
