#!/usr/bin/env raku
#t/04-uni.t 
#TESTALL$ prove6 ./t      [from root]
use lib '../lib';
use Test;
plan 37;

use Physics::Measure;

my $u = GetMeaUnit('m');
my Length $a .=new(value => 1e4, units => $u);

ok $a.value == 10000,                                                       '$a.value';
is $a.units.name, 'm',                                                      '$a.units';

my $i1 = DateTime.now;
my $i2 = DateTime.new( '2017-08-10T14:15:27.26Z' );
my $i3 = DateTime.new( '2017-08-10T14:15:37.26Z' );
my Duration $dur = $i3-$i2;

my $v = GetMeaUnit('s');
my Time $t1 .=new(value => $dur, units => $v);    #'10 s'

ok $dur == 10,                                                              'dur';
is $t1.units.name, 's',                                                     '$t.units';
is "$t1", '10s',                                                            '$t.Str';

ok $t1.Duration == 10,                                                      '$t.Duration';
ok $t1.Real == 10,                                                          '$t.Real';

my Time $t2 = ♎️ '5e1 s';       #'50 s'
is ~$t2, '50s',                                                             '$t.default-S';
my Time $t3 = $t1;              #'10 s'
is ~$t3, '10s',                                                             '$t.default-M';
my Time $t4 = ♎️ '172 s';       #'10 s'
is ~$t4, '00:02:52',                                                        '$t.default-R';
my Time $t5 = ♎️ '3e1 s';       #'30 s'
is ~$t5, '30s',                                                             '$t.assign-S';
my Time $t6 = ♎️'42 s';         #'42 s'
is ~$t6, '42s',                                                             '$t.assign-S';

my $t7 = $t1 + $t2;             #60 s
is ~$t7, '00:01:00',                                                        '$t.add-T';
my $t8 = $t3 - $t4;             #-162 s
is ~$t8, '-00:02:42',                                                        '$t-sub-T';
my Duration $d8 = $t8.Duration;
is $d8, -162,                                                               '$t-get Duration';
my Time $t9 = ♎️ '42 s';
$t9 = ♎️ $dur;
is $t9.Duration, 10,                                                        '$t-set Duration';
$t9.value = 5e1;
is $t9.value, 50,                                                           '$t-get value';
is $t9.Real, 50,                                                            '$t-get Real';
is $t9.Str, '50s',                                                          '$t-get Str';
my Time $t10 = ♎️ '2 hours';
is ~$t10, '2hr',	                                                        '$t.units';

#Speed = Length / Time
my Speed $s1;
my $su1 = GetMeaUnit('m/s');
$s1 .=new( value => 14, units => $su1 );
is "$s1", '14m/s',                                                         '$s.named';

my Speed $s2;
$s2 = $s1;
is "$s2", '14m/s',                                                         '$s.assign-M';
my Speed $s3 = ♎️ '17.234 m/s';
is "$s3", '17.234m/s',                                                     '$s.assign-S';

my Length $d = ♎️ '5e1 m';      #'50 m'
$s2 = $d / $t6;
is "$s2", '1.1904761904761905m/s',                                         'div.mixed';

my $x = $d * $d;
is "$x", '2500m^2',                                                        'mul.same';
is $x.WHAT, (Physics::Measure::Area),                                      'mul.type';

my $θ1 = ♎️ <45°30′30″>;
is "$θ1", <45°30′30″>,														'dms Str';
my $θ2 = ♎️ '2.141 radians';
is "$θ2", '2.141radian',													'radian Str';
my $θ3 = $θ1 + $θ2;
ok $θ3.dms( :no-secs ) == (168, 10.71583625055526423),						'add.angles';

$Physics::Measure::round-val = 0.01;

my $nmiles = ♎️ "7 nmiles";
my $hours = ♎️ "3.5 hr";
my $speed = $nmiles / $hours;
is ~$speed.in('knots'), '2knot',											'cmp.round-to';

my $sine = sin( $θ1 );
is-approx $sine, 0.7133523847299412,										'sin.dms';
my $arcsin = asin( $sine, units => '°' );
is "$arcsin", <45°30′30″>,													'asin.dms';

my $emission = ♎️ "11 kg.s-1";
is ~$emission, '11kg.s-1',													'canonical-rt';

#`[FIXME - variable result 11 kg⋅s⁻¹ sometimes]
# my $emission2 = ♎️ "11 kg⋅s⁻¹";
# is ~$emission2, '11kg.s-1',												'pretty-rt';

my $hms1 = ♎️<-02:13:22>;
is $hms1.hms, '- 2 13 22',						                            '.hms';
is ~$hms1, '-02:13:22',                                                     '~hms';
ok +$hms1 == -8002,                                                         '+hms';

my $hms2 = ♎️<427:00:11.11>;
is ~$hms2, '427:00:11',                                                     'more hours';

#done-testing
