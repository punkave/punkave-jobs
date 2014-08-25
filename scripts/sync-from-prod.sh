#!/bin/sh

#Enter the Mongo DB name (should be same locally and remotely).
dbName=punk-jobs

#Enter the Project name (should be what you called it for stagecoach).
projectName=punk-jobs

#Enter the SSH username/url for the remote server.
remoteSSH=punkavec@punkave.com

echo "Syncing MongoDB"
ssh $remoteSSH mongodump -d $dbName -o /tmp/mongodump.$dbName &&
rsync -av $remoteSSH:/tmp/mongodump.$dbName/ /tmp/mongodump.$dbName  &&
mongorestore --drop -d $dbName /tmp/mongodump.$dbName/$dbName &&
echo "Syncing Files" &&
rsync -av --delete $remoteSSH:/opt/stagecoach/apps/$projectName/uploads/ ./public/uploads  &&
echo "Synced down from staging to dev"
