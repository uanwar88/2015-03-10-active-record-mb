get '/board/:id' do
  @board_id = params[:id]
  @threads = MbThread.where("board_id = ?", "#{@board_id}")
  slim :"threads/show_threads"
end

get '/board/:id/new_thread' do
  @board_id = params[:id]
  slim :"threads/new_thread"
end

get '/new_board' do
  slim :"misc/new_board"
end

post '/new_board' do
  Board.create(title: params['title'], description: params['description'])
  redirect to('/')
end
