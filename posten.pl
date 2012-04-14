use vars qw($VERSION %IRSSI $bringpackageurl);

use Irssi;
use LWP::Simple qw/get/;
use JSON::XS qw( decode_json );
use HTML::Strip;

$VERSION = '1.0';
%IRSSI = (
    authors     => 'Marius Nettum',
    contact     => 'marius@intnernettum.no',
    name        => 'irssi-posten',
    description => 'Spor pakker sendt via posten med kollinummer',
    license     => 'GPL'
);

$bringpackageurl = 'http://sporing.bring.no/sporing.json?q=';

sub trackPackage() {
	my ($server, $msg, $nick, $addr, $target) = @_;
	if ($msg =~ m/^^!sporing ([\w-]*)/) {
		my $content = get($bringpackageurl . $1);
		if (defined($content)) {
			my $trackinginfo = decode_json($content);
			if (defined($trackinginfo)) {
				if (defined($trackinginfo->{'consignmentSet'}->[0]->{'error'}->{'message'})) {
					$server->command('msg ' . $target . ' ' . $trackinginfo->{'consignmentSet'}->[0]->{'error'}->{'message'});
				} elsif (defined($trackinginfo->{'consignmentSet'}->[0]->{'packageSet'})) {
					my $strip = HTML::Strip->new();
					for my $event ( @{$trackinginfo->{'consignmentSet'}->[0]->{'packageSet'}->[0]->{'eventSet'}} ) {
						if ($event->{'status'} ne 'NOTIFICATION_SENT') {
							my $cleantext = $event->{'displayDate'} . ' ' . $event->{'displayTime'} . ', ' . $event->{'postalCode'} . ' ' . $event->{'city'} . ': ' . $strip->parse($event->{'description'});
							$strip->eof;
							$server->command('msg ' . $target . ' ' . $cleantext);
						}
					}
				}

			} 
		} else {
			$server->command('msg ' . $target . ' ' . 'Could not track package, try ' . $bringpackageurl . $1);
		}

	}
	

}

Irssi::signal_add('message public', 'trackPackage');