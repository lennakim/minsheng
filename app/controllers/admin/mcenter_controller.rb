class Admin::McenterController < Admin::BaseController
  before_filter :admin_only

  def index
  end
end
