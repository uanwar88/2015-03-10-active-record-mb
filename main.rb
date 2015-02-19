require 'pry'
require 'sqlite3'
require 'slim'
require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'database_setup'
require_relative 'modules'
require_relative 'user'
require_relative 'post'
require_relative 'thread'
require_relative 'board'

binding.pry

enable :sessions

get '/' do
  if session[:user]
    @message = "Welcome, #{session[:user].username}!"
  end
  @boards = Board.list_all
  slim :boards
end

get '/board/:id' do
  @board_id = params[:id]
  @threads = MBThread.list_all_board(@board_id)
  slim :show_threads
end

get '/board/:id/new_thread' do
  @board_id = params[:id]
  slim :new_thread
end

get '/thread/:id' do
  @thread = MBThread.fetch(params[:id].to_i)
  @posts = Post.fetch_by_thread(params[:id].to_i)
  slim :show_thread
end

post '/new_thread' do
  if params['submit'].to_i == 1
    @message = params['message'].gsub(/\n/, '<br />')
    thread = session[:user].new_thread({'title' => params['title'], 'user_id' => session[:user].id, 'board_id' => params['board_id']})
    # thread = MBThread.new({'title' => params['title'], 'user_id' => session[:user].id, 'board_id' => params['board_id']})
    # thread.insert
    post = session[:user].new_post({'message' => @message, 'thread_id' => thread.id, 'user_id' => session[:user].id})
    # post = Post.new({'message' => @message, 'thread_id' => thread.id, 'user_id' => session[:user].id})
    # post.insert
  end
  redirect to("/thread/#{thread.id}")
end

get '/login' do
  slim :login
end

get '/logout' do
  session.clear
  redirect to ('/')
end

post '/login' do
  user = User.fetch(params['username'].downcase)
  if !user
    @message = "Username not found! Please enter a valid username or make a new user."
    slim :error
  else
    session[:user] = user
    redirect to ('/')
  end
end

get '/reply' do
  @thread_id = params['thread_id']
  slim :post_reply
end

get '/new_account' do
  slim :new_account
end

post '/new_account' do
  user = User.new({'username' => params['username']})
  user.insert
  session[:user] = user
  redirect to('/')
end

post '/reply' do
  @thread_id = params['thread_id']
  post = Post.new('message' => params['message'], 'thread_id' => @thread_id, 'user_id' => session[:user].id)
  post.insert
  redirect to("/thread/#{@thread_id}")
end

post '/thread/:id' do
  @thread_id = params[:id]
  slim :show_thread
end

get '/user/:id' do
  @threads = MBThread.fetch_by_user(params[:id])
  slim :show_user_threads
end
