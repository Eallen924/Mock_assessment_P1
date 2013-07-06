#----------- Edit -----------

get '/user/:user_id' do
  # render user information
  @user = User.find(params[:user_id])
  erb :user_profile
end

get '/user/edit/:user_id' do
	@user = User.find(params[:user_id])
 #render user Edit page
  if current_user.id == @user.id
    erb :edit_profile
  else
  	erb :edit_error
  end
end

get '/delete_skill/:skill_id' do
	skill_to_delete = current_user.proficiencies.find(params[:skill_id])
	skill_to_delete.destroy if skill_to_delete
	redirect "/user/edit/#{current_user.id}"
end

post '/add_skill' do
	# skill_to_add_id = Skill.find_by_name(params[:skill][:name]).id
	p params
	current_user.proficiencies.create(params[:skill])#'user_id' => current_user.id,
										 # 'skill_id' => skill_to_add_id,
										 # 'years' => params[:skill][:years],
										 # 'formal' => params[:skill][:formal])
	redirect "/user/edit/#{current_user.id}"
end

get '/add_skill' do
	@addable_skills = Skill.addable_by(current_user)
	erb :add_skill
end

post '/update/:user_id' do
	p params[:user]
	# if User.authenticate(current_user.email, params[:user][:old_password])
	# 	# go ahead with edits
 # 	else
	# 	@errors = current_user.errors.full_messages
	# end

	# if params[:user][:new_password] == params[:user][:new_password_confirmation]
	# 	params[:user][:password] = params[:user][:new_password]
	# else
	# 	@errors = "New Password Does Not Match"
	# 	p @errors
	# 	erb :edit_profile
	# end

	current_user.update_attributes(params[:user])
	p current_user.errors.full_messages
	params[:proficiencies].each do |id, p_params|
		proficiency_to_update = current_user.proficiencies.find(id)
		if proficiency_to_update
			proficiency_to_update.update_attributes(p_params)
		end
	end

	redirect "/user/edit/#{current_user.id}"
end
