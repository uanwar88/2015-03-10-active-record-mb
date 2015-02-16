class Post
  @table_name = 'posts'
  extend Modules

  def self.update(message,id)
    DATABASE.execute("UPDATE posts SET message = '#{message} WHERE id = #{id}'")
  end

  def self.fetch_by(thread_id,user_id)
    DATABASE.execute("SELECT id, message, thread_id, user_id FROM posts WHERE id = #{id}")
  end
end
