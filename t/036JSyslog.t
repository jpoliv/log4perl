use Log::Log4perl;
use Test;


#skipping on win32 systems
eval {
	require Sys::Syslog;
};
if ($@){
   print STDERR "Sys::Syslog not installed, skipping...\n";
   ok(1);
   exit;
}


print <<EOL;

Since syslog() doesn't return any value that indicates sucess or failure,
I'm just going to send messages to syslog.  These messages should
appear in the log file generated by syslog(8):

INFO - info message 1
WARN - warning message 1


EOL


my $conf = <<CONF;
log4j.category.cat1      = INFO, myAppender

log4j.appender.myAppender=org.apache.log4j.SyslogAppender
log4j.appender.myAppender.Facility=local1
log4j.appender.myAppender.layout=org.apache.log4j.SimpleLayout
CONF

Log::Log4perl->init(\$conf);

my $logger = Log::Log4perl->get_logger('cat1');


$logger->debug("debugging message 1 ");
$logger->info("info message 1 ");      
$logger->warn("warning message 1 ");   


BEGIN {plan tests => 1}

#if we didn't die, we got here
ok(1);