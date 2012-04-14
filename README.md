# irssi-posten  

Spor pakker sendt via posten med kollinummer fra irssi  

## Requirements

irssi (duh)  
LWP::Simple (apt-get install libwww-perl)  
JSON::XS (apt-get install libjson-xs-perl)  
HTML::Strip (apt-get install libhtml-strip-perl)  

## Installation

1. Copy posten.pl to ~/.irssi/scripts
2. Load script from irssi with '/load posten.pl'


## Usage

Track pacakge with `!sporing <parcelnumber>` in channel  
E.g. output:  
`15.10.2011 10:57, 1007 OSLO: Sendingen er utlevert`  
`15.10.2011 09:54, 1007 OSLO: Sendingen er ankommet Kiwi Lindeberg`  
`14.10.2011 18:33, 0024 OSLO: Sendingen er ankommet terminal og blir videresendt`  
`14.10.2011 12:52, 3169 STOKKE: Sendingen er innlevert til terminal og videresendt`  
