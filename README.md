#Emberjs project starter

This is a little bash script to help kickstart a new Emberjs project based on the emberjs [starter-kit](https://github.com/emberjs/starter-kit/).

## Usage

Go download [new_emberjs.sh](https://raw.github.com/tcarlsen/emberjs-project-starter/master/new_emberjs.sh) to a location of your choice and then run:
	
	chmod -x /path/to/emberjs.sh
	
Now you are ready to use the script by running this:

	sh /path/to/emberjs.sh -n project_name
	
This will create a new folder with all you need to kickstart your Emberjs project.

If you like the project to use [Twitter Bootstrap](http://twitter.github.io/bootstrap/) front-end framework you just need to add a `-b` like this:

	sh /path/to/emberjs.sh -n project_name -b
	
##Flags

	-n <name>			#defining project name
	-b					#include Twitter Boostrap