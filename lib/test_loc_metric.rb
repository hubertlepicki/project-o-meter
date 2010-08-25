class TestLocMetric
  include Metric

  def get_value
    val = TestLocPlusMetric.first(:conditions => {:to => to}).value - TestLocMinusMetric.first(:conditions => {:to => to}).value  
    prev_val = TestLocMetric.first(:sort => [["to", "descending"]])
    val += prev_val.value if prev_val
    write_attribute :value, val
  end
end
