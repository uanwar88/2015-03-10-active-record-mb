get '/login' do
  slim :"login/login"
end

get '/logout' do
  session.clear
  redirect to ('/')
end

post '/login' do
  user = User.where("username = ?", params['username'])
  if user.empty?
    @message = "Username not found! Please enter a valid username or make a new user."
    slim :"misc/error"
  else
    session[:user] = user[0]
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
  user = User.create(username: params['username'].downcase, password: Bcrypt::Password.create(params["password"]))
  session[:user] = user
  if session[:user].username[0,5] == "admin"
    session[:admin] = 1
  end
  redirect to('/')
end
