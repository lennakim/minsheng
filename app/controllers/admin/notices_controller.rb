# encoding: utf-8

class Admin::NoticesController < Admin::BaseController
  before_filter :authenticate_user!
  before_filter :admin_only, except: [:index]
  before_filter :set_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.order('issue_time DESC').page(params[:page])
  end

  def new
    @notice = Notice.new
  end

  def create
    issue_time = params[:notice][:issue_time]
    finish_time = params[:notice][:finish_time]
    params[:notice][:issue_time] = issue_time.to_time unless issue_time.blank?
    params[:notice][:finish_time] = finish_time.to_time unless finish_time.blank?
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
    issue_time = params[:notice][:issue_time]
    finish_time = params[:notice][:finish_time]
    params[:notice][:issue_time] = issue_time.to_time unless issue_time.blank?
    params[:notice][:finish_time] = finish_time.to_time unless finish_time.blank?
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
