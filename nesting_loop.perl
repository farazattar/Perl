#!/usr/local/bin/txpperl
@AP_ID = (31, 32, 33, 34, 35, 36);
$last_ap_index = $#AP_ID;
$ap_counter1 = 0;
while ( $ap_counter1 <= $last_ap_index ) {
 $ap_counter2 = 0;
inner: while ( $ap_counter2 <= $last_ap_index ) {
  if ( $ap_counter2 == $ap_counter1 ){ 
   $ap_counter2++;
   goto inner;
  }
  print "$AP_ID[$ap_counter1]\t$AP_ID[$ap_counter2]\n";
  $ap_counter2++;
  }    
 $ap_counter1++;
}  