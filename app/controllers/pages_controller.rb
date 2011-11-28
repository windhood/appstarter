class PagesController < ApplicationController
  #layout :set_layout
  #before_filter :set_user_for_login
  
  def home    
  end

  def contact
  end
  
  def about
  end

  protected
    def set_layout
      params[:action] == "home" && logged_in? ? 'application' : 'static'
    end

    def set_user_for_login
      unless logged_in?
         @user = User.new
      end
    end
end