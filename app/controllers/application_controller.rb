class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_accessed_user
  
  private 
  # This method loads the user for which the information is being loaded
  #
  # By default it is set to the current logged in user, however if information for another 
  # user is being accessed then the session will store that accessed user

  def load_accessed_user
    if current_user
      session[:accessed_user] = current_user.id
      if params[:user_id]
        @user = User.find(params[:user_id])
        if @user
          session[:accessed_user] = @user.id
        end
      end
    end
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_user, session[:accessed_user])
  end
  
  # This method will check of the user has the authorization to access this page else 
  # redirected to the root page
  # TODO - Point to the error page
  def authorize_access
    if session[:accessed_user] != current_user.id
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end
  
end
