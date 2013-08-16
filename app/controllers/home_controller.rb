class HomeController < ApplicationController
  def index
    if params[:city]
      redirect_to shops_url
    else
      @provinces = Province.all
      @notices = Notice.order('issue_time DESC').limit(5)
    end
  end
end
