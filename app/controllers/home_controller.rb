class HomeController < ApplicationController
  def index
    if params[:city]
      redirect_to shops_url
    else
      @provinces = Province.all
      datetime = Time.now
      @notices = Notice.where('finish_time > ? AND issue_time < ?', datetime, datetime).
        order('issue_time DESC').limit(5)
    end
  end
end
