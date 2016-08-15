#!/usr/bin/perl

use strict;
use warnings;

use Term::ANSIColor;
use Data::Dumper;

use lib '/root/Linux-Sysctl';
use Linux::Sysctl;

my $sysctl = Linux::Sysctl->new();

print colored("Testing Linux::Sysctl.... \n", "cyan");
#print Dumper($sysctl);

print "net.ipv4.conf.all.log_martians: ".$sysctl->get('net.ipv4.conf.all.log_martians')."\n";
