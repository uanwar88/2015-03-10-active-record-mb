get '/board/:id' do
  @board_id = params[:id]
  @threads = MbThread.joins(:user).where(board_id: @board_id).select("mb_threads.id, mb_threads.title, mb_threads.user_id, mb_threads.board_id,
   users.username AS username")
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
