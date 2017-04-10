use strict;
use warnings;

package Mattermost

use Cpanel::JSON	();
use Try::Tiny;
use Cpanel::HTTP::Tiny::FastSSLVerify	();

## See Cpanel::Pushbullet for example
sub new {
    my ($class, %opts) = @_;

    $host = "https://$host" unless $host =~ m{^https?://}i;

    my $self = {
        host     	=> $opts->{'host'},
        user     	=> $opts->{'user'},
        pass    	=> $opts->{'pass'},
		team		=> $opts->{'team'},
        channel_id 	=> $opts->{'channel'},
		token 		=> '',
		_http  => Cpanel::HTTP::Tiny::FastSSLVerify->new(
            verify_SSL => $_verify_SSL,
        ), 
    };

	return bless $self, $class
}


sub send {
	my( $self, $args, $result ) = @_;
	
	$self->{'token'} = _getToken();
	
	my $create_at = int(time() * 1000);

	my $postData = {
        channel_id      => $self->{'channel_id'},
        message         => $args->get('body'),
        create_at       => $create_at+0
	};
	my url = "$self->{'host'}/api/v3/teams/$self->{'team'}/channels/$self->{'channel_id'}/posts/create"
	my result = $self->{'_http'}->post($url, { 
			headers => $self_headers(), 
			content	=> $postData,
		});
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

