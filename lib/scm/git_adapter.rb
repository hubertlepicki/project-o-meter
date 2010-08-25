module SCM
  class GitAdapter
    include Grit
    Git.git_timeout = 10000.seconds
    def initialize(repo_path)
      @repo = Repo.new(repo_path)
    end

    def commits_count(from=nil, to=nil)
      commits_between(from, to).count
    end

    def added_lines_count(from=nil, to=nil, filename_regexp=nil)
      commits_between(from, to).map {|c| c.stats(filename_regexp).additions }.inject("+")
    end

    def removed_lines_count(from=nil, to=nil, filename_regexp=nil)
      commits_between(from, to).map {|c| c.stats(filename_regexp).deletions }.inject("+")
    end

    def changed_lines_count(from=nil, to=nil, filename_regexp=nil)
      commits_between(from, to).map {|c| c.stats(filename_regexp).total }.inject("+")
    end
    
    def self.clone_repository(url, directory)
      command = "git clone #{url} #{directory}"
      system(command)
      SCM::GitAdapter.new directory
    end

    private
    #def filename_regexp
    #  /^(app|lib|spec)(.*)(.rb|.erb|.haml)$/
    #end 

    def commits_between(from, to)
      if from.nil? || to.nil?
        @repo.commits("master", 1000000)
      else
        @repo.commits("master", 1000000).select {|c| c.date > from && c.date <= to}
      end 
    end
  end
end

