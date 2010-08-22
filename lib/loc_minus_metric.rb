class LocMinusMetric
  include Metric

  def get_value
    write_attribute :value, @project.repository.removed_lines_count(from, to).to_f
  end
end
