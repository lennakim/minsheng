class Mobile::ShopsController < ApplicationController
  layout 'mobile'
  # GET /shops
  # GET /shops.json
  def search
    if params[:term]
      @shops = Shop.where("title like '%"+params[:term]+"%'")
    else
      @shops = Shop.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end

  end
  def index
    @shops = Shop.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shop = Shop.find(params[:id])
    @rates = @shop.rates.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/new
  # GET /shops/new.json
  def new
    @shop = Shop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: "new" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shops/1
  # PUT /shops/1.json
  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end

  def send_shop_message
    mobile = params[:mobile]
    if Minsheng::MobileUtil.valid_mobile?(mobile)
      content = Shop.find(params[:shop_id]).generate_message
      logger.debug{"#{mobile} ~~~~ #{content}"}
      result = Sms.send_message_by_smsbao(mobile, content)
      success =  result[:success] ? true : false
    else
      success = false
    end
    render json: success
  end

  def shop_message_dialog
    shop = Shop.find(params[:shop_id])
    render json: {html: render_to_string(
      partial: 'message_dialog',
      locals: {verify_code: Minsheng::MobileUtil.generate_code, shop: shop}
    )}
  end
end
