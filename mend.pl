use strict;
use utf8; use Encode;
use Data::Dumper;use YAML;
# faster ?

use YAML::Syck;
    local $YAML::Syck::ImplicitUnicode = 1;

    binmode(STDOUT, ":utf8");
    binmode(STDIN, ":utf8"); use Encode::Argv 'utf8'; 

    use Term::UI;
    use Term::ReadLine;
    my $term = Term::ReadLine->new('brand');

    use Sieve::URLlabels;
    my $u = new Sieve::URLlabels();
    my $query = ""; my $limitHour;


  my $cntResult = 0;    
  foreach my $labels (   @{$u->labels()} ) {
      my $singleYAML  = YAML::Syck::LoadFile($labels->{file});
      my $tainted_flag = 0;
      my @cleanUP = ();
      my $record = {};
      my $cntCorrision = 0;
      
      foreach my $message (@$singleYAML ) {
      $record->{$message->{comment_no}}++;
         if ($record->{$message->{comment_no}} == 1) {
            push (@cleanUP,$message);
         } elsif($record->{$message->{comment_no}} >= 2 ) {
          #conflict detected
           print "___warn___ (T_T) data colision has detencted  $record->{$message->{comment_no}} \n";
           print "    $labels->{file}\n";
           print YAML::Syck::Dump $message;
           $tainted_flag = 1;
           $cntCorrision++;
         }
      }# foreach single YAML

      if (0 and $tainted_flag) {         
           print " i will remake correct data ☆（ゝω・）vｷｬﾋﾟ\n" ;
           system (qq{cp $labels->{file} $labels->{file}_broken} . time);
           system (qq{rm $labels->{file}});
           YAML::Syck::DumpFile($labels->{file} ,\@cleanUP);
      }
      
      # making report 
      
      if ($cntCorrision == 0) {
           print "System data is all green score \n" ;
      }
      
      
      
 # YAML::Syck::DumpFile($labels->{file} ."_clean",\@cleanUP);  
  #print " ------ matched ﾄﾞ━(ﾟДﾟ)━ﾝ!! \n";
  }# $labels






  

