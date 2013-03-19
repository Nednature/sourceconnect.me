class Post < ActiveRecord::Base
  attr_accessible :body, :title
  validates_presence_of :title, :body, :user
  belongs_to :user
  has_many :comments
end