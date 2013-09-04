
class GridfsController < ActionController::Metal
  def serve
    gridfs_path = env["PATH_INFO"].gsub("/images/", "")
    gridfs_path =  gridfs_path.split("upload/")
    gridfs_path = gridfs_path[1]
    model_name = params[:model]
    model_id = params[:id]
    field_name = params[:field_name]
    p params[:type]
    begin
      @gridfs_file = Mongoid::GridFs.find(:filename => gridfs_path)
      # p @gridfs_file
      model_class_inst = model_name.camelcase.constantize
      model_inst = model_class_inst.find(model_id)
      field_body = model_inst.send(field_name)
      self.response_body = field_body.read
      # self.content_type = @gridfs_file.contentType
    rescue SystemCallError
      # p SystemCallError
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = 'not found'
    end
  end
end
