#!/usr/local/bin/txpperl
@AP_ID = (31, 32, 33, 34, 35, 36);
if ( $#ARGV != 0 )
  {
  &usage;
  exit 1;
  }
$database = $ARGV[0];
if ( ! &sql("connect $database") )
  {
  print "No Access to \"$database\"\n";
  exit 1;
  }
&sql_exec("set autocommit on");
&sql_exec("set lockmode session where readlock = nolock");
print "\nExtracting data from database, please wait!\n";
$last_ap_index = $#AP_ID;
$ap_counter1 = 0;
open (FILE, ">ap-ap.txt");
while ( $ap_counter1 <= $last_ap_index ) {
 $ap_counter2 = 0;
inner: while ( $ap_counter2 <= $last_ap_index ) {
  if ( $ap_counter2 == $ap_counter1 ){ 
   $ap_counter2++;
   goto inner;
  }
  print "Select signals\t from AP$AP_ID[$ap_counter1]\tto AP$AP_ID[$ap_counter2]\n";
  $selApAp="SELECT DISTINCT q_kks, q_bez, q_cpu1, z_kks, z_bez, z_cpu1 FROM zuli WHERE q_cpu1=$AP_ID[$ap_counter1] AND z_cpu1=$AP_ID[$ap_counter2]";
  if ( ! &sql( $selApAp ))
  {
  print "Failed to execute the query:\n";
  print "\"$selApAp\"\n";
  print "INGRES-Failure $sql_error\n";
  }
  else
  {
  $num = 0;
  while ( @rec = &sql_fetch)
    {
    $Select[$num] = join( '|', @rec );
    $num++;
    }
  }
  print "\nPlease do not interrupt !!!\n";
  $row=1;
  for ( $l = $[; $l <= $#Select; $l++)
  {
  @array = split( /\|/ , $Select[$l] );
  $kks = @array[0];
  $des = @array[1];
  $from = @array[2];
  $to_kks = @array[3];
  $to_des = @array[4];
  $to = @array[5];
  print FILE "$kks@$des@$from@$to_kks@$to_des@$to\n";
  $row++;
  }
  $ap_counter2++;
  }    
 $ap_counter1++;
} 
print "\n==========================Finished================\n";
sub usage {
print "\n Please specify the project\n";
}        
   
