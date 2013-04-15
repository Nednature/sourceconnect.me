class AboutController < ApplicationController
	def index
		render 'about'
	end
	def show
		render 'tech'
	end
end