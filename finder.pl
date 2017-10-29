use strict;
use utf8;
use Data::Dumper;


use YAML;
# faster ?
use YAML::Syck;
local $YAML::Syck::ImplicitUnicode = 1;


binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8"); use Encode::Argv 'utf8'; 

use Sieve::URLlabels;
my $u = new Sieve::URLlabels();
  my $query =   $ARGV[0] || "相応品";
  #my $query =   "りみ";
  my $limitHour = 240;

foreach my $labels (   @{$u->labels()}   ) {

  print  "   ■　 $labels->{label} \n";
     
      #my $singleYAML  = YAML::LoadFile($labels->{file});
      my $singleYAML  = YAML::Syck::LoadFile($labels->{file});
      #my $AsingleYAML  = YAML::LoadFile($labels->{file}."_Ancient");
      
       
      foreach my $message (@$singleYAML ) {
      my $pastHours = int((time - $message->{created_at}  )  / 3600 ) ;
      
       if (  ($message->{message}=~  /$query/  or $message->{author_name}=~  /$query/  )) {
          print  
       "
   [+] name   $message->{author_name},
       id     $message->{comment_no}, $message->{message}  
      $pastHours  Hours   " .    localtime ($message->{created_at}  )  ,"\n";
         # YAML DAMP 
       }
      }# foreach single YAML
}
