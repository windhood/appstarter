class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor :remember_me
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :remember_me, :username

  validates_presence_of :password, :on => :create
  #validates_uniqueness_of :email
  validates :email, :presence => true, 
                    :uniqueness => true,
                    :format   => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  validates_length_of :password, :minimum => 6, :message => "password must be at least 6 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
end
