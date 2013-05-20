# encoding: utf-8
class Tag < ActiveRecord::Base
  belongs_to :myblog
  attr_accessible :name
end
