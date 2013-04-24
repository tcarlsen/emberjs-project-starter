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

included=""

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
    
    mv $appName/index.html $appName/tmp.html
    sed 's|<script type="text/x-handlebars">|<script type="text/x-handlebars">\
    <div class="container">|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
    
    mv $appName/index.html $appName/tmp.html
    sed 's|{{outlet}}|{{outlet}}\
    </div>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
    
    included+="'Twitter Boostrap',"
fi

if [ -n "$emberData" ]; then
    echo "Downloading emberjs data"
    curl -L -s -k --progress-bar https://github.com/downloads/emberjs/data/ember-data-latest.min.js -o $appName/js/libs/ember-data-latest.min.js
    mv $appName/index.html $appName/tmp.html
    sed 's|<script src="js/app.js"></script>|<script src="js/libs/ember-data-latest.min.js"></script>\
  <script src="js/app.js"></script>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
    
    included+="'Ember Data',"
fi

if [ -n "$localStorage" ]; then
    echo "Downloading Ember Data Local Storage Adapter"
    curl -L -s -k --progress-bar https://raw.github.com/rpflorence/ember-localstorage-adapter/master/localstorage_adapter.js -o $appName/js/libs/localstorage_adapter.js
    mv $appName/index.html $appName/tmp.html
    sed 's|<script src="js/app.js"></script>|<script src="js/libs/localstorage_adapter.js"></script>\
  <script src="js/app.js"></script>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
    
    included+="'Ember Data Local Storage Adapter',"
fi

if [ -n "$included" ]; then
    mv $appName/js/app.js $appName/tmp.js
    sed "s|'red', 'yellow', 'blue'|$included|g" $appName/tmp.js > $appName/js/app.js
    rm $appName/tmp.js
    
    mv $appName/index.html $appName/tmp.html
    sed 's|<ul>|<strong>This starter kit also includes:</strong>\
  <ul>|g' $appName/tmp.html > $appName/index.html
    rm $appName/tmp.html
fi

mv $appName/index.html $appName/tmp.html
sed 's|{{outlet}}|{{outlet}}\
    <p>Thanks for using Emberjs project starter by TCarlsen!</p>|g' $appName/tmp.html > $appName/index.html
rm $appName/tmp.html

echo "Project has successfully been created"