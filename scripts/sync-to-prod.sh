#!/bin/sh

#Enter the Mongo DB name (should be same locally and remotely).
dbName=punk-jobs

#Enter the Project name (should be what you called it for stagecoach).
projectName=punk-jobs

#Enter the SSH username/url for the remote server.
remoteSSH=punkavec@punkave.com

echo "Syncing MongoDB"
mongodump -d $dbName -o /tmp/mongodump.$dbName &&
rsync -av  /tmp/mongodump.$dbName/ $remoteSSH:/tmp/mongodump.$dbName  &&
ssh $remoteSSH mongorestore --drop -d $dbName /tmp/mongodump.$dbName/$dbName &&
echo "Syncing Files" &&
rsync -av --delete ./public/uploads/ $remoteSSH:/opt/stagecoach/apps/$projectName/uploads &&
echo "Synced up to staging from dev"
