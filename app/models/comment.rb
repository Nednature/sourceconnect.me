class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body
  validates_presence_of :body, :user

  after_save :update_post_last_comment_at

  private
  def update_post_last_comment_at
  	self.post.touch(:last_comment_at) if self.post
  end
end
