class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  validates_presence_of :title, :description, :file
  mount_uploader :file, ImageUploader
  attr_accessible :title, :description, :file, :file_cache, :remove_file
  
  #validates_presence_of :avatar
  #validates_integrity_of :avatar
  #validates_processing_of :avatar
  
  def default_url(size=96)
    hash = Digest::MD5.hexdigest(self.email || self.name)
    "http://robohash.org/#{hash}?size=#{size}x#{size}&gravatar=hashed"
  end
  
  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
  {
    "id" => read_attribute(:id),
    "title" => read_attribute(:title),
    "description" => read_attribute(:description),
    "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.thumb.url,
    "delete_url" => picture_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
end