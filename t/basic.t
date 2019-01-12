use Test::More;
use Test::Mojo;

use Mojo::File 'path';

my $t = Test::Mojo->new(path(__FILE__)->dirname->sibling('lite_app'));

# HTML/XML
$t->get_ok('/')->status_is(200);
my $at = path(__FILE__)->sibling('at.tsv')->to_string;
my $qb = path(__FILE__)->sibling('qb.tsv')->to_string;
$t->post_ok('/reconcile' => form => {at => {file => $at}, qb => {file => $qb}})
  ->status_is(200)
  ->text_is('table tr:last-child td:first-child' => 2172)
  ->text_is('table tr:last-child td:last-child' => -105);

done_testing();