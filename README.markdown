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

* **tomcat\_base\_port**: controls the other ports as well, defaults to 8005
* **tomcat\_ajp\_port**: defaults to tomcat_base_port + 4
* **tomcat\_http\_port**: defaults to tomcat_base_port + 75
* **tomcat\_https\_port**: defaults to tomcat_base_port + 443
