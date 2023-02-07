#!/usr/local/bin/txpperl
sub execute_the_query {
  print "==========================================================================\n";
  print "Select signals\t from AP$AP_ID\t APF$APF_ID[$apf_counter1]\tto " 
        ."AP$AP_ID\t APF$APF_ID[$apf_counter2]\n";
  $query_ap_ap="SELECT DISTINCT q_kks, sig, q_bez, q_cpu1, q_cpu2, " 
                ."z_kks, z_bez, z_cpu1, z_cpu2 " 
                ."FROM zuli " 
                ."WHERE q_cpu1=$AP_ID AND q_cpu2=$APF_ID[$apf_counter1] " 
                ."AND z_cpu1=$AP_ID AND z_cpu2=$APF_ID[$apf_counter2]";
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
}
1;