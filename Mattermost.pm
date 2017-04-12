package Mattermost;

## This module implements the Mattermost iContact provider

use Mattermost::Class;

use strict;


## Do stuffs here like send 
#

sub send {
    my ($self) = @_;
    my $details = {
        host        => 'https://mm.app.prd.de.ku.cx',
        user        => 'rigrassm@gmail.com',
        pass        => 'password',
        team        => 'cpanel',
        channel_id  => 'cp-dev',
    };

    my $mm = Mattermost::Class->new( $details );
}
1;
