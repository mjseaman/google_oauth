get '/' do
  erb :index
end

not_found do
	@request = request.path_info
	erb :not_found, layout: false
end

get '/auth' do
	redirect google_client.auth_code.authorize_url(:redirect_uri => redirect_uri,:scope => SCOPES,:access_type => "offline")
end

get '/oauth2callback' do
  access_token = google_client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
  @info = access_token.get('https://www.googleapis.com/oauth2/v1/userinfo?alt=json').parsed
  
  user = User.find_or_create_by_email(@email)
  user.first_name = @info["given_name"]
	user.last_name = @info["family_name"]
	user.access_token = access_token.token
	user.photo_url = @info["picture"]
	user.save

  current_user = user
  p "Successfully authenticated with the server"
 
  # parsed is a handy method on an OAuth2::Response object that will 
  # intelligently try and parse the response.body
  p "info:"
  p @info
  p @email
  erb :success
end

get '/logout' do
	logout
end