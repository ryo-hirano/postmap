class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes([:user ,:images]).order("created_at DESC").page(params[:page]).per(12)
    @post_topics = Post.includes(:category).order("created_at DESC").page(params[:page]).per(4)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @parents = Category.all.order("id ASC").limit(25)
    @post_food = Post.where(category_id: 78).order("created_at DESC").page(params[:page]).per(4)
    @post_fashion = Post.where(category_id: 76).order("created_at DESC").page(params[:page]).per(4)
    @top_ranks = Post.includes(:user).find(Like.group(:post_id).pluck(:post_id))
    @my_ranks = @top_ranks.select{ |post| post.category_id == 76 }
  end

  def category
  end

  def new
    @post = Post.new
    @post.images.new
    @category_parent_array = Category.where(ancestry: nil).pluck(:name).unshift("選択してください")
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

 # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @posts = Post.create(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end
  
  def search
    @posts = Post.search(params[:keyword])
    @parents = Category.all.order("id ASC").limit(25)
  end

  private
  def post_params
    params.require(:post).permit(:image, :text, :content, :category_id, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  
end
