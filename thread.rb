class MBThread
  @table_name = 'threads'
  extend MainModules, ExtraModules
  attr_accessor :title, :user_id, :board_id
  attr_accessor :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @user_id = options['user_id']
    @board_id = options['board_id']
  end

  def insert
    DATABASE.execute("INSERT INTO threads (title, user_id,board_id) VALUES ('#{@title}', #{@user_id}, #{@board_id})")
    @id = DATABASE.last_insert_row_id
  end

  def edit(options)
    @title = options['title']
  end

  def save_edits
    DATABASE.execute("UPDATE threads SET title = '#{@title}' WHERE id = #{@id}")
  end

  def self.list_all_board(id)
    DATABASE.execute("SELECT * FROM threads WHERE board_id = #{id}")
  end
end
