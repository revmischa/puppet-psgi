define psgi::app (
  $path,
  $domain,
  $port,
  $psgi,
  $appmodule,
  $owner,
  $group,
  $server,
  $workers=2,
  $aliases=[]
  ) {

  nginx::site {
    $name:
      domain => $domain,
      root => "$path/root",
      mediaprefix => "/static",
      aliases => $aliases,
      upstreams => [ "localhost:$port" ],
  }

  $initscript = "/etc/init.d/$name"

  file {
    "$initscript":
      content => template("psgi/psgi_initscript.erb"),
      mode => 0770,
      owner => $owner,
      group => $group,
#      notify => Service[$name],
  }

  service {
    "$name":
      require => File[$initscript],
  }
}
