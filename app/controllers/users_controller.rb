class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :except => :show
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
