require 'spec_helper'

describe LocMinusMetric do
   before :each do
     example_config_for_project
     @config.metrics = [OpenStruct.new(:name => "loc_minuss", :dates => ["2010-08-13 00:00:00", "2010-08-14 14:01:00", "2010-08-15 00:00:00"])]

    @project = ProjectOMeter.instance("/some/path.yml")
    @project.collect_metrics
   end

  it "should have 0 locs added in first period" do
    LocMinusMetric.first(:sort => ["from", "ascending"]).value.should eql(0.0)
  end 

  it "should have 4 loc added in second period" do
    LocMinusMetric.first(:sort => ["from", "ascending"], :skip => 1).value.should eql(4.0)
  end 


end
