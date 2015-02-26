require 'minitest/autorun'
require 'sqlite3'
require_relative 'database_setup'
require_relative 'modules.rb'
require_relative 'user.rb'
require_relative 'post.rb'
require_relative 'thread.rb'


class TestModules < Minitest::Test
  def test_delete
    user = User.new({'username' => "captain_obvious"})
    user.insert
    User.delete(user.id)
    fetched_user = User.fetch(user.id)
    refute_equal(user.id,fetched_user.id)
  end

  def test

  end
end
