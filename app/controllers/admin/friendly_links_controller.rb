# encoding: utf-8

class Admin::FriendlyLinksController < Admin::BaseController
  load_resource

  def index
    @friendly_links = FriendlyLink.order('sort DESC').page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    if @friendly_link.save
      redirect_to admin_friendly_links_path
    else
      flash[:notice] = '不能为空'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @friendly_link.update_attributes(params[:friendly_link])
      redirect_to admin_friendly_links_path
    else
      flash[:notice] = '不能为空'
      render 'edit'
    end
  end

  def destroy
    @friendly_link.destroy
    redirect_to admin_friendly_links_path
  end
end
