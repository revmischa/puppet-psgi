class psgi {
}

define psgi::app (
  $path,
  $port,
  $psgi,
  $appmodule,
  $owner,
  $group,
  $server='Starman',
  $start_server='start_server',
  $verbose=false,
  $preload_script=false,
  $preload_modules=[],
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

  cpanm::module {
    ['Server::Starter', "Net::Server::SS::PreFork" ]:
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
  $owner=undef,
  $group=undef,
  $ssl_cert=undef,
  $ssl_key=undef,
  $port
  ) {
  
  nginx::site {
    $name:
      ssl_cert => $ssl_cert,
      ssl_key => $ssl_key,
      owner => $owner,
      group => $group,
      domain => $domain,
      root => $root,
      mediaprefix => $static_dir,
      aliases => $aliases,
      upstreams => [ "localhost:$port" ],
  }
}

