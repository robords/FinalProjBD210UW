# FinalProjBD210UW
#README|Deliverables

###Objective:
My goal was to pull in weather and storm events over time in order to gain an understanding of which places in the US have the least risk of dangerous storms occuring or which generally have bad weather (based on historical data in both cases), and once those locations are determine, figure out which industries are located in those same places in order to determine roughly what types of jobs might be available in the safer and more pleasant climates to live in. 

###Approach:
1. Identify sources of data (listed below)
2. Each of the sources of data were csvs (through the storm-events data was gzip'd) or txt files.  I wrote a simple shell script to download the files (there were many, broken out by year, so I didn't want to download each by hand) to my local machine.  See the section "Scripts not run from Zeppelin" below.
    _Issue:_ Initially, I wanted to use the XLS files available on the BLS site -> they were laid out in a much more human-readable fashion and I wouldn't have to combine in the industry code file.  I did find that I could load in individual excel files if I used the library "com.crealytics:spark-excel_2.11:0.11.1", but I could not figure out an easy way to read in all the files in Scala in Zeppelin.  Reading in multiple CSVs is easy with the wildcard (*), so I ended up re-working the project with those.  [Here](https://github.com/crealytics/spark-excel) is the link to the repo for that library which I was using as a reference.
    _Question:_ I wasn't sure which approach was better (I wasn't able to successfully test it) -> Should I unzip the files prior to adding them into HDFS, or should I unzip them as I read them into memory? 
3. _Issue:_ Ran out of space in HDFS-> Per some instructions laid out by Jerry, mount the data directory onto HDFS (steps written out below)
4. Transfer the files to the /data/ directory on the VM using WINSCP. 
5. Load the files to HDFS on our VMs
    I chose HDFS because it seemed to fit the data I was uploading -> normalized, column-based data whose size fit the criteria (not too small, especially once combined). I wasn't intending to do anything too interactive with the data either. Also, I chose HDFS because it was the most convenient and what I was most comfortable with based on my experience so far in the class (working with it since week 2).
6. Read the CSV files in via a Zeppelin notebook.  I chose to use Zeppelin because my goal was to both practice using Scala on Spark as well as to effectively communicate my steps in the project, including the option to be able to visualize the data
7. Save the CSVs as parquets -> the files took a long time to load via CSV, but load times with parquet were much much faster (reduced from tens of minutes to less than 5 secs)
8. See the rest of the notebook for the remaining steps.
9. NOTE: [This file provides a relatively good explanation for the fields for the BLS data](https://data.bls.gov/cew/doc/layouts/csv_quarterly_layout.htm)

###Data Sources:
1. [The storm events details files from the NOAA](https://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/) provided data about stormevents since the 1950s through today in the US.  
2. [BLS Quarterly census of employment and wages](https://www.bls.gov/cew/datatoc.htm#NAICS_BASED) (singlefile CSVs), provided a view of jobs by industry code in the US.  
3. To provide a human-readable view of the industry codes from the BLS, I also joined in their industry code file, found [here](https://data.bls.gov/cew/doc/titles/industry/industry_titles.csv).  A description of this file can be found [here](https://data.bls.gov/cew/doc/titles/industry/industry_titles.htm)
4. In order to get clean location names, I needed to incorporate a forth reference to "translate" the FIPs code (the weather data location names were not consistent).  I found this data [also on the census site from the US government](https://www2.census.gov/geo/docs/reference/codes/files/national_county.txt)




###Scripts not run from Zeppelin:
```sh
##Download all the stormevents data from the NOAA
##Run on local windows machine
wget --no-clobber --convert-links --random-wait -r -p -E -e robots=off -U mozilla https://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/ 
```
```sh
##Download all the jobs data from the BLS and unzip them
##Run on local windows machine
for i in {1990..2018}; do echo "https://data.bls.gov/cew/data/files/$i/csv/""$i""_qtrly_singlefile.zip";
wget "https://data.bls.gov/cew/data/files/$i/csv/""$i""_qtrly_singlefile.zip"; 
unzip "$i""_qtrly_singlefile.zip"; rm "$i""_qtrly_singlefile.zip"; done
###Note: this I initially ran for the period from 1990 to 2018, but due to the size of the resulting files, I ended up only using data between 2011 and 2018
####Though there was space on disk for most (if not all) of these files, the time it took to read in the data to the notebook was getting frustratingly long.
```
```sh
##This is the list of commands I ran per Jerry's instructions on how to mount the /data/ drive to HDFS
mkdir -p /data/hadoop/hdfs/data  
chown -R hdfs:hadoop /data/hadoop/hdfs/data #to match the ownership Hadoop expects
##Next, I edited the HDFS configuration in Ambari to add, in a comma-separated list, the newly created directory to "Datanode directories" in Services / HDFS / Configs, alongside the original directory HDFS was using 
##Finally, I restarted HDFS from Ambari
```
```sh
##Copy the files from the VM to HDFS (done for both for the BLS data and the stormevents)
hadoop fs -copyFromLocal /data/singlefiles /tmp/
```

If you are having trouble with the code, please provide a detailed description of what you are trying to do in order to demonstrate understanding of the course material
 

#Presentation

Students will provide a brief (2-5 min) presentation of their project in the last class session to share with classmates.

If you need to be absent please contact instructor so that appropriate arrangements can be made.  

Students can optionally record a video in advance of the last class and post to YouTube or similar for viewing, and then answer any questions live.

Example Outline
1. Introduce the data being used
1. Describe the objective of the project
1. Walk through approach, providing justifications of decisions made
1. For example, don’t just say you stored your results in Redis, say why you stored your results in Redis
1. Include code where appropriate
1. Share results
1. Issues you had, if any E.g. Something you would have wanted to do but couldn’t get working or what you would like to do with more time
 Ran into issue with data size, which seems counterintuitive.  Had to remove a number of files and only analyze 2010 through 2 quarters into 2018
1. Answer any questions
