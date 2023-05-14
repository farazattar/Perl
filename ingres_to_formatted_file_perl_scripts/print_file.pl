#!/usr/local/bin/txpperl
sub print_to_file {
  print "Please do not interrupt !!!\n";
  print "Printing data into a file\n";
  for ( $line = $[; $line <= $#data_scalar; $line++) {
    print FILE "$data_scalar[$line]\n";
  }
  undef @data_scalar;
} 
1;