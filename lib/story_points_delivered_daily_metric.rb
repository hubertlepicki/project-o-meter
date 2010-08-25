class StoryPointsDeliveredDailyMetric
  include Metric

  def get_value
    expectations = File.open("estimations.txt", "r") do |file|
      file.read.split("\n")
    end

    index = StoryPointsDeliveredDailyMetric.count

    write_attribute :value, expectations[index].to_f / ((to - from).to_i * 24*60*60).to_f
  end
end
