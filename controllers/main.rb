get '/' do
  @boards = Board.list_all
  slim :"misc/boards"
end
