## PSGI/Plack Puppet Module

### Deploy PSGI applications with a plackup initscript and nginx reverse proxy configuration


#### Dependencies:
* [nginx puppet module](http://github.com/uggedal/puppet-module-nginx)



#### Synopsis:

```
  psgi::app {
    "mysite":
      path => '/home/www/sites/mysite',  # directory containing root, lib
      domain => "mysite.com",            # site hostname
      aliases => [ "www.mysite.com" ],   # alternative hostnames
      port => 5000,                      # port the PSGI app will listen on
      psgi => 'myapp.psgi',              # path to PSGI app, relative to path
      appmodule => 'MySite',             # webapp library. used for compilation
      workers => 3,                      # max number of child procs to spawn 
      server => 'Starlet',               # webserver to use
      owner => 'www-data',               # user to run as
      group => 'www-data',               # group to run as
  }
```



#### Caveats:
* Right now this module assumes your app directory contains root/, root/static/ and lib/. Patches welcome to handle more generic cases.
