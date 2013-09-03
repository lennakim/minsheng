class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.image_data = params.slice(:top, :left, :width, :height, :original_w, :original_h)
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end

  def upload_image
    @user = User.find(params[:id])
  end
end
