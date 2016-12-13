# encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize

  protect_from_forgery with: :exception
  
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url,:notice=>"please log in"
      end
    end
    def authorize_admin
      unless Admin.find_by_id(session[:admin_id])
        redirect_to adminlogin_path,:notice=>"please log in"
      end
    end
end
