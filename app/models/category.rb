class Category < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :name, :description
  has_many :posts
  friendly_id :name, use: [:slugged, :history]
end
