# encoding: utf-8

class NoticesController < ApplicationController
  load_resource

  def index
    datetime = Time.now
    @notices = Notice.where('finish_time > ? AND issue_time < ?', datetime, datetime).
      order('issue_time DESC')
  end

  def show
  end
end
