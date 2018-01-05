package Cpanel::iContact::Provider::Mattermost;

use strict;
use warnings;

use parent 'Cpanel::iContact::Provider';

use Try::Tiny;

sub send {
    my ($self) = @_;

    ## Get our args and contact info
    my $args = $self->{'args'};
    my $contact = $self->{'contact'};
    my @errs;

    # Set configurations and build message
    my $hook_url = $args->{'to'}[0];
    my $subject_copy = $args->{'subject'};
    my $body_copy = ${ $args->{'text_body'} };

    if( _is_version_lt_69() ) {
        require Encode;
        my $subject      = Encode::decode_utf8( $subject_copy, $Encode::FB_QUIET );
        my $body         = Encode::decode_utf8( $body_copy, $Encode::FB_QUIET );
    }

    my $msg_text = $subject . "\n\n" . $body;

    try {
        ## Send our formatted message
        my $result = _send_message( body => $msg_text, 'hook_url' => $hook_url );

    }
    catch {
        push(
            @errs,
            Cpanel::Exception::create(
                'ConnectionFailed',
                'The system failed to send the message to “[_1]” due to an error: [_2]',
                [ $hook_url, $_ ]
            )
        );
    };

    if (@errs) {
        die Cpanel::Exception::create( 'Collection', [ exceptions => \@errs ] );
    }

    return 1;

}

sub _is_version_lt_69 {
    open( my $fh, "<", "/usr/local/cpanel/version" );
    my $ver_line = readline($fh);
    chomp($ver_line);
    close($fh);
    my ( $major_ver ) = $ver_line =~ m/\d+\.(\d+)\./;
    return ( $major_ver && $major_ver < 69 );
}

sub _send_message {
    my %opts = @_;

    my $headers = {
        'Content-Type'      => 'application/json',
        'X-Requested-With'  => 'XMLHttpRequest',
    };

    require HTTP::Tiny;
    my $postData = {
        text => $opts{'body'},
    };
    require JSON::MaybeXS;
    my $result = HTTP::Tiny->new()->post($opts{'hook_url'}, {
            headers => $headers,
            content => JSON::MaybeXS::encode_json($postData),
    });

    return $result;

}

1;
