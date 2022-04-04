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
$last_ap_index = $#AP_ID;
&connect_to_database;
&open_a_file;
$ap_counter1 = 0;
while ( $ap_counter1 <= $last_ap_index ) {
  $ap_counter2 = 0;
  inner: while ( $ap_counter2 <= $last_ap_index ) {
    if ( $ap_counter2 == $ap_counter1 ){ 
      $ap_counter2++;
      goto inner;
    }
    &execute_the_query;
    &print_to_file;
    $ap_counter2++;
  }    
  $ap_counter1++;
} 
print "\n==========================Finished========================================\n";
  