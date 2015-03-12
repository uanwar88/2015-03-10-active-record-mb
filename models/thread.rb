class MbThread < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  has_many :posts, dependent: :destroy
  # @table_name = 'threads'
  # extend MainModules, ExtraModules
  # attr_accessor :title, :user_id, :board_id
  # attr_accessor :id
  #
  # def initialize(options)
  #   @id = options['id']
  #   @title = options['title']
  #   @user_id = options['user_id']
  #   @board_id = options['board_id']
  # end
  #
  # # Description: Inserts the MBThread object into the database and increments the user's total_threads.
  # def insert
  #   DATABASE.execute("INSERT INTO threads (title, user_id,board_id) VALUES ('#{@title}', #{@user_id}, #{@board_id})")
  #   DATABASE.execute("UPDATE users SET total_threads = total_threads + 1 WHERE id = #{@user_id}")
  #   @id = DATABASE.last_insert_row_id
  # end
  #
  # # Description: Edit a thread title.
  # # Params:
  # # + options: A hash containing the following key/value pairs:
  # #   - 'title' => String, a new title
  # def edit(options)
  #   @title = options['title']
  # end
  #
  # # Description: Updates the thread title in the database.
  # def save_edits
  #   DATABASE.execute("UPDATE threads SET title = '#{@title}' WHERE id = #{@id}")
  # end
  #
  # # Description: List all threads in a selected board.
  # # Params:
  # # + id: Integer, board_id
  # # Returns: An array of hashes containing the threads in a board.
  # def self.list_all_board(id)
  #   DATABASE.execute("SELECT * FROM threads WHERE board_id = #{id}")
  # end
  #
  # Description: List all users in a given thread.
  # Params:
  # + id: Integer, thread_id
  # Returns: An array of hashes containing thread_id, user_id, and username.
  # def self.users_in_thread(id)
  #   DATABASE.execute("SELECT DISTINCT posts.thread_id, posts.user_id, users.username FROM posts JOIN users on users.id = posts.user_id
  #   WHERE thread_id = #{id}")
  # end
end
