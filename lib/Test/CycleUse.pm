package Test::CycleUse;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Cwd;
use Exporter qw(import);
use Devel::CycleUse;
use Test::More;

our @EXPORT = qw/
    no_cycle_use_ok
/;


sub no_cycle_use_ok{
    my ( $namespace ) = @_;

    my $full_path = _namespace2fullpath( $namespace );

    my $cycle_use = Devel::CycleUse->new(dir => $full_path);

    my $result = $cycle_use->find_small_cycle();

    if ( scalar @{$result} ){
        ok 0 , 'Cycle use are find';
        for my $row ( @{$result} ){
            diag sprintf "    %s \n" , join ' -> ', @{$row};
        }
    }
    else{
        ok 1 , $namespace;
    }

}

sub _namespace2fullpath{
    my $namespace = shift;

    my $current = getcwd();
    return "$current/lib" unless defined $namespace;

    return sprintf('%s/lib/%s',
        $current,
        join '/', split /::/,$namespace
    );
}

1;

__END__

=encoding utf-8

=head1 NAME

Test::CycleUse - Test of CycleUse

=head1 SYNOPSIS

use Test::More;
use Test::CycleUse;

no_cycle_use_ok(); # finding under lib directories.

no_cycle_use_ok('TheService::Module'); # finding under lib/TheService/Module directories.

=head1 DESCRIPTION

Test::CycleUse finds module which is used cyclic.

=head1 SEE ALSO

=item * L<Devel::CycleUse>

=head1 LICENSE

Copyright (C) masaru.hoshino.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

masartz E<lt>masartz@gmail.comE<gt>

=cut

