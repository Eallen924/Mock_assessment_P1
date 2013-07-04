helpers do

	def current_user
  #   User.find(session[:user_id]) if session[:user_id] ||= @user
  # end
  	@current_user ||= User.find_by_id(session[:user_id])
	end
end
