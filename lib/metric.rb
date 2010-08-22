module Metric
  def self.included(base)
    base.send :include, Mongoid::Document
    base.send :attr_accessor, :project
    base.send :field, :value, type: Float
    base.send :field, :from, type: Time
    base.send :field, :to, type: Time

    base.send :before_validation, :get_value
    base.extend(ClassMethods)
  end

  def self.collect_pairs(items)
    return [] if items.nil? || items.size <= 1
    (1..(items.size-1)).collect {|index| [items[index-1], items[index]]}
    
  end

 module ClassMethods
   def collect_data(time_periods, project)
     Metric.collect_pairs(time_periods).each do |period|
       unless first(conditions: {from: period[0], to: period[1]})
         create from: period[0], to: period[1], project: project
       end
     end
   end
 end
end 
