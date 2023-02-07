#!/usr/local/bin/txpperl
sub connect_to_database {
  if ( ! &sql("connect $database") ) {
    print "No Access to \"$database\"\n";
    exit 1;
  }
  &sql_exec("set autocommit on");
  &sql_exec("set lockmode session where readlock = nolock");
  print "\nExtracting data from database, please wait!\n";
}        
1;