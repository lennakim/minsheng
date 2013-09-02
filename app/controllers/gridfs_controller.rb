
class GridfsController < ActionController::Metal
  def serve
    #gridfs_path = env["PATH_INFO"].gsub("/images/", "")
    #gridfs_path =  gridfs_path.split("upload/")
    model_name = params[:model]
    model_id = params[:id]
    field_name = params[:field_name]
    begin
      #@gridfs_file = Mongoid::GridFs.find(:filename => gridfs_path)
      model_class_inst = model_name.camelcase.constantize
      model_inst = model_class_inst.find(model_id)
      field_body = model_inst.send(field_name)
      self.response_body = field_body.read
      #self.response_body = model_class_inst.find(image_id).url.read
      # self.content_type = Mongoid::GridFs.extract_content_type(@gridfs_file.filename)
    rescue SystemCallError
      # p SystemCallError
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = 'not found'
    end
  end

  def userimage
    gridfs_path = env["PATH_INFO"].gsub("/userimages/", "")
    image_id =  gridfs_path.split("/")[3]
    begin
      @gridfs_file = Mongoid::GridFs.find(:filename => gridfs_path)
      self.response_body = User.find(image_id).image_url.read
      self.content_type = Mongoid::GridFs.extract_content_type(@gridfs_file.filename)
    rescue SystemCallError
      # p SystemCallError
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = 'not found'
    end
  end
end
