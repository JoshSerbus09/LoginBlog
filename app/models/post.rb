class Post < ActiveRecord::Base
  attr_accessible :message, :name, :title

  validate_presence_of :name, :title, :message
end
