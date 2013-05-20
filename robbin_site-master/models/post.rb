class Post < ActiveRecord::Base
   # attr_accessible :name, :body
  # validates_presence_of :name => "用户名不能为空！"
  
  # self.push_with_attributes(:name = 'wwbwwwb')
  self.table_name = "posts2"
  validates :name, :presence => true
  validates :name, :length => {:in => 3..5}
end
