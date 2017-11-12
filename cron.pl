 #! /usr/bin/perl

use lib qw{/home/ussr/Dropbox/Sieve/};
use lib qw{/home/ussr/Dropbox/littleCPAN/};
use MyNotify::Invoke;

#use utf8; use warnings;
use Sieve;use YAML;
use Sieve::Grab;
use Sieve::URLlabels;
use strict; use Data::Dumper;

# twitter 部分
  use Net::Twitter;
  use Scalar::Util 'blessed';


  # プログラム
  use Config::Tiny;
  # コンフィグの作成
  my $Config = Config::Tiny->new;
  $Config = Config::Tiny->read( 'file.conf' );
  my $isnotify = $Config->{section}->{isnotify};
  
  use encoding 'utf-8';
    my $TrigerAlerts = [
      #{observer=>"かずき" , query=>"(ルクス|ﾙｸｽ)(メイス|ﾒｲｽ|スタッフ|ｽﾀｯﾌ)"    },
      {observer=>"かずき" , query=>"(アーミン|アミン|ｱｰﾐﾝ)盾"    },
      
      {observer=>"びすこた" , query=> "物土"    },
      {observer=>"びすこた" , query=> "アーミン"    },
      {observer=>"びすこた" , query=> "ビリジアン"    },
      {observer=>"びすこた" , query=> "ラファ"    },
      {observer=>"びすこた" , query=> "(グラ|ｸﾞﾗ).*(メイス|棍)"    },
      #{observer=>"びすこた" , query=> "."    },
      #{observer=>"かに" , query=> "(マイティ|ﾏｲﾃｨ)"    },
      {observer=>"かに" , query=> "(ホーリーメイス|ホーリー棍)"    },
      #{observer=>"トッシュ" , query=> "(アンブラ|アンブラー)盾"    },
      
  ];
      my $MSGBOX = new  MyNotify::Invoke();
      my $u = new Sieve::URLlabels();

foreach my $itrator (@{$u->labels()}) {
## initialaize only taking 10 pages
  #for my $bigpage (0..60){
 # 	  my $page = 61 - $bigpage ;
  sleep 1;
  
  my $page = 1;
  my $g = new Sieve::Grab();
  my $Grab = $g->get($itrator->{url} . qq{?page=$page})->{topics}->{comments};
  
  my $s = new Sieve("comment_no");
     $s->loadArch($itrator->{file});
     my $this_diff = $s->diff($Grab); # this make Write data = Diff data
     
     #die Dumper YAML::Dump($this_diff);
     
     print YAML::Dump($itrator);
     
     if ( scalar @{$this_diff} > 0  ) { # get how many changed
        $s->merge(); # this method will Write DATA = Diff + Arch  
        $s->writeArch($itrator->{file});
        my $diffed =  YAML::Dump( myPrintFilter ($this_diff));
        my $label = $itrator->{label};
        print "        (๑•̀ㅂ•́)و✧　↑　----   NEW DATA from Grab \n";

        $MSGBOX->send(  { title => "$label"  , message => "$diffed" , icon => "ruruha.png" });
        # Alert
          for my $alerts  (@$TrigerAlerts) {
          	  print $diffed ,$alerts->{query}; 
          	  
          	  if ($diffed =~ /$alerts->{query}/im ) {
          	       $MSGBOX->send(  { title => "$alerts->{observer}:$alerts->{query}:$itrator->{label}"  , message => "$diffed" , icon => "ash.jpg" ,urgency => "critical" });
          	       
          	       # Twitter DM
          	       
          	         # As of 13-Aug-2010, Twitter requires OAuth for authenticated requests
                  my $nt =     Net::Twitter->new(
                        traits           => [qw/OAuth API::RESTv1_1/],
                        consumer_key        => q{kMdRb3TIuyujjotzeSxB7UdZH},
                        consumer_secret     => q{XowkkCoCSrQEoaXRqbBptnIEidE5jgM962Gyk2I8pllHMlAHwA},
                        access_token        => q{208083322-nioCCwI6OGRtXb24l38EWM7hylGjgYhf5raR9CBe},
                        access_token_secret => q{U0A6s1P3NYwaZiyQZ5VNNSXpk7zsHuOfcTcNws8EK5Osq},
                        ssl => 1, #これが必要
                   );
           
             my $twitter_screen_name = dictionary_twitter_id()->{$alerts->{observer}};
              print "$alerts->{observer}\n";
              print "$twitter_screen_name\n" ;
           
                  my $twitter_message = template_for_twitter_dm({
                  triger => $alerts->{query},
                  data => "$itrator->{label} \n $diffed",
                  observer =>$alerts->{observer}, });

                 my $result =  $nt->new_direct_message({screen_name=>$twitter_screen_name, text=>qq{$twitter_message}});
          	       
          	  }# Alert armed 
          }# Alert list

     } else {
        print "        (((((((((((っ･ω･)っ ﾌﾞｰﾝ　↑　----   there was no new data from Grab \n";
     }
     
 #}# initial old pages data
} #$u

      $MSGBOX->send(  { title => "cron Sieve::Logress"  , message => "done" ,other_param => "-t 1"});
    
           
sub myPrintFilter { #不要な　[].propatyを排除して表示する

my $data = shift ; # [ {},{},....]
 my @filter = (); 
  foreach my $itr (@$data) {
    my $itr_holder = {} ;
     $itr_holder->{"comment_no"} = $itr ->{"comment_no"};
     $itr_holder->{"name"} = $itr ->{"author_name"};
     $itr_holder->{">"} = $itr ->{"message"};
     
   push @filter ,      $itr_holder; 
  }
return @filter;
}


sub template_for_twitter_dm {
my $arg = shift;
my $triger   = $arg->{triger};
my $data     = $arg->{data};
my $observer = $arg->{observer};

my $template =
"
 †ログレスコミュ巡視プログラム（β）からのお知らせ
 予め登録された　検知トリガー:$triger により
 10秒程前に $observer さん宛にDMが送信されました
　  　 　　　　　 (๑•̀ㅂ•́)و✧

 †以下内容

$data
 
すでに売り切れた場合や資金不足は
　   　　　　　幕末故致し方なし
要望や新規トリガーがあれば　暇そうな時のびすこたまで。
 
 *巡視速度が１２分に１度のため、書き込まれてから最大１２分程ずれがあります。
";

return $template;
}

sub dictionary_twitter_id {

return {
  "かずき" => q{hasirePatrasche},
  "びすこた" => q{niladmirari2010},
  "かに" => q{kani_kani_76},
  "トッシュ" => q{1_handball},
  "マグレロ" => q{@tunarero},
}
}