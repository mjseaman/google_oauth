helpers do
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def current_user=(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.clear
  end

  def google_client
    @client ||= OAuth2::Client.new(
      ENV['G_API_CLIENT'], 
      ENV['G_API_SECRET'], 
      :site => 'https://accounts.google.com', 
      :authorize_url => "/o/oauth2/auth", 
      :token_url => "/o/oauth2/token"
    )
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
  end
  
end