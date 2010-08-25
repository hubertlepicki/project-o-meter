class TestLocMinusMetric
  include Metric

  def get_value
    write_attribute :value, @project.repository.removed_lines_count(from, to, /#{AppConfig.test_filename_regexp}/).to_f
  end
end
