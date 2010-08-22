require 'bundler'

Bundler.require

AmberBitAppConfig.initialize File.join(File.dirname(__FILE__), "..", "config.yml"), ""

require 'metric'
require 'commits_count_metric'
require 'loc_plus_metric'
require 'loc_minus_metric'
require 'loc_metric'
require 'scm/git_adapter'

# This class is a Multiton
class ProjectOMeter
  attr_accessor :repository
  @@instances_pool = nil

  def initialize(config_file)
    @config = AmberBitAppConfig.initialize config_file, ""

    if @config.repository_type == "git"
      @repository = SCM::GitAdapter.clone_repository @config.repository_url, @config.repository_clone_path
    end  
  end 

  def collect_metrics
    @config.metrics.each do |metric|
      "#{metric.name.classify}Metric".constantize.collect_data(metric.dates.collect {|date| Time.parse(date)}, self)
    end
  end

  def self.instance(path)
    @@instances_pool = {} if @@instances_pool.nil?

    @@instances_pool[path] ||= new(path)
  end

  def self.clear
    @@instances_pool = {}
  end
end
