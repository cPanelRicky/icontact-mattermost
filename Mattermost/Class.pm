use strict;
use warnings;

package Cpanel::iContact::Provider::Mattermost::Class;

#use Cpanel::iContact::Provider::Mattermost::Mattermost;
use Cpanel::HTTP::Tiny::FastSSLVerify	();
use Cpanel::Exception	();
use Cpanel::JSON		();
use Try::Tiny;

use parent 'Cpanel::iContact::Provider';
## See Cpanel::Pushbullet for example
our $_verify_ssl = 1;
# #Opts:
#
#	- Host			(string, required)	
#	- Username 		(string, required)
#	- Password 		(string, required)
#	- Team			(string, required)
#	- Channel ID 	(integer, required)
#
sub new {
    my ($class, %opts) = @_;

    my $host = "https://$opts{'host'}" unless $opts{'host'} =~ m{^https?://}i;
    
    my $self = {
        host     	=> $opts{'host'},
        user     	=> $opts{'user'},
        pass    	=> $opts{'pass'},
	team		=> $opts{'team'},
        channel_id 	=> $opts{'channel'},
	token 		=> '',
	_http  => Cpanel::HTTP::Tiny::FastSSLVerify->new(
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

	$self->{'token'} = _getToken();
	
	my $postData = {
        channel_id      => $self->{'channel_id'},
        message         => $opts{'body'},
        create_at       => int(time() * 1000)+0
	};

	my $url = "$self->{'host'}/api/v3/teams/$self->{'team'}/channels/$self->{'channel_id'}/posts/create";
	my $result = $self->{'_http'}->post($url, { 
			headers => $self->_headers(), 
			content	=> $postData,
	});
    
    my $parsed_result;
    $parsed_result = Cpanel::JSON::Load($result->{'content'});

    return $parsed_result;
}

sub _getToken {
	my ($self) = @_;
    
    my $data = $self->{'_http'}->post("$self->{'host'}/api/v3/users/login", {
        headers		=> $self->_headers,
		content		=> {
			name     => $self->{'team'},
        	login_id => $self->{'user'},
        	password => $self->{'pass'},
		}
	});
	
	my $header = $data->{'header'};
	my $token = $header->{'token'};
	return $token
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

