class Project
  include Mongoid::Document
  key :name
  key :scm
  key :repository_url
end
