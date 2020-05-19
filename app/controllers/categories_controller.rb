class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @category_posts = @category.posts.order("created_at DESC").page(params[:page]).per(4)
    @parents = Category.all.order("id ASC").limit(25)
  end
end
