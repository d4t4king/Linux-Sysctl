#!/usr/bin/perl

package Linux::Sysctl;

use strict;
use warnings;

use Exporter;
use Term::ANSIColor;
use Data::Dumper;

{
	$Linux::Sysctl::VERSION = '0.0.1';
}

@ISA	= qw/ Exporter /;

sub new {
	# populate stuff here
	opendir PROCSYS, "/proc/sys" or die colored("There was a problem reading the /proc/sys directory: $! \n", "bold red");
	closedir PROCSYS or die colored("There was a problem closing the /proc/sys directory: $! \n", "bold red");
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
