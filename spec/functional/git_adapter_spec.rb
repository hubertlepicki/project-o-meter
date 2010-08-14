require 'spec_helper'

describe SCM::GitAdapter do "generating statistics"
  before :all do
    prepare_repo
    @repo = SCM::GitAdapter.new "../project-o-meter-test-repo1"
  end

  it "should give global number of commits in repositiory" do
    @repo.commits_count.should eql(4) 
  end

  it "should give global number of added lines in repository" do
    @repo.added_lines_count.should eql(11)
  end

  it "should give global number of removed lines in repository" do
    @repo.removed_lines_count.should eql(4)
  end

  it "should give number of commits between two dates" do
    @repo.commits_count(Time.parse("2010-01-01 00:00:00"), Time.parse("2010-08-14 14:00:44")).should eql(3)
  end

  it "should give number of added lines between two dates" do
    @repo.added_lines_count(Time.parse("2010-08-14 14:00:44"), Time.parse("2010-08-14 15:00:0")).should eql(1)
  end

  it "should give number of removed lines between two dates" do
    @repo.removed_lines_count(Time.parse("2010-08-14 14:00:44"), Time.parse("2010-08-14 15:00:0")).should eql(4)
  end

  it "should give number of total lines changed globally" do
    @repo.changed_lines_count.should eql(15)
  end
  
  it "should give number of total lines changed between two dates" do
    @repo.changed_lines_count(Time.parse("2010-08-14 14:00:44"), Time.parse("2010-08-14 15:00:0")).should eql(5)
  end
end

describe SCM::GitAdapter, "cloning repositiories" do
  before :each do
    `rm -rf spec/tmp/*`
  end  

  it "should have the ability to clone repo and initiate object" do
    repo = SCM::GitAdapter.clone_repository "git://github.com/hubertlepicki/project-o-meter-test-repo1.git", "spec/tmp/project-o-meter"
    repo.should be_instance_of(SCM::GitAdapter) 
  end

  it "should have the ability to clone repo so that files exist" do
    SCM::GitAdapter.clone_repository "git://github.com/hubertlepicki/project-o-meter-test-repo1.git", "spec/tmp/project-o-meter"
    File.should exist("spec/tmp/project-o-meter/1.txt")
  end
end
