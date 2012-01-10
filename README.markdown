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

The default configuration uploads artifacts/yourapp.war to your app
servers and starts Tomcat on port 8080.

### Ports
* `tomcat_base_port`: controls the other ports as well. Defaults to 8005.
* `tomcat_ajp_port`: defaults to 8009 (`tomcat_base_port` + 4)
* `tomcat_http_port`: defaults to 8080 (`tomcat_base_port` + 75)
* `tomcat_https_port`: defaults to 8443 (`tomcat_base_port` + 438)

### Directories and files
* `catalina_executable`: location of the Tomcat executable, defaults to `/usr/sbin/tomcat6`.  In a standard Tomcat installation this would be `${CATALINA_HOME}/bin/catalina.sh` or `${CATALINA_HOME}/bin/catalina.bat`

