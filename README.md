## PSGI/Plack Puppet Module

### Deploy PSGI applications with a plackup initscript and nginx reverse proxy configuration

#### Dependencies (if using nginx config):
* [nginx puppet module](http://github.com/uggedal/puppet-module-nginx)

#### Synopsis:

```
  psgi::app {
    "mysite":
      path => '/home/www/sites/mysite',   # directory containing root, lib
      port => 5000,                       # port the PSGI app will listen on
      psgi => 'myapp.psgi',               # path to PSGI app, relative to path
      appmodule => 'MySite',              # webapp library. used for compilation
      workers => 3,                       # max number of child procs to spawn 
      preload_script => '/etc/myapp.env', # shell script to source
      preload_modules => ['Catalyst'],    # modules to load in parent class, get memory savings via copy-on-write
      owner => 'www',                     # user to run as
      group => 'www',                     # group to run as
  }

  # nginx config
  psgi::nginx {
      root => '/home/www/sites/mysite',  # file root dir
      static_dir => '/static',           # media path, relative to root
      domain => "mysite.com",            # site hostname
      aliases => [ "www.mysite.com" ],   # alternative hostnames
      port => 5000,                      # port of the PSGI backend
  }
```

#### Caveats:
* Right now this module assumes your app directory contains `root/`, `root/static/` and `lib/`. Patches are welcome for handling more generic cases.
