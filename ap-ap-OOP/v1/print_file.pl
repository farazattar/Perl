#!/usr/local/bin/txpperl
sub print_to_file {
  print "Please do not interrupt !!!\n";
  print "Printing data into a file\n";
  for ( $line = $[; $line <= $#data_scalar; $line++) {
    @data_array = split( /\|/ , $data_scalar[$line] );
    $source_kks = @data_array[0];
    $source_description = @data_array[1];
    $source_ap = @data_array[2];
    $destination_kks = @data_array[3];
    $destination_description = @data_array[4];
    $destination_ap = @data_array[5];
    print FILE "$ap_counter1@$ap_counter2@$source_kks@$source_description@$source_ap@$destination_kks@$destination_description@$destination_ap\n";
  }
  undef @data_scalar;
} 
1;