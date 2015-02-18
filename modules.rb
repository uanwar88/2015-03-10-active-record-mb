module MainModules
  def delete(id)
    DATABASE.execute("DELETE FROM #{@table_name} WHERE id = #{id}")
  end

  def list_all
    DATABASE.execute("SELECT * FROM #{@table_name}")
  end

  def self.fetch(input)
    if input.is_a?(Integer)
      result = DATABASE.execute("SELECT * FROM #{@table_name} WHERE id = #{input}")
      self.new(result[0])
    else
      result = DATABASE.execute("SELECT * FROM users WHERE username = '#{input}'")
      User.new(result[0])
    end
  end
end

module ExtraModules
  def fetch_by_user(user_id)
    result = DATABASE.execute("SELECT * FROM #{@table_name} WHERE user_id = #{user_id}")
    return result[0]
  end
end
