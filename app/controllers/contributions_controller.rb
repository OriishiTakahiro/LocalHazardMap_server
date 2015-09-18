class ContributionsController < ApplicationController

	def postContribution
		if(User.find_by(:id => params[:id], :pw => params[:pw]))
			cont = Contribution.new()
			cont.user_id = params[:id]
			cont.latitude = params[:latitude]
			cont.longitude = params[:longitude]
			cont.title =params[:title]
			cont.description = params[:description]
			cont.save
			render :json => {:result => "succeeded", :id => cont.id}
		else
			render :json => {:result => "failed"}
		end
	end

end
