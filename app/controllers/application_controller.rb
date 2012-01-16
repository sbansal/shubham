class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  before_filter :load_accessed_user, :set_user_time_zone, :store_location, :load_tweet
  
  def load_tweet
    @tweet = Twitter.user_timeline("tracelyapp").first
    @twext = @tweet.text.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
      else
        "<a href='#{url}'>#{url}</a>"
      end
    end
  end
  
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
  
  # This method will check of the user has the authorization to access this page else 
  # redirected to the root page
  # TODO - Point to the error page
  def authorize_access
    if session[:accessed_user] != current_user.id
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end
  
  def set_user_time_zone
    Time.zone = "Central Time (US & Canada)"
    if user_signed_in?
      if current_user.timezone
        Time.zone = current_user.timezone
      end
    end
  end

  def store_location
    # unless the stored location is the devise controller or pages controller we will store the location
    # don't redirect to the pages controller after successful sign in. Those are static pages
    session[:user_return_to] = request.url unless (params[:controller] == "devise/sessions" || params[:controller] == "pages")
  end

  def after_sign_in_path_for(resource)
      stored_location_for(resource) || user_tasks_path(resource)
  end
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  
end
