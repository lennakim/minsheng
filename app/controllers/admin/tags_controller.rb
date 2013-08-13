class Admin::TagsController < ApplicationController
  before_filter :admin_only, :except => :show
  layout 'admin'
  before_filter :admin_only, :except => :show
  def index
  end

  def new
  end

  def create
  end

  def edit
  end
end
