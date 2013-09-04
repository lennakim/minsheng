module NotificationsHelper
  def view_all_user
    User.where("id != #{current_user.id}").select([:id, :name]).map{|u| [u.name ,u.id] }
  end

  def view_user_name u_id
    User.find(u_id).name
  end
end
