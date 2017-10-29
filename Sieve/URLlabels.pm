=pod
use Sieve::URLlabels;
my $u = new Sieve::URLlabels();
   print Dumper $u->labels();

=cut

package Sieve::URLlabels; # version 1
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(new labels);


use strict; use Data::Dumper;use utf8;
sub new {
  my $pkg = shift;
  my $self; { my %hash; $self = bless(\%hash, $pkg); }
  my $options = {};
  $self->{sortkey} = shift;
 return $self;
}

sub labels {
   my $self = shift;

  return [
    {     
       label =>   q{防具専用売買交換２} ,
       url   =>  q{http://163.44.92.33/topics/1458} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/Armer.yaml} ,
       db_table => q{Armer},
    } ,

    {     
       label =>   q{スキル代行板（真アニマ専用）} ,
       url   =>  q{http://163.44.92.33/topics/3084} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/MakotoOP.yaml} ,
       db_table => q{MakotoOP},
    } ,

    {     
       label =>   q{スキル代行} ,
       url   =>  q{http://163.44.92.33/topics/806} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/NormalOP.yaml} ,
       db_table => q{NormalOP},
    } ,

    {     
       label =>   q{上限進化代行} ,
       url   =>  q{http://163.44.92.33/topics/2903} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/Evolution.yaml} ,
       db_table => q{Evolution},
    } ,

    {     
       label =>   q{武器専用販売交換} ,
       url   =>  q{http://163.44.92.33/topics/1255} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/Weapon.yaml} ,
       db_table => q{Weapon},
    } ,
    {     
       label =>   q{トレ可コア専用交換所} ,
       url   =>  q{http://163.44.92.33/topics/3220} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/enableCores.yaml} ,
       db_table => q{enableCores},
    } ,

    {     
       label =>   q{アバターコレクション} ,
       url   =>  q{http://163.44.92.33/topics/3319} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/Avator.yaml} ,
       db_table => q{Avator},
    } ,
    {     
       label =>   q{売買、交換はこちらで} ,
       url   =>  q{http://163.44.92.33/topics/333} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/Trading.yaml} ,
       db_table => q{Trading},
    } ,
    {     
       label =>   q{継承用武器売買交換} ,
       url   =>  q{http://163.44.92.33/topics/3138} , # you need boke with ?page=number
       file    =>   q{/home/ussr/Dropbox/DB/Sieve/WeaponForInheritance.yaml} ,
       db_table => q{WeaponForInheritance},

    } ,
   ]

}

=pod

author_id: 010600ed55b870e2
  author_name: アクロポラ
  comment_no: 53428
  created_at: 1509243850
  id: 491973
  message: 出

[+]防具専用売買交換２
   size  16470
   item  80
[+]スキル代行板（真アニマ専用）
   size  155803
   item  834
[+]スキル代行
   size  164926
   item  863
[+]上限進化代行
   size  173141
   item  913
[+]武器専用販売交換
   size  184087
   item  929
[+]トレ可コア専用交換所
   size  36311
   item  179
[+]アバターコレクション
   size  23550
   item  127
[+]売買、交換はこちらで
   size  164718
   item  794
[+]継承用武器売買交換
   size  161409
   item  797



=cut

1;
__END__
