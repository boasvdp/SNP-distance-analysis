#!/bin/bash

set -e

if [[ -s workflow/scripts/snp-dists-alnlengths ]]
then
	echo "Script has been downloaded before and size > 0 bytes"
else
	wget -O workflow/scripts/snp-dists-alnlengths https://github.com/boasvdp/snp-dists/raw/master/snp-dists-alnlengths
	chmod u+x workflow/scripts/snp-dists-alnlengths
fi

