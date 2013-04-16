class AboutController < ApplicationController
	def index
		render 'about'
	end
	def show
		@users = User.count
		@posts = Post.count
		@comments = Comment.count
		render 'tech'
	end
end