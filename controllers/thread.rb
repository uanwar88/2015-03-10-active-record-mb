get '/thread/:id' do
  @thread = MBThread.fetch(params[:id].to_i)
  @posts = Post.fetch_by_thread(params[:id].to_i)
  @users_array = MBThread.users_in_thread(params[:id])
  #join_users(@users_hash)
  @users = join_usernames(@users_array)
  slim :"threads/show_thread"
end

post '/new_thread' do
  if params['submit'].to_i == 1
    @message = params['message'].gsub(/\n/, '<br />')
    thread = session[:user].new_thread({'title' => params['title'], 'user_id' => session[:user].id, 'board_id' => params['board_id']})
    post = session[:user].new_post({'message' => @message, 'thread_id' => thread.id, 'user_id' => session[:user].id})
  end
  redirect to("/thread/#{thread.id}")
end

get '/reply' do
  @thread_id = params['thread_id']
  slim :"threads/post_reply"
end

post '/reply' do
  @thread_id = params['thread_id'].to_i
  thread = MBThread.fetch(@thread_id)
  post = Post.new('message' => params['message'], 'thread_id' => @thread_id, 'user_id' => session[:user].id)
  post.insert
  #send text message when replying.
  send_text_message(session[:user].username,thread.title,params['message'])
end

post '/thread/:id' do
  @thread_id = params[:id]
  @users = MBThread.users_in_thread(params[:id])
  slim :"threads/show_thread"
end

get '/user/:id' do
  @threads = MBThread.fetch_by_user(params[:id])
  slim :"threads/show_user_threads"
end
