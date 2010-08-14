module SCM
  class GitAdapter
    include Grit

    def initialize(repo_path)
      @repo = Repo.new(repo_path)
    end

    def commits_count(from=nil, to=nil)
      commits_between(from, to).count
    end

    def added_lines_count(from=nil, to=nil)
      commits_between(from, to).map {|c| c.stats.additions }.inject("+")
    end

    def removed_lines_count(from=nil, to=nil)
      commits_between(from, to).map {|c| c.stats.deletions }.inject("+")
    end

    def changed_lines_count(from=nil, to=nil)
      commits_between(from, to).map {|c| c.stats.total }.inject("+")
    end
    
    def self.clone_repository(url, directory)
      `git clone #{url} #{directory}`
      SCM::GitAdapter.new directory
    end

    private
    
    def commits_between(from, to)
      if from.nil? || to.nil?
        @repo.commits
      else
        @repo.commits.select {|c| c.date > from && c.date <= to}
      end 
    end
  end
end

