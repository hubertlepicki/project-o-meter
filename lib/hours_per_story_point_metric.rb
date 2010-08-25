class HoursPerStoryPointMetric
  include Metric

  def get_value
    expectations = File.open("estimations.txt", "r") do |file|
      file.read.split("\n")
    end

    spent_time = File.open("spent_time.txt", "r") do |file|
      file.read.split("\n")
    end

    index = HoursPerStoryPointMetric.count

    write_attribute :value, spent_time[index].to_f / expectations[index].to_f
  end
end
