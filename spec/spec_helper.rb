require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "project_o_meter"))

Mongoid.configure do |config|
  name = "project_o_meter_test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end


RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:each) do
    Mongoid.database.collections.each {|col| begin col.drop; rescue; end }
  end

  #config.after(:each) do
  #end
end

def prepare_repo
  `rm -rf ../project-o-meter-test-repo1`
  `git clone git://github.com/hubertlepicki/project-o-meter-test-repo1.git ../project-o-meter-test-repo1`
end

def example_config_for_project
    `rm -rf /tmp/repo`
    @config = OpenStruct.new
    @config.repository_url = "http://github.com/hubertlepicki/project-o-meter-test-repo1.git"
    @config.repository_type = "git"
    @config.repository_clone_path = "/tmp/repo"
    AmberBitAppConfig.stub!(:initialize).with("/some/path.yml", "").and_return(@config)
end

