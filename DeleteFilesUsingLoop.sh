#!/bin/bash
##########################################################
# This script is written to delete the orphan records
# in a batch of 10000 in each round of loop 
##########################################################

#Take input like file from which filename will be read and the directory from which files will be deleted

read -p "Enter the file name : " fname
read -p "Enter the directory name : " dname

#Takes user confirmation to delete the file

read -p "Sure to delete Orphan records (press y or Y to proceed)? " Ans
 
#Initializing Variables
total_Rec=`wc -l /siebelfs/siebelfs/${fname}|awk '{print $1}'`
del_path="/siebelfs/siebelfs"
x=10000
y=10000
 
#deleting orphan records
if [ $Ans == y -o $Ans == Y ]
then
        while [ $x -lt $total_Rec ]
        do
                echo "deleting records....."
                cat ${del_path}/${fname} |head -$x|tail -$y|while read line
                do
                        rm ${del_path}/${dname}/${line}
                        echo "$line"
 
                done
                x=$(($x+$y))
        sleep 10
        done
else
	echo "Please enter the proper confirmation"
	echo "Exiting from script"
	exit
fi
