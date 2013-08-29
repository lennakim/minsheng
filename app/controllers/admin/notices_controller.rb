# encoding: utf-8

class Admin::NoticesController < Admin::BaseController
  before_filter :authenticate_user!
  before_filter :admin_only, except: [:index]
  before_filter :set_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.order('start_time DESC').page(params[:page])
  end

  def new
    @notice = Notice.new
  end

  def create
    start_time = params[:notice][:start_time]
    end_time = params[:notice][:end_time]
    params[:notice][:start_time] = start_time.to_time unless start_time.blank?
    params[:notice][:end_time] = end_time.to_time unless end_time.blank?
    @notice = Notice.new(params[:notice])
    if @notice.save
      redirect_to admin_notices_path
    else
      flash[:notice] = '不能为空'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    start_time = params[:notice][:start_time]
    end_time = params[:notice][:end_time]
    params[:notice][:start_time] = start_time.to_time unless start_time.blank?
    params[:notice][:end_time] = end_time.to_time unless end_time.blank?
    if @notice.update_attributes(params[:notice])
      redirect_to admin_notices_path
    else
      flash[:notice] = '不能为空'
      render 'edit'
    end
  end

  def destroy
    @notice.destroy
    redirect_to admin_notices_path
  end

  private
  def set_notice
    @notice = Notice.find(params[:id])
  end
end
