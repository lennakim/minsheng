class HomeController < ApplicationController
  def index
    if params[:city]
      redirect_to shops_url
    else
      @provinces = Province.all
    end
  end
end
