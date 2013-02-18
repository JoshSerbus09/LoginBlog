class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :name, :title, :uid

  validates_presence_of :message, :title
  validates_length_of :message, :minimum => 10, :maximum => 160
  validates_uniqueness_of :title
end
