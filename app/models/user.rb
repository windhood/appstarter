class User < ActiveRecord::Base
  #mount_uploader :avatar, AvatarUploader
  authenticates_with_sorcery!
  attr_accessor :remember_me
  
  attr_accessible :email, :password, :password_confirmation, 
                  :first_name, :last_name, :remember_me, 
                  :username

  validates_presence_of :password, :on => :create
  #validates_uniqueness_of :email
  validates :email, :presence => true, 
                    :uniqueness => true,
                    :format   => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  validates_length_of :password, :minimum => 6, :message => "password must be at least 6 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  
  def name
    if first_name.blank? && last_name.blank?
      nil
    else
      "#{first_name} #{last_name}"
    end
  end
  
  def default_avatar_url(size=96)
    hash = Digest::MD5.hexdigest(self.email || self.name)
    "http://robohash.org/#{hash}?size=#{size}x#{size}&gravatar=hashed"
  end
end
