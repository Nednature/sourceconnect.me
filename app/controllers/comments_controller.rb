class CommentsController < ApplicationController
	before_filter :authenticate_user!, :only => [:create, :update, :edit, :destroy]
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment])
		@comment.user = current_user
		@comment.save
		redirect_to post_path(@post)
	end


	def edit
		@comment = Comment.find(params[:id])
		@post = Post.find(params[:post_id])
	end

	def update
		@comment = Comment.find(params[:comment_id])
		@post = @post.find(params(:post_id))
		@post.touch(:last_comment_at)
		respond_to do |format|
			if @comment.update_attributes(params[:comment])
				format.html { redirect_to @post, notice: 'Comment was successfully updated.'}
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		# DELETE /posts/1
  		# DELETE /posts/1.json
    	@post = Post.find(params[:post_id])
    	@comment = Comment.find(params[:id])
    	@comment.destroy
    	respond_to do |format|
      		format.html { redirect_to @post }
      		format.json { head :no_content }
    	end
  	end
end