get '/' do
  if session[:user]
    @message = "Welcome, #{session[:user].username}!"
  end
  @boards = Board.list_all
  slim :"misc/boards"
end
