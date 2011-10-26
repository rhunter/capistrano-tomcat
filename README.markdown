# Tomcat extensions for Capistrano


## Usage

In your Rails app's deployment recipe (`config/deploy.rb`):

    require 'capistrano/tomcat'

Then, once you have built your WAR into `artifacts/appname.war`,
you can use the Capistrano deployment as you would for Passenger.

    $ rake package
    $ cap deploy:setup
    $ cap deploy

## Configuration

`tomcat_base_port` controls the other ports as well.
`tomcat_http_port`
`tomcat_https_port`
`tomcat_ajp_port`

