# FinalProjBD210UW

1. Run the shell script locally and transfer all the files to the remote machine with WINSCP -> the sandbox doesn't have a connection the internet..
2. Transfer from the local machine to the docker container ("scp -P 2222 -r '/home/robords/Emp_data/' root@localhost:")
3. Copy from the local docker machine into HDFS ("hadoop fs -copyFromLocal ~/Emp_data/ /tmp/")
