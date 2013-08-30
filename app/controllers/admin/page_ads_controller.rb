# encoding: utf-8

class Admin::PageAdsController < Admin::BaseController

  def index
    @page_ads = PageAd.order('flag_type asc, sort asc').page(params[:page])
  end

  def new
    @page_ad = PageAd.new
  end

  def create
    @page_ad = PageAd.new(params[:page_ad])
    if @page_ad.save
      render :action => :show
    else
      render :action => :new
    end
  end

  def show
    @page_ad = PageAd.find(params[:id])
  end

  def edit
    @page_ad = PageAd.find(params[:id])
  end

  def update
    @page_ad = PageAd.find(params[:id])
    @page_ad.update_attributes(params[:page_ad])
    render :action => :show
  end

  def destroy
    PageAd.delete(params[:id])
    redirect_to admin_page_ads_path
  end


end
