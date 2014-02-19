get '/create_url' do
  # Look in app/views/index.erb
  erb :short_url
end

post '/create_url' do
  user = User.find(session[:user_id])
  puts '================= THIS IS SPARTA ==================='
  p url = user.urls.find_or_create_by!(url: params[:url])

  # url = Ur.new(url: params[:url])
  # url will be an object with a url property on it
  # url.url works
  # before save the callback will run
  # url will now have short_url
  # url.save
  # url is saved to db | url is persisted
  redirect "/generated/#{url.short_url}"
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
    puts '=========== What are you?? ==============='
    p session
    url.click_count += 1
    url.save
    redirect "http://#{url.url}"
  else
    'This url does not exist, fool!'
  end
end
