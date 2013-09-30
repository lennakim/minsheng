# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    render 'users/show', layout: 'ucenter'
  end

  def update
    @user = User.find(params[:id])
    @user.image_data = params.slice(:top, :left, :width, :height)
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end

  def upload_image
    @user = User.find(params[:id])
    #@user.consignees.build if @user.consignees.blank?
    @user.in_password_reset = true
    render 'users/upload_image', layout: 'ucenter'
  end
end
