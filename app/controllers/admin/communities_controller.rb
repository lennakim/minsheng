# encoding: utf-8
class Admin::CommunitiesController < Admin::BaseController
  before_filter :admin_only
  before_filter :find_district, except: [:cities, :districts]

  # GET /admin/communities
  # GET /admin/communities.json
  def index
    @communities = @district.communities.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @communities }
    end
  end

  # GET /admin/communities/1
  # GET /admin/communities/1.json
  def show
    @community = @district.communities.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @community }
    end
  end

  # GET /admin/communities/new
  # GET /admin/communities/new.json
  def new
    @community = @district.communities.new

    respond_to do |format|
      format.html
      format.json { render json: @community }
    end
  end

  # GET /admin/communities/1/edit
  def edit
    @community = @district.communities.find(params[:id])
  end

  # POST /admin/communities
  # POST /admin/communities.json
  def create
    @community = @district.communities.new(params[:community])

    respond_to do |format|
      if @community.save
        format.html { redirect_to admin_district_communities_url, notice: 'Community was successfully created.' }
        format.json { render json: @community, status: :created, location: @community }
      else
        format.html { render action: "new" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/communities/1
  # PUT /admin/communities/1.json
  def update
    @community = Community.find(params[:id])

    respond_to do |format|
      if @community.update_attributes(params[:community])
        format.html { redirect_to admin_district_communities_url, notice: 'Community was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/communities/1
  # DELETE /admin/communities/1.json
  def destroy
    @community = Community.find(params[:id])
    @community.destroy

    respond_to do |format|
      format.html { redirect_to admin_district_communities_url }
      format.json { head :no_content }
    end
  end

  # get cities
  def cities
    @cities = City.order(:pinyin).group_by{|city| city.pinyin.first }
    @top_cities = get_top_cities
  end

  # get districts
  def districts
    @city = City.find(params[:city_id])
    @districts = @city.districts
  end

  private

  # get top_cities
  def get_top_cities
    top_cities_list = ["beijing", "tianjin", "shanghai", "wuhan", "guangzhou", "shenzhen"]
    City.where("pinyin in (?)", top_cities_list)
  end

  def find_district
    @district = District.find(params[:district_id])
  end
end
