 #!/bin/bash
rm newFile

if [ ! -f ./oldFile ]
then
        echo "I do not have an existing copy of the PR page to compare to today's version. I will save today's now."
        curl --silent http://www.mccain.senate.gov/public/index.cfm/press-releases > oldFile
        exit 0
fi

curl --silent http://www.mccain.senate.gov/public/index.cfm/press-releases > newFile
UPDATED=`diff oldFile newFile`

if [[ -z $UPDATED ]]
then
        echo "No updates."
        exit 0
else
        echo "Updates available:"
        UPDATEURL=`grep -o -m 1 "<a\ href=\"http://www.mccain.senate.gov\/.*class=\"ContentGrid.*a>" newFile | cut -d '"' -f2`
        curl --silent $UPDATEURL > update.html
        NEWPOST=`awk '/<\/article>/{f=0} f;/<div class="header">/{f=1}' update.html`
        echo $NEWPOST
        cat newFile > oldFile
        exit 0
fi
