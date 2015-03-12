get '/login' do
  slim :"login/login"
end

get '/logout' do
  session.clear
  redirect to ('/')
end

post '/login' do
  user = User.where(username: params['username'])[0]
  if user
    if BCrypt::Password.new(user.password) == params["password"]
      session[:user] = user
      if session[:user].username[0,5] == "admin"
        session[:admin] = 1
      end
      redirect to ('/')
    else
      @message = "Incorrect username or password!"
      slim :"misc/error"
    end
  else
    @message = "Incorrect username or password!"
    slim :"misc/error"
  end
end

get '/new_account' do
  slim :"login/new_account"
end

post '/new_account' do
  user = User.create(username: params['username'].downcase, password: BCrypt::Password.create(params["password"]))
  session[:user] = user
  if session[:user].username[0,5] == "admin"
    session[:admin] = 1
  end
  redirect to('/')
end
