#####################################################
#  Script for ziping JMS LOGS with respect to date  #
#####################################################
 
 
#####################################################
#            Variable Declaration Part              #
#####################################################
 
JMS_Path=/Siebel_logs/JMS_Logs/ 
JMS_LOG_Path=${JMS_Path}JMS_ZIP

#####################################################
# Zipping JMS Log file in loop datewise             #
#####################################################
 
mkdir -p ${JMS_Path}/JMS_ZIP
cd ${JMS_Path}
while read line
do
         TEMPLINE=$line
 
         #taking the Process ID from log name
         P_ID=`ls -lrt $TEMPLINE|awk '{print $9}'|sed -e 's/_/ /g' -e 's/\./ /g'|awk '{print $2}'`
 
         #taking the start time of the log
         ST=`head -1 $TEMPLINE|awk -F":" '{print $3}'|awk '{print $4"_"$5}'`
 
         #taking the end time of the log
         ET=`tail -1 $TEMPLINE|awk -F":" '{print $3}'|awk '{print $4"_"$5}'`
 
         #ziping the JMS LOG
         zip -mT $JMS_LOG_Path/jms_${ST}_${P_ID}_${ET}.zip $TEMPLINE
 
#Taking the list of the logs older than last 10 mins
done <<< "`find ${JMS_Path} -type f -name "jms*.txt.log" -mmin +10|xargs ls -lrt|sed 's/\.\///g'|awk -F"/" '{print $4}'`"
