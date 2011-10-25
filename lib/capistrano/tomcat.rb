configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

set(:war_filename) { "#{app_name}.war" }

configuration.load do
  namespace :deploy do
    task :update_code, :roles => :app do
      source_war_path = "artifacts/#{war_filename}"
      target_war_path = File.join(current_path, war_filename)
      top.upload source_war_path, target_war_path
    end
  end
end

