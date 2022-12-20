#!/usr/local/bin/txpperl
#############################################################################
#                                                                           #
# elec_signals.perl: This Perl script extracts information                  #
#                    about binary electrical signals (CC12) from database.  #
#		     This information includes KKS, description,            #
#		     module slot (FUM location) and channel number.         #
#                                                                           #
#############################################################################
#                   Created by F. Attar  28.12.2020                         #
#############################################################################
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
	}
$sel="select obj_d.inhalt from obj_d where obj_d.pic_id=27304";
if ( ! &sql( $sel ))
	{
	print "Failed to execute the query:\n";
	print "\"$sel\"\n";
	print "INGRES-Failure $sql_error\n";
	}
else
	{
	$num=0;
	while ( @rec = &sql_fetch)
	 {
	  $Select[$num]=join( '|', @rec );
	  $num++;
	 }
	}
open (FILE, ">elec_signals.txt");
print "\nPlease do not interrupt !!!\n";
$row=1;
for ( $l=$[; $l <= $#Select; $l++)
{ @list=$Select[$l];
  $Module=$list[0];
  @arr=split("@",$Module);
  $CC=$arr[84];
  $Rack=$arr[85];
  $Rack=~s/^\s+//;
  for ( $i=0; $i <=27; $i++)
    { $ch=$i+1;
      $j=3*$i;
      $channel[$j]=$arr[$j];
      $channel[$j]=~ s/^\s+//;
        $selNew="select obj_f.bez from obj_f where obj_f.nam='$channel[$j]'";
        if ( ! &sql ( $selNew ))
          {
            print "Failed to execute the query2:\n";
            print "\"$selNew\"\n";
            print "INGRES-Failure $sql_error\n";
          }
        else 
          {
           $count=0;
           while ( @lineValue = &sql_fetch)
            {
              $Selektion[$count]=join( '|', @lineValue );
              $count++;
            }
          }   
        for ( $k=$[ ; $k <= $#Selektion; $k++)
        { @newlist=$Selektion[$k];
          $des=$newlist[0];
          print FILE "%$row%$channel[$j]%$des%$CC$Rack%$ch%$FUM%\n";
          $row++;
        }   
    }
}
print "\n======Finished========\n";
sub usage {
print "\n Please specify the Project\n"
       ." Example: perl arak3\n\n";
}  		 	
