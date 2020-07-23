if [ "$MINIO_SECRETS_ENABLED" == true ]
then
    export MINIO_ACCESS_KEY=`cat $MESOS_SANDBOX/access_key_file`
    export MINIO_SECRET_KEY=`cat $MESOS_SANDBOX/secret_key_file`
fi
if [ "$MINIO_SSL_ENABLED" == true ]
then
    mkdir $MESOS_SANDBOX/certs
    mkdir $MESOS_SANDBOX/certs/CAs
    cp $MESOS_SANDBOX/node.ca $MESOS_SANDBOX/certs/CAs
    mc --config-folder $MESOS_SANDBOX config host add minioclient https://miniod.$FRAMEWORK_VIP_HOST:9000 $MINIO_ACCESS_KEY $MINIO_SECRET_KEY
else
    mc --config-folder $MESOS_SANDBOX config host add minioclient http://miniod.$FRAMEWORK_VIP_HOST:9000 $MINIO_ACCESS_KEY $MINIO_SECRET_KEY
fi
mc --config-folder $MESOS_SANDBOX config host add s3compatibleclient $STHREE_COMPATIBLE_URI $ACCESS_KEY_ID $SECRET_ACCESS_KEY
