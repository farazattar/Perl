#!/usr/local/bin/txpperl
sub print_to_file {
  print "Please do not interrupt !!!\n";
  print "Printing data into a file\n";
  for ( $line = $[; $line <= $#data_scalar; $line++) {
    @data_array = split( /\|/ , $data_scalar[$line] );
    $plan_id = @data_array[0];
    $ereigtyp = @data_array[1];
    $fktbereich = @data_array[2];
    $gkomp = @data_array[3];
	  $tkomp = @data_array[4];
    $inr = @data_array[5];
    $eanr = @data_array[6];
    $ityp = @data_array[7];
	  $styp = @data_array[8];
    $gr_nr = @data_array[9];
    $qualitaet = @data_array[10];
    $fkz = @data_array[11];
    $skz = @data_array[12];
    $ea_na = @data_array[13];
    $signal_tx = @data_array[14];
    $einheit = @data_array[15];
    $kommend_tx = @data_array[16];
    $gehend_tx = @data_array[17];
    $pic_name = @data_array[18];
    $time_ch = @data_array[19];
    $time_del = @data_array[20];
    print FILE "$plan_id@$ereigtyp@$fktbereich@$gkomp@$tkomp@$inr@$eanr"
    ."@$ityp@$styp@$gr_nr@$qualitaet@$fkz@$skz@$ea_na@$signal_tx@$einheit"
    ."@$kommend_tx@$gehend_tx@$pic_name@$time_ch@$time_del\n";
  }
  undef @data_scalar;
} 
1;