get '/' do
  @boards = Board.all
  slim :"misc/boards"
end
