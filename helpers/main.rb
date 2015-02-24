helpers do
  # Description: Joins an array of users hashes containing usernames into a string separated by commas.
  # Params:
  # + array: An array containing multiple hashes with usernames.
  # Returns: A string of usernames separated by commas.
  def join_usernames(array)
    users = []
    array.each do |x|
      users << x['username']
    end
    return users.join(", ")
  end

  def send_text_message
    @client = Twilio::REST::Client.new account_sid, auth_token
    @message = @client.account.messages.create({:to => "+17122126176",
                                     :from => "+17125878132",
                                     :body => "New Reply by #{session[:user].username} - #{thread.title} - #{params['message']}"})
    redirect to("/thread/#{@thread_id}")
  end
end
