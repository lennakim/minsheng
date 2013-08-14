# encoding: utf-8

class Admin::NoticesController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :set_notice, only: [:show, :edit, :update, :destroy]

  def index
  	@notices = Notice.all
  end

  def new
    @notice = Notice.new
  end

  def create
    if Notice.create(params[:notice])
      redirect_to admin_notices_path
    else
      flash[:notice] = 'error'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @notice.update_attributes(params[:notice])
      redirect_to admin_notices_path
    else
      flash[:notice] = 'error'
      render 'edit'
    end
  end

  def destroy
    @notice.destroy
    render json: {reload: true}
  end

  private
  def set_notice
    @notice = Notice.find(params[:id])
  end
end