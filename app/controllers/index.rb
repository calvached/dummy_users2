get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/secret_page' do
  if session[:user_id].nil?
    redirect '/'
  else
    erb :secret_page
  end
end

get '/signout' do
  session.clear
  erb :index
end

post '/login' do
  User.authenticate(params[:email], params[:password])
  # user = User.find_by(email: params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect '/secret_page'
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
