class AboutController < ApplicationController
	def index
		render 'about'
	end
	def tech
		@users = User.count
		@posts = Post.count
		@comments = Comment.count
		render 'tech'
	end
end