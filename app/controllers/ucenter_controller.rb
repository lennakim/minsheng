# encoding: utf-8

class UcenterController < ApplicationController
  layout 'ucenter'
  def index

  end

  def suggestion
    @suggestion = Suggestion.new
  end

  def inbox
  end

  def comment
  end

  def settings
  end

  def change_password
  end

  def favorite
  end

  def view_history
  end

  def update_password
    user = current_user.reload
    user_params = params[:user].slice(:current_password, :password, :password_confirmation)
    if user.update_with_password(user_params)
      sign_in :user, user, :bypass => true
      result = {success: true}
    else
      result = {success: false}
    end
    render json: result
  end

  def region_list
    records = []
    case params[:type]
    when 'city'
      records = Province.find(params[:province_id]).cities.map{|item| {name: item.name, id: item.id}}
    when 'community'
      City.find(params[:city_id]).districts.each do |district|
        records += district.communities.map{|item| {name: item.name, id: item.id}}
      end
    end
    render json: records
  end
end
