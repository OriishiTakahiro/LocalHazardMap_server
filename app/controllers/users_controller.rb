class UsersController < ApplicationController

	def entry
		new_user = User.new
		new_user.name = params[:name]
		new_user.pw = params[:pw]
		if(new_user.save)
			render :json => {:result => true}
		else
			render :json => {:result => false}
		end
	end

	def getAllUser
		all_user = User.all
		render :json => all_user
	end

end
