class UsersController < ApplicationController
  
  before_filter :authenticate_user!,:authorize_admin_access
  
  def index
    @users = User.all
  end
  
  def authorize_admin_access
    unless current_user.admin?
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

end
