package Mattermost;

## This module implements the Mattermost iContact provider
use strict;

use JSON;
use HTTP::Tiny;

my $_verify_ssl = 0;

sub new {
    my ($class, %opts) = @_;

    my $self = {
        hook_url        => $opts{'hook_url'},
        _http  => HTTP::Tiny->new(
            verify_SSL => $_verify_ssl,
        ),
    };

    return bless $self, $class;
}

sub send_message {
    my( $self, %opts ) = @_;

    for my $attr (qw( body )) {
        die "Need “$attr”!" if !length $opts{$attr};
    }

    my $postData = {
        text => $opts{'body'},
    };
    my $result = $self->{'_http'}->post($self->{'hook_url'}, {
            headers => $self->get_headers(),
            content => encode_json($postData),
    });
    
#my $parsed_result;
#   $parsed_result = from_json($result->{'content'}, { utf8  => 1 } ) ;

    return $result;

}

sub get_hook_url {
    my ($self) = @_;
    return $self->{'hook_url'};
}
sub get_headers {
    my ($self) = @_;

        my $headers = {
            'Content-Type'      => 'application/json',
            'X-Requested-With'  => 'XMLHttpRequest',
        };

        # initial_load is fine with just the Cookie, other endpoints like channels/
        # require Authorization. We'll just always include both to be sure.
        if (exists $self->{'token'}) {
            push(@{$headers},
                'Cookie'        => 'MMAUTHTOKEN=' . $self->{'token'},
                'Authorization' => 'Bearer ' . $self->{'token'},
            );
        }

    return $headers;
};
1;
