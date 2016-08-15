#!/usr/bin/perl

package Linux::Sysctl;

use strict;
use warnings;

use Exporter;
use Term::ANSIColor;
use Data::Dumper;
use File::Find;
use File::Basename;
use Fcntl qw( :mode );

{
	$Linux::Sysctl::VERSION = '0.0.1';
}

my @found;
sub _wanted {
	-f && push @found, $File::Find::name;	
}

sub _load {
	find(\&_wanted, "/proc/sys");

	my %sysctl;
	foreach my $e ( sort @found ) {
		my $s = $e;
		$s =~ s/\/proc\/sys\///;
		$s =~ s/\//./g;
		#print "E: ";
		#print colored($s, "bold yellow");
		#print "\n";
		my $m = (stat($e))[2];
		$m = sprintf("%04o", S_IMODE($m));
		#print Dumper($m);
		if ($m eq "0200") {
			$sysctl{$s} = 'ERR';
		} else {
			$sysctl{$s} = &_cat($e);
		}
	}	

	return \%sysctl;
}

sub _cat {
	my $_str = "";
	my $file = shift;
	open F, $file or die colored("Couldn't open file ($file): $! \n", "bold red");
	$_str = <F>;
	close F or die colored("There was a problem closing $file: $! \n", "bold red");
	chomp($_str) unless ((!defined($_str)) or ($_str eq ""));;
	return $_str ? $_str : undef;
}

sub new {
	# populate stuff here
	my $class = shift;
	my $self = &_load();

	bless $self, $class;

	return $self;
}

sub get {
	my $self = shift;
	my $name = shift;

	return $self->{$name};
}

sub set {
	my $self = shift;
	my $name = shift;

	# write to /proc/sys
	# return true, if success
}

1;

