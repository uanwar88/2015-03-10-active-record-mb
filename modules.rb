module MainModules
  # Description: Deletes an SQL entry by id.
  # Params:
  # + id: An integer specifying the row id.
  def delete(id)
    DATABASE.execute("DELETE FROM #{@table_name} WHERE id = #{id}")
  end

  def list_all
    # Description: Lists all rows in a table associated with a class when called from that class.
    # No params.
    # Returns: An array containing hashes.
    DATABASE.execute("SELECT * FROM #{@table_name}")
  end

  def fetch(input)
    # Description: Fetches a single row with a matching id or username.
    # Params:
    # + input: An integer specifcying a row id, or a username string.
    # Returns: An array containing a hash.
    if input.is_a?(Integer)
      result = DATABASE.execute("SELECT * FROM #{@table_name} WHERE id = #{input}")
      self.new(result[0])
    else
      result = DATABASE.execute("SELECT * FROM users WHERE username = '#{input}'")
      if result[0]
        User.new(result[0])
      end
    end
  end
end

module ExtraModules
  # Description: Can be used to fetch a Post or Thread by a specified user_id.
  # Params:
  # + user_id: A user_id integer.
  # Returns: An array containing a hash(es).
  def fetch_by_user(user_id)
    DATABASE.execute("SELECT * FROM #{@table_name} WHERE user_id = #{user_id}")
  end
end
