get '/create_url' do
  @user = session[:user_id]
  erb :short_url
end

post '/create_url' do
  if session[:user_id].nil?
    url = Url.find_or_create_by!(url: params[:url])
    redirect "/generated/#{url.short_url}"
  else
    user = User.find(session[:user_id])
    url = user.urls.find_or_create_by!(url: params[:url])
    redirect "/generated/#{url.short_url}"
  end
  # user = User.find(session[:user_id])
  # url = user.urls.find_or_create_by!(url: params[:url])

  # redirect "/generated/#{url.short_url}"
end

get '/generated/:short_url' do
  url = Url.find_by(short_url: params[:short_url])
  @count = url.click_count
  @sh_url = url.short_url
  puts '============ Session at generated page =================='
  p session
  erb :generated
end

get '/:some_url' do
  puts '============ Session at access page =================='
  p session
  # redirect '/' if session[:user_id].nil?
  url = Url.find_by(short_url: params[:some_url])
  if url
    url.click_count += 1
    url.save
    redirect "http://#{url.url}"
  else
    'This url does not exist, fool!'
  end
end

# Unlogged user must be able to generate short urls
# Logged in user must be able to use any url that has been generated
