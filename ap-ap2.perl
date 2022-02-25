#!/usr/local/bin/txpperl
@AP_ID = (31, 32, 33, 34, 35, 36);
if ( $#ARGV != 0 ) {
 &usage;
 exit 1;
}
$database = $ARGV[0];
if ( ! &sql("connect $database") ) {
 print "No Access to \"$database\"\n";
 exit 1;
}
&sql_exec("set autocommit on");
&sql_exec("set lockmode session where readlock = nolock");
print "\nExtracting data from database, please wait!\n";
$last_ap_index = $#AP_ID;
open (FILE, ">ap-ap.txt");
$ap_counter1 = 0;
while ( $ap_counter1 <= $last_ap_index ) {
 $ap_counter2 = 0;
inner: while ( $ap_counter2 <= $last_ap_index ) {
  if ( $ap_counter2 == $ap_counter1 ){ 
   $ap_counter2++;
   goto inner;
  }
  print "Select signals\t from AP$AP_ID[$ap_counter1]\tto AP$AP_ID[$ap_counter2]\n";
  $query_ap_ap="SELECT DISTINCT q_kks, q_bez, q_cpu1, z_kks, z_bez, z_cpu1 FROM zuli WHERE q_cpu1=$AP_ID[$ap_counter1] AND z_cpu1=$AP_ID[$ap_counter2]";
  if ( ! &sql( $query_ap_ap )) {
   print "Failed to execute the query:\n";
   print "\"$query_ap_ap\"\n";
   print "INGRES-Failure $sql_error\n";
  } else {
   $num = 0;
   while ( @record = &sql_fetch) {
    $data_scalar[$num] = join( '|', @record );
    $num++;
  }
  }
  print "\nPlease do not interrupt !!!\n";
  for ( $line = $[; $line <= $#data_scalar; $line++) {
  @data_array = split( /\|/ , $data_scalar[$line] );
  $source_kks = @data_array[0];
  $source_description = @data_array[1];
  $source_ap = @data_array[2];
  $destination_kks = @data_array[3];
  $destination_description = @data_array[4];
  $destination_ap = @data_array[5];
  print FILE "$source_kks@$source_description@$source_ap@$destination_kks@$destination_description@$destination_ap\n";
  }
  $ap_counter2++;
  }    
 $ap_counter1++;
} 
print "\n==========================Finished================\n";
sub usage {
print "\n Please specify the project\n";
}        
   