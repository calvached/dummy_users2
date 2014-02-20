get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/users/:id' do
  if session[:user_id].nil?
    redirect '/'
  else
    @user = User.find(session[:user_id])
    @urls = @user.urls
    erb :secret_page
  end
end

get '/signout' do
  session.clear
  erb :index
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])

  if user
    session[:user_id] = user.id
    puts '============ Session at Login ================'
    p session
    redirect "/users/#{session[:user_id]}"
  else
    redirect '/'
  end
end


post '/signup' do
  User.create(first_name: params[:first_name],
              last_name: params[:last_name],
              email: params[:email],
              password: params[:password])
  redirect '/'
end
