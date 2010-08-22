class LocMetric
  include Metric

  def get_value
    write_attribute :value, @project.repository.changed_lines_count(from, to).to_f
  end
end
