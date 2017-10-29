 #! /usr/bin/perl

use lib qw{/home/ussr/Dropbox/Sieve/};
use lib qw{/home/ussr/Dropbox/littleCPAN/};
use MyNotify::Invoke;

#use utf8; use warnings;
use Sieve;use YAML;
use Sieve::Grab;
use Sieve::URLlabels;
use strict; use Data::Dumper;

  # プログラム
  use Config::Tiny;
  # コンフィグの作成
  my $Config = Config::Tiny->new;
  $Config = Config::Tiny->read( 'file.conf' );
  my $isnotify = $Config->{section}->{isnotify};
  
use encoding 'utf-8';
      my $MSGBOX = new  MyNotify::Invoke();
my $u = new Sieve::URLlabels();

foreach my $itrator (@{$u->labels()}) {
## initialaize only taking 10 pages
  #for my $bigpage (0..30){
  #	  my $page = 31 - $bigpage ;
  
  sleep 2;
  
  my $page = 1;
  my $g = new Sieve::Grab();
  my $Grab = $g->get($itrator->{url} . qq{?page=$page})->{topics}->{comments};
  
  my $s = new Sieve("id");
     $s->loadArch($itrator->{file});
     my $this_diff = $s->diff($Grab); # this make Write data = Diff data
     
     if ( scalar @{$this_diff} > 0  ) { # get how many changed
        $s->merge(); # this method will Write DATA = Diff + Arch  
        $s->writeArch($itrator->{file});
        my $diffed =  YAML::Dump( myPrintFilter ($this_diff));
        my $label = $itrator->{label};
      
      $MSGBOX->send(  { title => "$label"  , message => "$diffed" , icon => "ruruha.png" });
           
     } else {
        print "  ----   there was no new data from Grab \n";
        print YAML::Dump($itrator);
     }    
  #}# initial old pages data
} #$u

      $MSGBOX->send(  { title => "cron Sieve::Logress"  , message => "done" ,other_param => "-t 1"});
    
           
sub myPrintFilter { #不要な　[].propatyを排除して表示する

my $data = shift ; # [ {},{},....]
 my @filter = (); 
  foreach my $itr (@$data) {
    my $itr_holder = {} ;
     $itr_holder->{"name"} = $itr ->{"author_name"};
     $itr_holder->{">"} = $itr ->{"message"};
   push @filter ,      $itr_holder; 
  }
return @filter;
}