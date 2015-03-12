class Post < ActiveRecord::Base
  belongs_to :mb_thread
  belongs_to :user
  # @table_name = 'posts'
  # extend MainModules
  # extend ExtraModules
  # attr_accessor :message
  # attr_reader :thread_id, :user_id, :id
  #
  # def initialize(options)
  #   @id = options['id']
  #   @message = options['message']
  #   @thread_id = options['thread_id']
  #   @user_id = options['user_id']
  # end
  #
  # # Description: Inserts a Post object into the database and increments the user's total_posts.
  # # Returns: An integer specifying the post id.
  # def insert
  #   DATABASE.execute("INSERT INTO posts (message, thread_id, user_id) VALUES ('#{@message}',#{@thread_id}, #{@user_id})")
  #   DATABASE.execute("UPDATE users SET total_posts = total_posts + 1 WHERE id = #{@user_id}")
  #   @id = DATABASE.last_insert_row_id
  # end
  #
  # # Description: Updates the edited post message in the database.
  # def save_edits
  #   DATABASE.execute("UPDATE posts SET message = '#{@message}' WHERE id = #{@id}")
  # end
  #
  # # Description: Fetches all the posts in a single thread.
  # # Params:
  # # + id: Integer specifying the thread id.
  # # Returns: An array containing post hashes.
  # def self.fetch_by_thread(id)
  #   result = DATABASE.execute("SELECT * FROM posts WHERE thread_id = #{id}")
  #   posts = []
  #   result.each do |x|
  #     posts << Post.new(x)
  #   end
  #   return posts
  # end
end
