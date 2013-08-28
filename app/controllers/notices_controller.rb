# encoding: utf-8

class NoticesController < ApplicationController
  load_resource

  def index
    datetime = Time.now
    @notices = Notice.where('end_time > ? AND start_time < ?', datetime, datetime).
      order('start_time DESC')
  end

  def show
  end
end
