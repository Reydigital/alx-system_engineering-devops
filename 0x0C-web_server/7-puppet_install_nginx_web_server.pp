# Script that setup a nginx web server on our server + redirection.



package { 'nginx':

  ensure   => present,

  provider => 'apt'

}



# Index page

file { '/var/www/html/index.html':

  ensure  => present,

  path    => '/var/www/html/index.html',

  content => 'Hello World!'

}



# Redirect to Maarey's channel

file_line { 'Maarey youtube channel':
ensure => 'present',

  path   => '/etc/nginx/sites-available/default',

  after  => 'listen 80 default_server;',

  line   => '        rewrite ^/redirect_me https://www.youtube.com/channel/UCg9ObXjJdiXyZECPnqqsDfg permanent;'

}



service { 'nginx':

  ensure     => running,

  enable     => true,

  hasrestart => true,

  require    => Package['nginx'],

  subscribe  => File_line['Maarey youtube channel']

}
