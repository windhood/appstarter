class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        #Rails.logger.debug '11'
        auto_login(@user)
        format.html { redirect_to root_url, :notice => "Signed up!" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    
  end

end
