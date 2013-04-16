class Post < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :body, :title, :category_id, :category
  validates_presence_of :title, :body, :user
  belongs_to :user
  belongs_to :category
  has_many :comments
  friendly_id :title, use: [:slugged, :history]
end