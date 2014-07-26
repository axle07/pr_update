#!/bin/bash

if [ ! -f ./oldFile ]
then
	echo "I do not have an existing copy of the PR page to compare to today's version. I will save today's now."
	curl --silent http://www.mccain.senate.gov/public/index.cfm/press-releases >> oldFile
fi

curl --silent http://www.mccain.senate.gov/public/index.cfm/press-releases >> newFile
UPDATED=`diff oldFile newFile`
if [[ -z $UPDATED ]]
then
	echo "No updates."
else
	echo "Updates available."
fi
