class TestCodeRatioMetric
  include Metric

  def get_value
    write_attribute :value, TestLocMetric.first(:conditions => {:to => to}).value / LocMetric.first(:conditions => {:to => to}).value
  end
end
