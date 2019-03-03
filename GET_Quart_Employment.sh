##shell script to pull and unzip all the county-level data from https://www.bls.gov/cew/datatoc.htm#NAICS_BASED
##1990-2018.  Removed the summary file -> this won't be necessary

##These files weren't as useful -> multiple sheets/xlsx format
#for i in {1990..2018}; do echo "https://data.bls.gov/cew/data/files/$i/xls/""$i""_all_county_high_level.zip -O $i.zip";
#wget "https://data.bls.gov/cew/data/files/$i/xls/""$i""_all_county_high_level.zip"; 
#unzip "$i""_all_county_high_level.zip"; rm "$i""_all_county_high_level.zip"; done


#https://data.bls.gov/cew/data/files/2018/csv/2018_qtrly_singlefile.zip
for i in {1990..2018}; do echo "https://data.bls.gov/cew/data/files/$i/csv/""$i""_qtrly_singlefile.zip";
wget "https://data.bls.gov/cew/data/files/$i/xls/""$i""_qtrly_singlefile.zip"; 
unzip "$i""_qtrly_singlefile.zip"; rm "$i""_qtrly_singlefile.zip"; done
