# encoding: utf-8

class NoticesController < ApplicationController
  load_resource

  def index
    @notices = Notice.order('issue_time DESC')
  end

  def show
  end
end
