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
$last_apf_index = $#APF_ID;
&connect_to_database;
&open_a_file;
$apf_counter1 = 0;
while ( $apf_counter1 <= $last_apf_index ) {
  $apf_counter2 = 0;
  inner: while ( $apf_counter2 <= $last_apf_index ) {
    if ( $apf_counter2 == $apf_counter1 ){ 
      $apf_counter2++;
      goto inner;
    }
    &execute_the_query;
    &print_to_file;
    $apf_counter2++;
  }    
  $apf_counter1++;
} 
print "\n==========================Finished========================================\n";
  