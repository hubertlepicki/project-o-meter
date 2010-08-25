class LocMetric
  include Metric

  def get_value
    val = LocPlusMetric.first(:conditions => {:to => to}).value - LocMinusMetric.first(:conditions => {:to => to}).value  
    prev_val = LocMetric.first(:sort => [["to", "descending"]])
    val += prev_val.value if prev_val
    write_attribute :value, val
  end
end
