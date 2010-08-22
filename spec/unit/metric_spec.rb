require 'spec_helper'

describe Metric do
  before :all do
    class MyMetric
      include Metric
      
      def get_value
        write_attribute :value, 10.0
      end 
    end
  end

  it "should not return any pairs of dates when none specified" do
    Metric.collect_pairs([]).should be_empty
  end

  it "should not return any pairs of dates when one specified" do
    Metric.collect_pairs([1]).should be_empty
  end

  it "should return one pair of dates when 2 dates specified" do
    Metric.collect_pairs([1, 2]).should eql([[1,2]])
  end

  it "should return 2 pairs of dates when 3 dates specified" do
    Metric.collect_pairs([1,2,3]).should eql([[1,2],[2,3]])
  end

  it "should return 3 pairs of dates when 4 dates specified" do
    Metric.collect_pairs([1,2,3,4]).should eql([[1,2],[2,3],[3,4]])
  end

  it "should collect values" do
    MyMetric.collect_data([ Time.parse("2001-01-01 00:00:00"), 
                            Time.parse("2001-01-15 00:00:00"),
                            Time.parse("2001-01-30 00:00:00") ])

    MyMetric.count.should eql(2)
    MyMetric.first.value.should eql(10.0)
  end

end
