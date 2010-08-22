require 'spec_helper'

describe "Project o Meter initialization" do
  before :each do
    example_config_for_project
 end

  it "should initalize project name from yaml file" do
    AmberBitAppConfig.should_receive(:initialize).with("/some/path.yml", "").and_return(@config)
    @project = ProjectOMeter.instance("/some/path.yml")
  end

  it "should check out project repository on setup" do
    @project = ProjectOMeter.instance("/some/path.yml")
    File.exist?("/tmp/repo").should be_true
  end

  it "should have accessible project repo object on setup" do
    @project = ProjectOMeter.instance("/some/path.yml")
    @project.repository.should be_instance_of(SCM::GitAdapter) 
  end
end

describe "Project o Meter collecting metrics" do
  class FooMetric; end
  class BarMetric; end

  before :each do
    example_config_for_project
    @config.metrics = [OpenStruct.new(:name => "foo", :dates => ["2010-01-01 00:00:00", "2010-02-02 00:00:00", "2010-02-03 00:00:00"]),
                       OpenStruct.new(:name => "bar", :dates => ["2010-01-01 00:00:00", "2010-02-02 00:00:00"])]
 end

  it "it should collect all metrics needed" do
    @project = ProjectOMeter.instance("/some/path.yml")

    FooMetric.should_receive(:collect_data).with([Time.parse("2010-01-01 00:00:00"), Time.parse("2010-02-02 00:00:00"), Time.parse("2010-02-03 00:00:00")])
    BarMetric.should_receive(:collect_data).with([Time.parse("2010-01-01 00:00:00"), Time.parse("2010-02-02 00:00:00")])
    @project.collect_metrics

  end


end
