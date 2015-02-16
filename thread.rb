class Thread
  @table_name = 'threads'
  extend Modules

  def self.edit_title(title,id)
    DATABASE.execute("UPDATE threads SET title = '#{title}' WHERE id = #{id}")
  end
end
