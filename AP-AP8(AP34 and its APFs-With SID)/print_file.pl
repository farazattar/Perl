#!/usr/local/bin/txpperl
sub print_to_file {
  print "Please do not interrupt !!!\n";
  print "Printing data into a file\n";
  for ( $line = $[; $line <= $#data_scalar; $line++) {
    @data_array = split( /\|/ , $data_scalar[$line] );
    $source_kks = @data_array[0];
    $source_signal = @data_array[1];
    $source_description = @data_array[2];
    $source_ap = @data_array[3];
	  $source_apf = @data_array[4];
    $destination_kks = @data_array[5];
    $destination_description = @data_array[6];
    $destination_ap = @data_array[7];
	  $destination_apf = @data_array[8];
    print FILE "$apf_counter1@$apf_counter2@$source_kks@$source_signal@$source_description@$source_ap@$source_apf@$destination_kks@$destination_description@$destination_ap@$destination_apf\n";
  }
  undef @data_scalar;
} 
1;