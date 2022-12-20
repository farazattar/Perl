#!/usr/local/bin/txpperl
if ( $#ARGV != 0 )
	{
	&usage;
	exit 1;
	}
$database=$ARGV[0];
if ( ! &sql("connect $database") )
	{
	print "No Access to \"$database\"\n";
	exit 1;
	}
&sql_exec("set autocommit on");
&sql_exec("set lockmode session where readlock = nolock");
print "\nExtracting data from DB, Please wait!\n";
$selFUM="select pic_kanal.bg_kom from pic_kanal where pic_id=27304";
if ( ! &sql( $selFUM ))
	{
	print "Failed to execute the query:\n";
	print "\"$selFUM\"\n";
	print "INGRES-Faiure $sql_error\n";
	}
else 	{
	$FUM=&sql_fetch;
	print "\n$FUM\n\n";
	}
sub usage {
print "\n Please specify the Project\n"
       ." Example: perl arak3\n\n";
}  		 	
