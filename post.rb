class Post
  @table_name = 'posts'
  extend MainModules
  extend ExtraModules
  attr_accessor :message, :thread_id, :user_id, :id

  def initialize(options)
    @message = options['message']
    @thread_id = options['thread_id']
    @user_id = options['user_id']
  end

  def insert
    DATABASE.execute("INSERT INTO posts (message, thread_id, user_id) VALUES ('#{@message}',#{@thread_id}, #{@user_id})")
    @id = DATABASE.last_insert_row_id
  end

  def edit(options)
    @message = options['message']
  end

  def save_edits
    DATABASE.execute("UPDATE posts SET message = '#{@message}' WHERE id = #{@id}")
  end

  def self.fetch_by_thread(id)
    result = DATABASE.execute("SELECT * FROM posts WHERE thread_id = #{id}")
    posts = []
    result.each do |x|
      posts << Post.new(x)
    end
    return posts
  end
end
