module ApplicationHelper
  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def format_datetime(datetime, format_str = '%Y-%m-%d %H:%M:%S')
    datetime.nil? ? nil : datetime.strftime(format_str)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  # def resource_class
  #   devise_mapping.to
  # end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
