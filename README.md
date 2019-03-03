# FinalProjBD210UW

1. GET the natural disaster files with: wget --no-clobber --convert-links --random-wait -r -p -E -e robots=off -U mozilla https://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/
2. Transfer form local machine to remote machine, then to docker container/sandbox, then to HDFS
1. Run the shell script locally and transfer all the files to the remote machine with WINSCP -> the sandbox doesn't have a connection the internet..
2. Transfer from the local machine to the docker container ("scp -P 2222 -r '/home/robords/Emp_data/' root@localhost:")
3. Copy from the local docker machine into HDFS ("hadoop fs -copyFromLocal ~/Emp_data/ /tmp/")
1. Ran the following command in the docker container to install the package necessary for reading excel files: $SPARK_HOME/bin/spark-shell --packages com.crealytics:spark-excel_2.11:0.11.1 
