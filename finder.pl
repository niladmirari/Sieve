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
    
    
    my $query = ""; my $limitHour; my $searchSpectra ;

while (1) {
    print '   you can use regular explession , like (2\.0|２．０|2|２)be care especialy 真アニマ' . "\n";
    $query = decode("utf8",$term->get_reply(prompt => 'search param', default => encode("utf8",$query)  , ));# Encode非対応なのでは。
    
        $searchSpectra  = $term->get_reply(
                    prompt => 'set Search Spectra ',
                    choices => [qw|all MakotoOP Evolution|],
                    default => $searchSpectra || "all",
        );

        $limitHour = $term->get_reply( prompt => 'set time span', default => $limitHour  || '240', );
    my $DataFlag = $term->get_reply( prompt => ' CAUTION DATA FLG Y/n', default => 'n', );

  my $cntResult = 0;    
  foreach my $labels (   @{$u->labels()}   ) {
  	  if ( ($searchSpectra ne "all") and  ($searchSpectra ne $labels->{db_table})) {
  	     next ;
  	  }
  	  	     	  
  	  
  print  "   ■　 $labels->{label} \n";
     
      my $singleYAML  = YAML::Syck::LoadFile($labels->{file});
      foreach my $message (@$singleYAML ) {
      my $pastHours = int((time - $message->{created_at}  )  / 3600 ) ;
      
 if ($pastHours <= $limitHour    and   
       	     ($message->{message}=~  /$query/i  or $message->{author_name}=~ /$query/i  )
       	   ) {

 print " [full_data]
  author_id   $message->{author_id}     
       "  if ($DataFlag eq q{Y})  ;
       	     
 print " [+] name   $message->{author_name},
  id     $message->{comment_no}, $message->{message}  
   $pastHours  Hours   " .    localtime ($message->{created_at}  )  ,"\n";
  
   $cntResult++;
 }# data match if
      }# foreach single YAML
  }# $labels
  
  print " ------ matched $cntResult \n";
  
}# while 
