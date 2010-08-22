require 'spec_helper'

describe LocMetric do
   before :each do
     example_config_for_project
     @config.metrics = [OpenStruct.new(:name => "loc", :dates => ["2010-08-13 00:00:00", "2010-08-14 14:01:00", "2010-08-15 00:00:00"])]

    @project = ProjectOMeter.instance("/some/path.yml")
    @project.collect_metrics
   end

  it "should have 10 locs changed in first period" do
    LocMetric.first(:sort => ["from", "ascending"]).value.should eql(10.0)
  end 

  it "should have 5 loc changed in second period" do
    LocMetric.first(:sort => ["from", "ascending"], :skip => 5).value.should eql(1.0)
  end 


end
