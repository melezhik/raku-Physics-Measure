#!/usr/bin/env raku
#t/08-syn.t 
#TESTALL$ prove6 ./t      [from root]
use lib '../lib';
use Test;
plan 12; 

use Physics::Measure;

$Physics::Measure::round-val = 0.000001;

#test simple +-*/ diff units 
my $d1 = ♎️ '2 m';
my $d2 = ♎️ '3 feet';

my $a1 = $d1 * $d2;
is ~$a1, '1.8288m^2',                                                           '$a-mul-mixed';

my $di1 = $d1 / $d2;
is "$di1", '2.187227①',                                                          '$di1-div-mixed';

my $ad1 = $d1 + $d2;
is "$ad1", '2.9144m',                                                          '$ad1-add-mixed';

my $su1 = $d1 - $d2;
is "$su1", '1.0856m',                                                          '$su1-sub-mixed';

my $a2 = $d1 * $d1;
is ~$a2, '4m^2',                                                                '$a2-mul-m';

my $a3 = ($d2 * $d2).in('sq ft');
is ~$a3, '9sq ft',                                                              '$a3-mul-feet';

#test compound wo syn 
my $x2 = ♎️ '3 m.s^-1';
is $x2.WHAT, Physics::Measure::Speed,                                           '$x2-WHAT';

my $y2 = ♎️ '4 feet.mins^-1';
is $y2.WHAT, Physics::Measure::Speed,                                           '$y2-WHAT';

my $z2;
$z2 = $x2 * $y2;
is ~$z2, '0.06096Gy',                                             '$z2-mul-m.s-1*feet.mins-1';

$z2 = $x2 / $y2;
is $z2, '147.637795①',                                             '$z2-div-m.s-1/feet.mins-1';

$z2 = $x2 + $y2;
is ~$z2, '3.02032m.s^-1',                                         '$z2-add-m.s-1+feet.mins-1';

$z2 = $x2 - $y2;
is ~$z2, '2.97968m.s^-1',                                         '$z2-sub-m.s-1+feet.mins-1';

#done-testing;

