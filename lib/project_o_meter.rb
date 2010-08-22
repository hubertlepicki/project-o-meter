require 'bundler'

Bundler.require

AmberBitAppConfig.initialize File.join(File.dirname(__FILE__), "..", "config.yml"), ""

require 'metric'
require 'scm/git_adapter'

class ProjectOMeter
  attr_accessor :repository

  def initialize(config_file)
    @config = AmberBitAppConfig.initialize config_file, ""

    if @config.repository_type == "git"
      @repository = SCM::GitAdapter.clone_repository @config.repository_url, @config.repository_clone_path
    end  
  end 

  def collect_metrics
    @config.metrics.each do |metric|
      "#{metric.name.capitalize}Metric".constantize.collect_data(metric.dates.collect {|date| Time.parse(date)})
    end
  end
end
