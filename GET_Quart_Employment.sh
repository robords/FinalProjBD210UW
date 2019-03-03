##shell script to pull and unzip all the county-level data from https://www.bls.gov/cew/datatoc.htm#NAICS_BASED
##1990-2018.  Removed the summary file -> this won't be necessary

for i in {1990..2018}; do echo "https://data.bls.gov/cew/data/files/$i/xls/""$i""_all_county_high_level.zip -O $i.zip";
wget "https://data.bls.gov/cew/data/files/$i/xls/""$i""_all_county_high_level.zip"; 
unzip "$i""_all_county_high_level.zip"; rm "$i""_all_county_high_level.zip"; done
