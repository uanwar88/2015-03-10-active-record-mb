get '/thread/:id' do
  @thread = MbThread.find(params[:id].to_i)
  @posts = Post.joins(:user).where(mb_thread_id: params[:id]).select("posts.id, posts.message, posts.mb_thread_id, posts.user_id, users.username AS username,
  users.total_posts AS total_posts")
  @users = join_usernames(@posts)
  slim :"threads/show_thread"
end

post '/new_thread' do
  if params['submit'].to_i == 1
    @message = params['message'].gsub(/\n/, '<br />')
    thread = MbThread.create(title: params['title'], user_id: session[:user].id, board_id: params['board_id'])
    Post.create(message: @message, mb_thread_id: thread.id, user_id: session[:user].id)
    User.where(id: session[:user].id).update_all('total_posts = total_posts + 1')
  end
  redirect to("/thread/#{thread.id}")
end

get '/reply' do
  @thread_id = params['thread_id']
  slim :"threads/post_reply"
end

post '/reply' do
  thread_id = params['thread_id'].to_i
  message = params['message']

  Post.create(message: message, mb_thread_id: thread_id, user_id: session[:user].id)

  #send text message when replying
  #send_text_message(session[:user].username,thread.title,message)

  #Increment total_posts
  User.where(id: session[:user].id).update_all('total_posts = total_posts + 1')
  redirect to("/thread/#{params['thread_id']}")
end

# post '/thread/:id' do
#   @thread = MbThread.find(params[:id].to_i)
#   @posts = Post.joins(:user).where("mb_thread_id = ?", "#{params[:id]}").select("posts.message, posts.mb_thread_id, posts.user_id, users.username AS username,
#   users.total_posts AS total_posts")
#   @users = join_usernames(@posts)
# end

get '/user/:id' do
  @threads = MbThread.find(params[:id].to_i)
  slim :"threads/show_user_threads"
end

get '/edit/post/:id' do
  @post = Post.find(params[:id].to_i)
  if @post.user_id == session[:user].id || session[:admin] == 1
    slim :"threads/edit_post"
  else
    @message = "You can't edit this post."
    slim :"misc/error"
  end
end

post '/edit/post/:id' do
  post = Post.find(params[:id].to_i)
  if post.user_id == session[:user].id || session[:admin] == 1
    post.message = params['message'].gsub(/\n/, '<br />')
    post.save
    redirect to("/thread/#{post.mb_thread_id}")
  else
    @message = "You can't edit this post."
    slim :"misc/error"
  end
end

get '/delete/post/:id' do
  if session[:admin] == 1
    post = Post.find(params['id'].to_i)
    Post.delete(params['id'].to_i)
    redirect to("/thread/#{post.mb_thread_id}")
  else
    @message = "You can't do that."
    slim :"misc/error"
  end
end
