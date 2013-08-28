class RatesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :find_shop

  # GET /rates
  # GET /rates.json
  def index
    @rates = @shop.rates.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rates }
    end
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
    @rate = @shop.rates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rate }
    end
  end

  # GET /rates/new
  # GET /rates/new.json
  def new
    @rate = @shop.rates.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rate }
    end
  end

  # GET /rates/1/edit
  def edit
    @rate = @shop.rates.find(params[:id])
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = @shop.rates.new(params[:rate])
    @rate.user = current_user

    respond_to do |format|
      if @rate.save
        format.html { redirect_to shop_path(@shop), notice: 'Rate was successfully created.' }
        format.json { render json: @rate, status: :created, location: @rate }
      else
        format.html { render action: "new" }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rates/1
  # PUT /rates/1.json
  def update
    @rate = @shop.rates.find(params[:id])

    respond_to do |format|
      if @rate.update_attributes(params[:rate])
        format.html { redirect_to shop_rate_path(@shop, @rate), notice: 'Rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate = @shop.rates.find(params[:id])
    @rate.destroy

    respond_to do |format|
      format.html { redirect_to shop_rates_url(@shop)}
      format.json { head :no_content }
    end
  end

  private

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end
end
