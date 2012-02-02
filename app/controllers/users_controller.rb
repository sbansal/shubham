class UsersController < ApplicationController
  
  before_filter :authenticate_user!,:authorize_admin_access
  
  def index
    @users = User.includes(:tasks, :habits).order('current_sign_in_at DESC')
  end
  
  def authorize_admin_access
    unless current_user.admin?
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

end
