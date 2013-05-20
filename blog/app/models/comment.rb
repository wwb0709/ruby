class Comment < ActiveRecord::Base
  belongs_to :myblog
  attr_accessible :body, :commenter
end
