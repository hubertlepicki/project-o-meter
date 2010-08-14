module SCM
  class GitAdapter
    include Grit

    def initialize(repo_path)
      @repo = Repo.new(repo_path)
    end

    def commits_count(from_time=nil, to_time=nil)
      if from_time.nil? && to_time.nil?
        @repo.commits.count
      else
        @repo.commits.select {|c| c.date > from_time && c.date <= to_time}.count
      end
    end

    def added_lines_count(from_time=nil, to_time=nil)
      if from_time.nil? && to_time.nil?
        @repo.commits.map {|c| c.stats.additions }.inject("+")
      else
        @repo.commits.select {|c| c.date > from_time && c.date <= to_time}.map {|c| c.stats.additions }.inject("+")
      end
    end

    def removed_lines_count(from_time=nil, to_time=nil)
      if from_time.nil? && to_time.nil?
        @repo.commits.map {|c| c.stats.deletions }.inject("+")
      else
        @repo.commits.select {|c| c.date > from_time && c.date <= to_time}.map {|c| c.stats.deletions }.inject("+")
      end
    end
    
    def self.clone_repository(url, directory)
      `git clone #{url} #{directory}`
      SCM::GitAdapter.new directory
    end
  end
end

