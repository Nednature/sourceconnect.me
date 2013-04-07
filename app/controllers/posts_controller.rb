class PostsController < ApplicationController
  include ApplicationHelper
  #saftey first kids
  before_filter :authenticate_user!,  :only => [:edit, :update, :destroy, :create, :new]
  before_filter :is_owner, :only => [:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json

  def index
    @posts = Post.all
    @posts = Post.order("last_comment_at desc")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.touch(:last_comment_at)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    unless can_edit(@post.user, current_user)
      redirect_to @post, notice: 'You don\'t have permission to do this.'
    end
    @post.touch(:last_comment_at)
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    unless can_edit(@post.user, current_user)
      redirect_to @post, notice: 'You don\'t have permission to do this.'
    end
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    def is_owner
      post = Post.find(params[:id])
      unless user_signed_in? && can_edit(post.user, current_user)
        redirect_to(post, :notice => 'You do not have permissions to edit this post')
      end
    end
    
end
