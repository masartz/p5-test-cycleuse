use strict;
use warnings;

use Test::More;
use Test::CycleUse;

use Cwd;

subtest 'can_ok' => sub{
    can_ok 'Test::CycleUse' , qw/ no_cycle_use_ok /;
};

subtest '_namespace2fullpath' => sub{
    my $current = getcwd();
    is Test::CycleUse::_namespace2fullpath() , "$current/lib";
    is Test::CycleUse::_namespace2fullpath('Hoge') , "$current/lib/Hoge";
    is Test::CycleUse::_namespace2fullpath('Hoge::Moge') , "$current/lib/Hoge/Moge";
};


done_testing();
