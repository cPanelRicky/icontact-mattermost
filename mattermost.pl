package Mattermost

use REST::Client;
use Cpanel::JSON;

use strict;
## See Cpanel::Pushbullet for example

our $host = 'https://mm.app.prd.de.ku.cx/api/';
our $apiVer = '/api/v3';

sub _getToken {
    my $username = 'admin';
    my $password = 'admin';
    my $loginEndPoint = '/users/login';

	my $client = REST:: Client->new();
	$client->setHost;
	$client->POST();
	my $response = $client->responseContent();
	my $token = "BEARER " . $response['Token'];
	return $authToken
}

sub createPost {
    
	my( $args, $result ) = @_;
	my $postTitle = $args->get('subject');
	my $postBody = $args->get('body');

	my $postEndPoint = $apiVer . '/teams/' . $teamId . '/channels/' . $channelId . '/posts/create';
	my $channelId = '';
	my $teamId = '';
	my $token = _getToken();
	
	my $headers = { Accept => 'application/json', 
					Authorization => $token 
	};
	
	my $postData = { message => $postMessage,
					channel_id => $channelId 
	};

	my $client = REST::Client->new();
	$client->setHost($host);
	$client->POST( $postEndPoint, $headers, $postData );
	my $response = $client->responseContent();

}
