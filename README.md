Ember.js project starter
------------------------

This is a little bash script to help kickstart a new Ember.js project.
It is based on the Ember.js [starter-kit](https://github.com/emberjs/starter-kit/).

Usage
=====

Download [new_emberjs.sh](https://raw.github.com/tcarlsen/emberjs-project-starter/master/new_emberjs.sh) and give it the
right permissions like:

``` bash
$ chmod -x /path/to/new_emberjs.sh
```

Now you are ready to use the script by running:

``` bash
$ /path/to/new_memberjs.sh -n project_name
```

This will create a new folder with everything you need to kickstart your Ember.js project.

It is possible to use [Twitter Bootstrap](http://twitter.github.io/bootstrap) and other plugins by using one
of the flags when runing `new_emberjs.sh`.

Flags
=====

```
-n <name>           # Project name
-b                  # Include Twitter Boostrap
-d                  # Include Ember Data
-l                  # Include Ember Data Local Storage Adapter
-h                  # Usage information
```