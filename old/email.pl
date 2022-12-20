#!/usr/bin/perl

use strict;
use warnings;

my $email= 'farazattar.attar@gmail.com';
if ($email =~
/([^@]+)@(.+)..../) {
	print "Username is $1\n";
	print "Hostname is $2\n";
};

