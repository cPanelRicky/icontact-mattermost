use strict;
use warnings;

package Mattermost::Class;

#use Cpanel::iContact::Provider::Mattermost::Mattermost;
#use Cpanel::HTTP::Tiny::FastSSLVerify	();
#use Cpanel::Exception	();
use JSON;
use HTTP::Tiny;
use Try::Tiny;

#use parent 'Cpanel::iContact::Provider';

our $_verify_ssl = 1;

# #Opts:
#
#	- Webhook URL			(string, required)	
#
sub new {
    my ($class, %opts) = @_;

    my $host = "https://$opts{'host'}" unless $opts{'host'} =~ m{^https?://}i;
    
    my $self = {
        hook_url     	=> $opts{'hook_url'},
        _http  => HTTP::Tiny->new(
            verify_SSL => $_verify_ssl,
        ), 
        #_http  => Cpanel::HTTP::Tiny::FastSSLVerify->new(
        #    verify_SSL => $_verify_ssl,
        #), 
    };

	return bless $self, $class;
}


sub send_message {
	my( $self, %opts ) = @_;
	
    for my $attr (qw( body )) {
        die "Need “$attr”!" if !length $opts{$attr};
    }

	my $postData = {
        message         => $opts{'body'},
	};

	my $result = $self->{'_http'}->post($url, { 
			headers => $self->_headers(), 
			content	=> $postData,
	});
    
    my $parsed_result;
    $parsed_result = Cpanel::JSON::Load($result->{'content'});

    return $parsed_result;
}

sub _headers {
	my ($self) = @_;

		my $headers = [
			'Content-Type'      => 'application/json',
			'X-Requested-With'  => 'XMLHttpRequest',
		];

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

