class LocMetric
  include Metric

  def get_value
    write_attribute :value, LocPlusMetric.first(:conditions => {:to => to}).value - LocMinusMetric.first(:conditions => {:to => to}).value + LocMetric.all(:conditions => {:to => {"$lt" => to}}).inject("+").to_f
  end
end
