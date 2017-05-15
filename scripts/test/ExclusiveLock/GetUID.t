# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use utf8;

use vars (qw($Self));

# Prevent used once warning.
use Kernel::System::ObjectManager;

my $ExclusiveLockObject = $Kernel::OM->Get("Kernel::System::ExclusiveLock");

# _GetUID tests
my %UIDs;
for my $Count ( 1 .. 10_000 ) {
    my $UID = $ExclusiveLockObject->_GetUID();

    if ( $UIDs{$UID} ) {
        $Self->Is(
            $UIDs{$UID},
            undef,
            "_GetUID() $Count - $UID does not exist",
        );
    }
    $UIDs{$UID}++;
}
$Self->Is(
    scalar keys %UIDs,
    10_000,
    "_GetUID() generated all UIDs."
);

1;
