class PostsController < ApplicationController
  before_action :find_post, only: [:show,:edit,:update,:destroy, :upvote]
  before_action :authenticate_user!, except: [:index,:show] 
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :verify_is_admin, only: [:index] 

  def index
    @posts = Post.all.order("created_at DESC")  
  end 

  def new
    @cats = Post.select(:category_id).distinct 
    @post = Post.new
  end 

  def show

  end 

  def create
     @post = Post.new(post_params)
     @post.user = current_user 

    if @post.save
      flash[:success] = "We're on it! A confirmation containing payment instructions will be sent to your email. Please allow for up to 30 minutes for confirmation to arrive."
      redirect_to post_path(@post)  
    else 
      flash[:success] = "Oops! Looks like you're missing something. Please try again." 
      redirect_to root_path  
    end 
  end 

  def edit

  end 

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully"
    else 
      render 'edit' 
    end 
  end 

  def destroy
    @post.destroy
    redirect_to root_path 
  end 

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end 

  def post_params
    params.require(:post).permit(:image, :category_id, :referemail ) 
  end 

  def require_same_user
    if current_user != @post.user
      flash[:danger] = "Not authorized to edit this post"
      redirect_to root_path
    end
  end 

  def verify_is_admin
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end
