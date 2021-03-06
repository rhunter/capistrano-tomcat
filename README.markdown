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
* `catalina_home`: location of the base Tomcat installation, defaults to
  `/usr/share/tomcat6`
* `catalina_executable`: location of the Tomcat executable, defaults to `/usr/sbin/tomcat6`.  In a standard Tomcat installation this would be `${CATALINA_HOME}/bin/catalina.sh` or `${CATALINA_HOME}/bin/catalina.bat`

For the Tomcat installed with **Red Hat Enterprise Linux** packages,
the following settings are appropriate:

    cset :catalina_home '/usr/share/tomcat6'
    cset :catalina_executable, '/usr/sbin/tomcat6'

### Additional pieces
If you need Tomcat to run with additional environment variables, you can use the `tomcat_runtime_env` setting. For example:

    cset :tomcat_runtime_env, {'MYAPP_DB_HOSTNAME' => 'db.example.com'}

If you are using the Java keystore for SSL, you can set the password
with `keystore_password`.

### Unpacking the WAR

Some tasks and applications rely on the standard Rails files being
available on the filesystem. If you need to explode the WAR before
Tomcat gets to it, you can include the following lines in your recipe:

    after "deploy:update_code", "tomcat:unpack_war"
    after "tomcat:unpack_war", "tomcat:finalize_unpacked_war"

