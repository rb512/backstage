class DashboardController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def home
    admin = current_admin_user if admin_user_signed_in?
    
  end
  
  
  
end
