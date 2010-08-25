require 'bundler'

Bundler.require

AmberBitAppConfig.initialize File.join(File.dirname(__FILE__), "..", "config.yml"), ""

require File.join(File.dirname(__FILE__), 'metric')
require File.join(File.dirname(__FILE__), 'commits_count_metric')
require File.join(File.dirname(__FILE__), 'loc_plus_metric')
require File.join(File.dirname(__FILE__), 'loc_minus_metric')
require File.join(File.dirname(__FILE__), 'loc_changed_metric')
require File.join(File.dirname(__FILE__), 'loc_metric')
require File.join(File.dirname(__FILE__), 'test_loc_plus_metric')
require File.join(File.dirname(__FILE__), 'test_loc_minus_metric')
require File.join(File.dirname(__FILE__), 'test_loc_metric')
require File.join(File.dirname(__FILE__), 'test_code_ratio_metric')
require File.join(File.dirname(__FILE__), 'hours_per_story_point_metric')
require File.join(File.dirname(__FILE__), 'story_points_delivered_daily_metric')
require File.join(File.dirname(__FILE__), 'scm/git_adapter')
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
