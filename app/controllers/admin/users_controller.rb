# encoding: utf-8

class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :admin_only, :except => :show

  def index
    @users = User.order('created_at DESC').page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_role
    @user = User.find(params[:id])
  end

  def update_role
    @user = User.find(params[:id])

    respond_to do |format|
      begin
        @user.assign_attributes(params[:user], :as => user.role)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
      rescue ActiveModel::MassAssignmentSecurity::Error
        format.html { redirect_to admin_user_path(@user), notice: '没有权限修改' }
      else
        format.html { render action: "edit_role" }
      end
    end
  end

end
