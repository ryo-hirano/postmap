class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @posts = @user.posts.includes([:user, :images]).order("created_at DESC")
    @parents = Category.all.order("id ASC").limit(25)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :update
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :nickname, :introduction)
  end

end
