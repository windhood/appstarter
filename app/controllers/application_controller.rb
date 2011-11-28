# get most content from https://github.com/krisrang/pawdrop/blob/master/app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  if Rails.env.production?
      rescue_from Exception, with: :render_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from AbstractController::ActionNotFound, with: :render_not_found
      rescue_from ActionController::RoutingError, with: :render_not_found
      rescue_from ActionController::UnknownController, with: :render_not_found
      rescue_from ActionController::UnknownAction, with: :render_not_found
      #rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found
    end
    
    #rescue_from CanCan::AccessDenied, with: :render_unauthorized
    #prepend_before_filter :api_login
    protect_from_forgery

    helper_method :logged_in?

    def not_authenticated
      redirect_to login_url, alert: "This page requires logging in."
    end

    def require_admin
      !!current_user && current_user.admin
    end

    def always_fresh
      headers['Last-Modified'] = Time.now.httpdate
    end

    def render_error e
      error_mail e
      render template: "errors/500", layout: false, status: 500
    end

    def render_not_found e
      error_mail e

      respond_to do |format|
        format.html { redirect_to root_url, alert: "Resource not found" }
        format.json { render json: { error: "Not Found" }, status: 404 }
      end
    end

    def render_unauthorized e
      error_mail e

      respond_to do |format|
        format.html do
          if logged_in?
            redirect_to root_url, alert: "Cannot access specified resource"
          else
            require_login
          end
        end
        format.json { render json: { error: "Unauthorized" }, status: 403 }
      end
    end

    def error_mail e
      ErrorMailer.error(e, request, current_user).deliver if Rails.env.production?
    end

    def api_login
      authenticate_with_http_basic do |user_name, password|
        if user_name == "auth" && password == Settings.whisker_key
          user = User.where({admin: true}).first
          auto_login(user) if user
        end
      end
    end
end
