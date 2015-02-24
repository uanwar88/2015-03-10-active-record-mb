get '/board/:id' do
  @board_id = params[:id]
  @threads = MBThread.list_all_board(@board_id)
  slim :"threads/show_threads"
end

get '/board/:id/new_thread' do
  @board_id = params[:id]
  slim :"threads/new_thread"
end
