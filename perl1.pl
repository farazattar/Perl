#!/usr/local/bin/txpperl
if ( $#ARGV != 0 ) 
  {
  &usage;
  exit 1;
  }
$database=$ARGV[0];
if ( ! &sql("connect $database") )
  {
  print "Datenbank \"$database\" konnte nicht angesprochen werden.\n";
  print "INGRES-Fehler: $sql_error\n";
  exit 1;
  }
&sql_exec("set autocommit on");
&sql_exec("set lockmode session where readlock = nolock");
$sel="select obj_f.nam, obj_d.inhalt from obj_d, obj_f " 
 ."where pic_id=2283 and obj_d.plan_id=obj_f.plan_id";
if ( ! &sql ( $sel )) 
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
     $Selek[$num]=join( '|', @rec );
     $num++;
    }
  }
open (FILE,">channel.txt");
print "\nI am busy,Don't interrupt please!!!\n\n";
for ( $l=$[; $l<=$#Selek; $l++)
{ @list=split(/\|/,$Selek[$l]);
  $kks=$list[0];
  $par=$list[1];
  print FILE "\n\n$l==$kks====$par==============\n\n\n";
}
sub usage {
print "\nPlease Specify the Project\n"
     ."Example:   perl arak4\n\n";
}     
