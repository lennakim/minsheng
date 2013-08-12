class HomeController < ApplicationController
  def index
    @provinces = Province.all
  end
end
