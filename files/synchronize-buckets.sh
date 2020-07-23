servicename=`echo "$FRAMEWORK_NAME" | sed 's/\///g'`
mc --config-folder $MESOS_SANDBOX ls minioclient/ > $MESOS_SANDBOX/currentBucketList.txt
N=0
for i in $(mc --config-folder $MESOS_SANDBOX ls s3compatibleclient/ | grep $servicename) ; do
if [ `expr $N % 5` -eq 4 ]
then
    bucket=${i%/}
    miniobucket=`echo $bucket | sed -e s,${servicename}-,,`
    if cat $MESOS_SANDBOX/currentBucketList.txt | grep -wq $miniobucket;
    then
        echo "$miniobucket exists"
    else
        mc --config-folder $MESOS_SANDBOX rm -r --force s3compatibleclient/$bucket
    fi
fi
let "N= $N + 1"
done
