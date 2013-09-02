module NotificationsHelper
  def view_all_user
    User.where("id != #{current_user.id}").select([:id, :name]).map{|u| [u.name ,u.id] }
  end
end
