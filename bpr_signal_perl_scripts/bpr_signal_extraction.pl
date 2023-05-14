#!/usr/local/bin/txpperl
require 'constants.pl';
require 'help.pl';
require 'connect_db.pl';
require 'open_file.pl';
require 'execute_query.pl';
require 'print_file.pl';
if ( $#ARGV != 0 ) {
  &usage;
  exit 1;
}
$database = $ARGV[0];
&connect_to_database;
&open_a_file;
&execute_the_query;
&print_to_file;
print "\n==========================Finished========================================\n";
  