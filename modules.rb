class Modules
  def delete(id)
    DATABASE.execute("DELETE FROM #{@table_name} WHERE id = #{id}")
  end
end
