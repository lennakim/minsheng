# encoding: utf-8


class Admin::ShopRecommendationsController < Admin::BaseController
  load_resource

  def index
    @shop_recommendations = ShopRecommendation.includes(:shop).order('flag_type DESC').page(params[:page])
  end

  def new
  end

  def create
    if @shop_recommendation.save
      redirect_to admin_shop_recommendations_path
    else
      flash[:notice] = '不能为空'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @shop_recommendation.update_attributes(params[:shop_recommendation])
      redirect_to admin_shop_recommendations_path
    else
      flash[:notice] = '不能为空'
      render 'edit'
    end
  end

  def destroy
    @shop_recommendation.destroy
    redirect_to admin_shop_recommendations_path
  end
end
