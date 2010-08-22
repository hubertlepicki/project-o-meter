class CommitsCountMetric
  include Metric

  def get_value
    write_attribute :value, @project.repository.commits_count(from, to).to_f
  end
end
