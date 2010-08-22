require 'spec_helper'

describe CommitsCountMetric do
   before :each do
     example_config_for_project
     @config.metrics = [OpenStruct.new(:name => "commits_count", :dates => ["2010-08-13 00:00:00", "2010-08-14 14:01:00", "2010-08-15 00:00:00"])]

    @project = ProjectOMeter.instance("/some/path.yml")
    @project.collect_metrics
   end

  it "should have 3 commits in first period" do
    CommitsCountMetric.first(:sort => ["from", "ascending"]).value.should eql(3.0)
  end 

  it "should have 1 commit in second period" do
    CommitsCountMetric.first(:sort => ["from", "ascending"], :skip => 1).value.should eql(1.0)
  end 

end
