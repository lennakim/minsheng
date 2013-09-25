class HomeController < ApplicationController
  layout false

  def index
    if params[:city]
      redirect_to shops_url
    else
      @provinces = Province.all
      datetime = Time.now
      @notices = Notice.where('end_time > ? AND start_time < ?', datetime, datetime).
        order('start_time DESC').limit(5)
    end
  end
end
