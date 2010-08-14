require 'spec_helper'

describe SCM::GitAdapter do
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

end
