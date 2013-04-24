#!/bin/bash

while getopts n:bdl option
do
    case "${option}"
    in
        n) appName=$OPTARG;;
        b) Boostrap=true;;
        d) emberData=true;;
        l) localStorage=true;;
    esac
done

echo "Creating emberjs project named $appName"
mkdir $appName

echo "Downloading the emberjs starter-kit"
curl -L -s -k --progress-bar https://github.com/emberjs/starter-kit/archive/master.zip -o starter-kit.zip
unzip starter-kit.zip
mv starter-kit-master/* $appName/
rm -rf starter-kit*

if [ -n "$Boostrap" ]; then
    echo "Downloading Twitter Bootstrap"
    curl -L -s -k --progress-bar http://twitter.github.io/bootstrap/assets/bootstrap.zip -o bootstrap.zip
    unzip bootstrap.zip
    rm $appName/css/*.css
    mv bootstrap/css/*.min.css $appName/css/
    touch $appName/css/style.css
    mv bootstrap/js/bootstrap.min.js $appName/js/libs/
    mkdir $appName/img/
    mv bootstrap/img/* $appName/img/
    rm -rf bootstrap*
    
    echo "Updating the index file to use Twitter Bootstrap"
    mv $appName/index.html $appName/tmp.html
    sed 's|/normalize.css">|/bootstrap.min.css">\
  <link rel="stylesheet" href="css/bootstrap-responsive.min.css">|g' $appName/tmp.html > $appName/index.html
    mv $appName/index.html $appName/tmp.html
    sed 's|<script src="js/app.js"></script>|<script src="js/libs/bootstrap.min.js"></script>\
  <script src="js/app.js"></script>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
fi

if [ -n "$emberData" ]; then
    echo "Downloading emberjs data"
    curl -L -s -k --progress-bar https://github.com/downloads/emberjs/data/ember-data-latest.min.js -o $appName/js/libs/ember-data-latest.min.js
    mv $appName/index.html $appName/tmp.html
    sed 's|<script src="js/app.js"></script>|<script src="js/libs/ember-data-latest.min.js"></script>\
  <script src="js/app.js"></script>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
fi

if [ -n "$localStorage" ]; then
    echo "Downloading Ember Data Local Storage Adapter"
    curl -L -s -k --progress-bar https://raw.github.com/rpflorence/ember-localstorage-adapter/master/localstorage_adapter.js -o $appName/js/libs/localstorage_adapter.js
    mv $appName/index.html $appName/tmp.html
    sed 's|<script src="js/app.js"></script>|<script src="js/libs/localstorage_adapter.js"></script>\
  <script src="js/app.js"></script>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
fi

echo "Project has successfully been created"