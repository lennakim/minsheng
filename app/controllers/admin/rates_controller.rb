class Admin::RatesController < Admin::BaseController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :find_shop

  # GET /rates/1
  # GET /rates/1.json
  def show
    @rate = @shop.rates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rate }
    end
  end

  private

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end
end