use Mojo::Base -strict;
use Test::Mojo;

use Mojo::File 'path';

my $t = Test::Mojo->new(path(__FILE__)->dirname->sibling('lite_app'));

# HTML/XML
$t->get_ok('/')->status_is(200);
my $at = path(__FILE__)->sibling('at2.tsv')->to_string;
my $qb = path(__FILE__)->sibling('qb2.tsv')->to_string;
$t->post_ok('/reconcile' => form => {at => {file => $at}, qb => {file => $qb}});
say $t->tx->result->body;
