class GridfsController < ActionController::Metal

  def serve
    gridfs_path = env["PATH_INFO"].gsub("/images/", "")
    gridfs_path =  gridfs_path.split("upload/")
    gridfs_path = gridfs_path[1]
    begin
      @gridfs_file = Mongoid::GridFs.find(:filename => gridfs_path)
      self.response_body = @gridfs_file.data
      self.content_type = "image/png" #@gridfs_file.contentType
    rescue SystemCallError
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = 'not found'
    end
  end

end
