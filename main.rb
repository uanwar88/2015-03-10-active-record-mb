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

#binding.pry

get '/' do
  @boards = Board.list_all
  slim :boards
end

get '/board/:id' do
  @board_id = params[:id]
  @threads = Thread.list_all_board(@board_id)
  slim :show_threads
end

get 'board/:id/new_thread' do
  @board_id = params[:id]
  slim :new_thread
end

get 'thread/:id' do
  @thread =
  slim :thread_posts
end

post 'thread/:id' do
  #do some stuff
  slim :thread_posts
end

get 'user/:id/posts' do
  slim :user_posts
end

get 'user/:id/threads' do
  slim :user_threads
end
