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

get '/' do
  @boards = Board.list_all
  slim :boards
end

get '/board/:id' do
  @board_id = params[:id]
  @threads = Thread.list_all_board(@board_id)
  slim :show_threads
end

get '/board/:id/new_thread' do
  @board_id = params[:id]
  slim :new_thread
end

get '/thread/:id' do
  @thread = Thread.fetch(params[:id])
  slim :show_thread
end

post '/new_thread' do
  if params['submit'].to_i == 1
    thread = Thread.new({'title' => params['title'], 'user_id' => 1})
    thread.insert
    post = Post.new({'message' => params['message'], 'thread_id' => thread.id, 'user_id' => 1})
    post.insert
    #insert new thread and new post into database with user_id
    redirect to('/thread/#{post.id}')
  end
end

post '/thread/:id' do
  #do some stuff
  slim :show_thread
end

get '/user/:id/posts' do
  slim :user_posts
end

get '/user/:id/threads' do
  slim :user_threads
end
