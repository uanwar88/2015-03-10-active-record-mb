class User
  @table_name = 'users'
  extend Modules
  attr_accessor :id, :username, :total_posts, :total_threads

  @table_name = 'users'
  extend Modules

  def initialize(options)
    @id = options['id']
    @username = options['username']
    @total_posts = options['total_posts']
    @total_threads = options['total_threads']
  end

  def self.create_new(username)
    DATABASE.execute("INSERT INTO users (username) VALUES ('#{username}')")
    @id = DATABASE.last_insert_row_id
  end

  def self.fetch(username)
    result = DATABASE.execute("SELECT id, username, total_posts, total_threads FROM users WHERE username = #{username}")
    User.new(result[0])
  end

  

  def self.create_post

  end

  def self.create_thread
  end
end
