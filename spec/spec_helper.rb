require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "project_o_meter"))

RSpec.configure do |config|
  config.mock_with :rspec

  #config.before(:each) do
  #end

  #config.after(:each) do
  #end
end

def prepare_repo
  `rm -rf ../project-o-meter-test-repo1`
  `git clone git://github.com/hubertlepicki/project-o-meter-test-repo1.git ../project-o-meter-test-repo1`
end
