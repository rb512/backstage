class RegistrationsController < Devise::RegistrationsController

  def new
    flash[:notice] = 'You are not authorized to create accounts'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'You are not authorized to create accounts'
    redirect_to root_path
  end
end