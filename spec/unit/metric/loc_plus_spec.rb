require 'spec_helper'

describe LocPlusMetric do
   before :each do
     example_config_for_project
     @config.metrics = [OpenStruct.new(:name => "loc_pluss", :dates => ["2010-08-13 00:00:00", "2010-08-14 14:01:00", "2010-08-15 00:00:00"])]

    @project = ProjectOMeter.instance("/some/path.yml")
    @project.collect_metrics
   end

  it "should have 10 locs added in first period" do
    LocPlusMetric.first(:sort => ["from", "ascending"]).value.should eql(10.0)
  end 

  it "should have 1 loc added in second period" do
    LocPlusMetric.first(:sort => ["from", "ascending"], :skip => 1).value.should eql(1.0)
  end 


end
