require 'pry'
require 'sqlite3'
require 'slim'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'bcrypt'
require 'twilio-ruby'

password = BCrypt::Password.create("hello")
puts password

# @message = @client.account.messages.create({:to => "+12316851234",
#                                    :from => "+15555555555",
#                                    :body => "Hello there!"})

require_relative 'database/database_setup'
# require_relative 'models/modules'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/thread'
require_relative 'models/board'
require_relative 'helpers/main'

#controllers
require_relative 'controllers/accounts.rb'
require_relative 'controllers/board.rb'
require_relative 'controllers/main.rb'
require_relative 'controllers/thread.rb'

#enable sinatra sessions
enable :sessions

#binding.pry
