#!/bin/perl


use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catdir($FindBin::Bin, '..', 'lib');

use JSON;
use Mattermost;
use Test::Simple tests => 4;

my $opts = {
    hook_url => 'https://mm.app.prd.de.ku.cx/hooks/g756obpagbdjmgzp5etdpps88o',
    msg => 'This is a test message',       
    };

my $mm = Mattermost->new(hook_url => $opts->{'hook_url'});
my $headers = $mm->get_headers();
my $hook_url = $mm->get_hook_url();
my $response = $mm->send_message(body => $opts->{'msg'});

ok( $mm->get_hook_url(), $opts->{'hook_url'} );
ok( $headers->{'Content-Type'}, 'application/json' );
ok( $headers->{'X-Requested-With'}, 'XMLHttpRequest' );
ok( $response->{'content'}, 'ok');

