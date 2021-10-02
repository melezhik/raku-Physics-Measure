#!/usr/bin/env raku
#t/13-nrm.t 
#TESTALL$ prove6 ./t      [from root]
use lib '../lib';
use Test;
# plan 6;

use Physics::Measure :ALL;

#`[[ FIXME - resolve this norm use case
my \Em = 9.109_383_7015e-31kg ±0.000_000_0028e-31;
is ~Em.norm, '0.00091093837015yg ±2.80e-13',            '± ~Em,norm';

my \Xl = 9.109_383_7015e-31m ±0.000_000_0028e-31;
is ~Xl.norm, '0.00000091093837ym ±2.80e-16',            '± ~Xl lower';

$Physics::Measure::round-val = 1000000;

my \Xh = 9109_383_7015e30kg ±28e30;
is ~Xh.norm, '91093837015000000000Yg ±2.80e+10',       '± ~Xh upper';
#]]

$Physics::Measure::round-val = 0.01;

my $c = ♎️ '299792458 m/s';
my $ℎ = ♎️ '6.626070015e-34 J.s';

my \λ = 2.5nm; 
is ~λ, '2.5nm',									'~λ';

my \ν = $c / λ;  
is ~ν.norm, '119.92PHz',						'~ν.norm';

my \Ep = $ℎ * ν;  
is ~Ep.norm, '79.46aJ',						    '~Ep.norm';

done-testing;
