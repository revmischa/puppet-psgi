define psgi::app (
  $path,
  $port,
  $psgi,
  $appmodule,
  $owner,
  $group,
  $server='Starman',
  $start_server='start_server',
  $workers=2
  ) {

  $initscript = "/etc/init.d/$name"

  file {
    "$initscript":
      content => template("psgi/psgi_initscript.erb"),
      mode => 0770,
      owner => $owner,
      group => $group;
  }

  service {
    "$name":
      require => File[$initscript],
  }
}

define psgi::nginx (
  $domain,
  $root,
  $static_dir="/static",
  $aliases=[],
  $port
  ) {
  
  nginx::site {
    $name:
      domain => $domain,
      root => $root,
      mediaprefix => $static_dir,
      aliases => $aliases,
      upstreams => [ "localhost:$port" ],
  }
}
