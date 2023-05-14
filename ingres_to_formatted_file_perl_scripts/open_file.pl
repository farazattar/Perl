sub open_a_file {
  open (FILE, ">$filename") || die "Cannot open the text file : $!\n";
}
1;