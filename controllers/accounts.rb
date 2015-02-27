get '/login' do
  slim :"login/login"
end

get '/logout' do
  session.clear
  redirect to ('/')
end

post '/login' do
  user = User.fetch(params['username'].downcase)
  if !user
    @message = "Username not found! Please enter a valid username or make a new user."
    slim :"misc/error"
  else
    session[:user] = user
    if session[:user].username[0,5] == "admin"
      session[:admin] = 1
    end
    redirect to ('/')
  end
end

get '/new_account' do
  slim :"login/new_account"
end

post '/new_account' do
  user = User.new({'username' => params['username']})
  user.insert
  session[:user] = user
  redirect to('/')
end
