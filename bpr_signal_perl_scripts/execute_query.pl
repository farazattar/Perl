#!/usr/local/bin/txpperl
sub execute_the_query {
  print "==========================================================================\n";
  print "Select signals\t from bpr_signal table.\n";
  $query="SELECT * FROM bpr_signal"; 
  if ( ! &sql( $query )) {
    print "Failed to execute the query:\n";
    print "\"$query\"\n";
    print "INGRES-Failure $sql_error\n";
  } else {
    $num = 0;
    while ( @record = &sql_fetch) {
      $data_scalar[$num] = join( '|', @record );
      $num++;
    }
  }
}
1;