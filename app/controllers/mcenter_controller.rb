class McenterController < ApplicationController
  before_filter :admin_only
  layout 'admin'
  def index
  end
end
