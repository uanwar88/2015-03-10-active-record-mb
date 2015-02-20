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
    options ||= {}
    if options['username']
      @id = options['id']
      @username = options['username'].downcase
      @total_posts = options['total_posts']
      @total_threads = options['total_threads']
    end
  end

  # Description: Inserts a user object into the database.
  # Returns: The initial user object.
  def insert
    DATABASE.execute("INSERT INTO users (username) VALUES ('#{@username}')")
    @id = DATABASE.last_insert_row_id
    self
  end


  # Description: Creates and inserts a new post by a user object.
  # Params:
  # + options: A hash containing the following key value pairs:
  #   - 'message' => String
  #   - 'thread_id' => Integer
  #   - 'user_id' => Not requried. Specified automatically.
  # Returns: A Post object.
  def new_post(options)
    post = Post.new({'message' => options['message'], 'thread_id' => options['thread_id'], 'user_id' => @id})
    post.insert
    return post
  end

  # Description: Creates and inserts a new post by a user object.
  # Params:
  # + options: A hash containing the following key value pairs:
  #   - 'Title' => String
  #   - 'board_id' => Integer
  #   - 'user_id' => Not requried. Specified automatically.
  # Returns: A Thread object.
  def new_thread(options)
    thread = MBThread.new({'title' => options['title'], 'user_id' => @id, 'board_id' => options['board_id']})
    thread.insert
    return thread
  end
end
