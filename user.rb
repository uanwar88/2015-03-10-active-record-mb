class User
  @table_name = 'users'
  extend MainModules, ExtraModules
  attr_accessor :id, :username, :total_posts, :total_threads

  @table_name = 'users'


  # Description: Creates a new user object.
  # Params:
  # - options: Requires a hash with key value pairs.
  #   - required keys/values:
  #     - 'username': String, A username.
  # Returns: A user object.

  def initialize(options)
    @id = options['id']
    @username = options['username'].downcase
    @total_posts = options['total_posts']
    @total_threads = options['total_threads']
  end

  def insert
    DATABASE.execute("INSERT INTO users (username) VALUES ('#{@username}')")
    @id = DATABASE.last_insert_row_id
    self
  end

  def new_post(options)
    post = Post.new('message' => options['message'], 'thread_id' => options['thread_id'], 'user_id' => @id)
    post.insert
    DATABASE.execute("UPDATE users SET total_posts = total_posts + 1 WHERE user_id = #{@id}")
    return post
  end

  def new_thread(options)
    thread = Thread.new('title' => options['title'], 'user_id' => @id)
    thread.insert
    return thread
  end
end
