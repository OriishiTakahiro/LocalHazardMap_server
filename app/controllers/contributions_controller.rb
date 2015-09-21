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

			semi_cont = Semicontribution.new()
			dx = 5000/6378137.0
			dy = 5000*0.1113195
			semi_cont.max_lat = params[:latitude].to_f+dy
			semi_cont.min_lat = params[:latitude].to_f-dy
			semi_cont.max_lon = params[:longitude].to_f+dx
			semi_cont.min_lon = params[:longitude].to_f+dx
			semi_cont.save

			render :json => {:result => "succeeded", :id => cont.id}
		else
			render :json => {:result => "failed"}
		end

	end

	def tmp
			1.upto(Contribution.all.length-Semicontribution.all.length) do |i|
				semi_cont = Semicontribution.new()
				semi_cont.max_lat = 0
				semi_cont.min_lat = 0
				semi_cont.max_lon = 0
				semi_cont.min_lon = 0
				semi_cont.save
			end
			render :json => Contribution.all.map{|cont| cont.id}+Semicontribution.all.map{|semi| semi.id}
	end

end
