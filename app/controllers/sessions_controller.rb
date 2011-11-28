class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    
    respond_to do |format|
      if user
        format.html { redirect_back_or_to root_url, :notice => "Logged in!" }
        format.json { render json: user, status: :created, location: user }
      else
        @user = User.new
        flash.now.alert = "Email or password was invalid."
        format.html { render :new }
        format.json { render json: "login_failed", status: :unprocessable_entity }
      end
    end
    
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end