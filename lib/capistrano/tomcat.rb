configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  set(:war_filename) { "#{application}.war" }
  _cset :tomcat_base_port, 8005
  _cset(:tomcat_ajp_port) { tomcat_base_port + 4 } #8009
  _cset(:tomcat_http_port) { tomcat_base_port + 75 } #8080
  _cset(:tomcat_https_port) { tomcat_base_port + 443 } #8443
  _cset :keystore_password, nil
  _cset :catalina_home, '/usr/share/tomcat6'
  _cset :catalina_executable, '/usr/sbin/tomcat6'
  _cset(:tomcat_runtime_env, {})

  namespace :deploy do
    task :update_code, :roles => :app do
      on_rollback { run "rm -rf -- \"#{release_path}\"" }

      create_tomcat_directory_structure_under release_path
      source_war_path = "artifacts/#{war_filename}"
      target_war_path = File.join(release_path, 'webapps', war_filename)
      top.upload source_war_path, target_war_path
    end

    task :finalize_update do
      # no finalization necessary with a WAR deployment
    end

    task :start, :roles => :app do
      run_tomcat_command 'start'
    end
    task :stop, :roles => :app do
      run_tomcat_command 'stop'
    end
    task :restart, :roles => :app do
      run_tomcat_command 'stop'
      run_tomcat_command 'start'
    end

    def run_tomcat_command cmd
      log = File.join(shared_path, "log", "deploy.log")
      tmpdir = File.join(current_path, "temp")
      base_env = {
        "CATALINA_HOME" => catalina_home,
        "CATALINA_BASE" => current_path,
        "CATALINA_TMPDIR" => tmpdir
      }
      run "#{catalina_executable} #{cmd} #{log}", :env => base_env.merge(tomcat_runtime_env)
    end
  end

  def create_tomcat_directory_structure_under base
    dirs = [release_path,
      File.join(release_path, 'webapps'),
      File.join(release_path, 'conf'),
      File.join(release_path, 'work'),
      File.join(release_path, 'temp')
    ]
    run <<-SH
      #{try_sudo} mkdir -p #{dirs.join ' '} && \
      #{try_sudo} cp -r \"#{catalina_home}/conf\"/* \"#{release_path}/conf/\" && \
      #{try_sudo} ln -s #{File.join shared_path, "log"} #{File.join release_path, "logs"}
    SH

    upload_templated_config 'server.xml', :remote_base => base
    upload_templated_config 'web.xml', :remote_base => base
  end

  def upload_templated_config filename, options
    base = options[:remote_base] or raise ArgumentError "no base specified"

    destination_path = File.join(base, 'conf', filename)
    template_filename = File.join(File.dirname(__FILE__), "tomcat", "templates", "#{filename}.erb")
    template = File.read(template_filename)
    result = ERB.new(template).result(binding)
    put result, destination_path, :mode => 0644
  end
end

