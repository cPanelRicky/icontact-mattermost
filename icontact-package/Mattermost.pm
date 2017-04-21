package Cpanel::iContact::Provider::Mattermost;

use strict;
use warnings;

use parent 'Cpanel::iContact::Provider';

use Cpanel::iContact::Provider::Mattermost::Class;
use Try::Tiny;


use
sub send {
    my ($self) = @_;
    
    ## Get our args and contact info
    my $args = $self->{'args'};
    my $contact = $self->{'contact'};
    my @errs;

    # Set configurations and build message
    my $hook_url = $contact->{'CONTACTMATTERMOST'};
    my $subject = $args->{'subject'};
    my $body = $args->{'text_body'};

    require Encode;
    my $subject      = Encode::decode_utf8( $subject_copy, $Encode::FB_QUIET );
    my $body         = Encode::decode_utf8( $body_copy, $Encode::FB_QUIET );

    my $msg_text = $subject . "\n\n" . $body;

    ## Create new Mattermost class instance
    my $MM = Mattermost->new(hook_url => $hook_url);
    
    try {
        ## Send our formatted message
        my $result = $MM->send_message(body => $msg_Text);

    } catch {
            push(
                @errs,
                Cpanel::Exception::create(
                    'ConnectionFailed',
                    'The system failed to send the message to “[_1]” due to an error: [_2]',
                    [ $destination, $_ ]
                )
            );
        };
    }
    
    if (@errs) {
        die Cpanel::Exception::create( 'Collection', [ exceptions => \@errs ] );
    }

    return 1;

}


