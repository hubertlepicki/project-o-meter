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

def create_test_project
  Project.create name: "test_project", scm: "git", repository_url: "git://github.com/hubertlepicki/project-o-meter-test-repo1.git"
end
