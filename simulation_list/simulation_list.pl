#!/usr/local/bin/txpperl
if ( $#ARGV == -1 )
  {
  printf("\nUsage: simulation_list.pl [output file] <Project Name> <AP number>\n\n");
  exit 1;
  }
if ( $#ARGV != 2 ) 
  {
  $outfile='simulation_list.txt';
  }
else
  {
  $outfile=$ARGV[0];
  }
$database=$ARGV[1];
$APno=$ARGV[2];
open(OLDOUT, ">&STDOUT");
open(OLDERR, ">&STDERR");

open(STDOUT, ">$outfile") || die "Can't redirect stdout";
open(STDERR, ">&STDOUT") || die "Can't dup stdout";

select(STDERR); $| = 1;     # make unbuffered
select(STDOUT); $| = 1;     # make unbuffered

# Openning Database
#
if ( ! &sql("connect $database") )
  {
  print "Database \"$database\" can not open.\n";
  print "INGRES-Error: $sql_error\n";
  exit 1;
  }
#  
# autocommit and readlock = nolock set
#
&sql_exec("set autocommit on");
&sql_exec("set lockmode session where readlock = nolock");
#
local(@lineValues);
local($nam);
local($sign);
local($formt);
local($value);
local($fgc);
local($fc);
local($desc);
local($status);
local($trans);
local($apn);
local($inhalt);
local ($selstr)="";
$header1="+------------+-----+------+----------+-------+---+---+--------------------------+-------+----------+";
$header2="|ID-Code     |Sig. |Format|Value     |FGC    |FC |AP |Designation               |Status |Transfered|";
$header3="|            |     |      |          |       |   |no |                          |       |          |";

printf("\nSIEMENS AG  Detailed List of KKS of Simulations of AP $APno  ARAK PP");
&PrintTitle;
$pageno=1;
$rowno=1;
$selstr = "select distinct f.nam,s.sig,fkz.fkz,fb.fb,s.cpu1,f.bez,s.format,s.wert,s.sim_j_n,s.fl_sim " 
         ." from simulation s,obj_f f,fkz_d fkz,fb_d fb " 
         ." where f.plan_id=s.plan_id "
         ." and f.fkz_id=fkz.fkz_id and fkz.fb_id=fb.fb_id and s.cpu1 = $APno "
         ." order by s.cpu1,f.nam";
if ( ! &sql ( $selstr ))
  {
  close(STDOUT);
  close(STDERR);

  open(STDOUT, ">&OLDOUT");
  open(STDERR, ">&OLDERR");
  die "INGRES_error: $sql_error\n";
  } 
else 
  {
  while ( @lineValues = &sql_fetch)
    {
    $nam=@lineValues[0];
    $sign=@lineValues[1];
    $fgc=@lineValues[2];
    $fc=@lineValues[3];
    $apn=@lineValues[4];
    $desc=@lineValues[5];
    if( @lineValues[6] eq 1 )     { $formt = "BIT"; }
    elsif ( @lineValues[6] eq 3 ) { $formt = "FLOAT"; }
    $value=@lineValues[7];
    if( @lineValues[8] eq 1 )     { $status = "SET"; }
    elsif ( @lineValues[8] eq 2 ) { $status = "REMOVED"; }
    if(( @lineValues[9] eq b ) && ( @lineValues[8] eq 1 )) { $trans = "YES";}
    else { $trans = "NO";}
    printf("\n|%-12s|%-5s|%-6s|%-10s|%-7s|%-3s|%-3s|%-26s|%-7s|%-10s|",$nam,$sign,$formt,$value,$fgc,$fc,$apn,$desc,$status,$trans);
    $rowno++;
    }
  printf("\n".$header1);
  printf("\nDate: %-d.%-d.%-d",(localtime)[3],(localtime)[4]+1,(localtime)[5]+1900);
  }
printf("\n");

$header1="  +------------+----+-----+-----+-------+---+---+--------------------------+";
$header2="  |ID-Code     |Page|Value|State|FGC    |FC |AP |Designation               |";
$header3="  |            |    |     |     |no     |   |   |                          |";
printf("\nSIEMENS AG        List of KKS of Simulation Blocks of AP $APno");
&PrintTitle;
$pageno=1;
$rowno=1;
$k=0;
$selstr = "select  obj_d.inhalt, obj_f.nam,obj_d.se "
         ."from obj_f , obj_d , lt_f ,fkz_d, fb_d "
         ."where obj_f.plan_id=obj_d.plan_id and "
         ."obj_f.plan_id=lt_f.plan_id  and "
         ."obj_d.pic_id=1930           and "
         ."fkz_d.fkz_id=obj_f.fkz_id   and "
         ."fkz_d.fb_id=fb_d.fb_id      and "
         ."lt_f.cpu1=$APno "
         ."order by obj_f.nam";

if ( ! &sql ( $selstr ))
  {
  close(STDOUT);
  close(STDERR);

  open(STDOUT, ">&OLDOUT");
  open(STDERR, ">&OLDERR");
  die "INGRES_error: $sql_error\n";
  } 
else 
  {
  while ( @lineValues = &sql_fetch)
    {
    @inhaltarray[$k]=@lineValues[0];
    $k++;
    }
  }
$kk=0;
$selstr = "select  obj_f.nam, obj_f.bez ,lt_f.cpu1, "
         ."fkz_d.fkz, fb_d.fb ,obj_d.se "
         ."from obj_f , obj_d , lt_f ,fkz_d, fb_d "
         ."where obj_f.plan_id=obj_d.plan_id and "
         ."obj_f.plan_id=lt_f.plan_id  and "
         ."obj_d.pic_id=1930           and "
         ."fkz_d.fkz_id=obj_f.fkz_id   and "
         ."fkz_d.fb_id=fb_d.fb_id      and "
         ."lt_f.cpu1=$APno "
         ."order by obj_f.nam";

if ( ! &sql ( $selstr ))
  {
  close(STDOUT);
  close(STDERR);

  open(STDOUT, ">&OLDOUT");
  open(STDERR, ">&OLDERR");
  die "INGRES_error: $sql_error\n";
  } 
else 
  {
  while ( @lineValues = &sql_fetch)
    {
    $nam=@lineValues[0];
    $fgc=@lineValues[3];
    $fc=@lineValues[4];
    $inhalt=@inhaltarray[$kk];
    $se=@lineValues[5];
    $apn=@lineValues[2];
    $desc=@lineValues[1];
    $value = substr ($inhalt, 1, 1);
    $value =~ s/@.*//;
    $ono = substr ($inhalt, 4, 1);
    $ono =~ s/@.*//;
    if( $ono eq 1 )     
      {
      $onoff = "ON";
      printf("\n  |%-12s|%-4s|%-5s|%-5s|%-7s|%-3s|%-3s|%-26s|",$nam,$se,$value,$onoff,$fgc,$fc,$apn,$desc);
      }
    elsif ( $ono eq 0 ) 
      {
      $onoff = "OFF"; 
      }
    $kk++;
    $rowno++;
    }
    printf("\n".$header1);
    printf("\nDate: %-d.%-d.%-d",(localtime)[3],(localtime)[4]+1,(localtime)[5]+1900);
    printf("\n");
    close(STDOUT);
    close(STDERR);

    open(STDOUT, ">&OLDOUT");
    open(STDERR, ">&OLDERR");

  }


sub PrintTitle {
printf("\n           ==============================================");
printf("\nTELEPERM XP-ES                                                Department: ARAK-PP");
printf("\nDTC: YFR");
printf("\n----------------------------------------------------------------------------------------------------");
printf("\n".$header1);
printf("\n".$header2);
printf("\n".$header3);
printf("\n".$header1);
}
