class LocChangedMetric
  include Metric

  def get_value
    write_attribute :value, @project.repository.changed_lines_count(from, to, /#{AppConfig.code_filename_regexp}/).to_f / ((to-from) / (24*60*60).to_f).to_f
  end
end
