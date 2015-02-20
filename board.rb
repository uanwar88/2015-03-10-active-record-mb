class Board
  @table_name = 'boards'
  extend MainModules
  attr_accessor :title, :description
  attr_reader :id, :total_posts, :total_threads

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @description = options['description']
    @total_posts = options['total_posts']
    @total_threads = options['total_threads']
  end

  # Description: Insert new board object into database.
  def insert
    DATABASE.execute("INSERT INTO boards (title,description) VALUES ('#{@title}', '#{@description}')")
    @id = DATABASE.last_insert_row_id
  end

  # Description: Update board object title and description in database.
  def save_edits
    DATABASE.execute("UPDATE boards SET title = '#{@title}', description = '#{@description}' WHERE id = #{@id}")
  end
end
