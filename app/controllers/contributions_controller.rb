class ContributionsController < ApplicationController

	def postContribution

		if(User.find_by(:id => params[:id], :pw => params[:pw]))

			cont = Contribution.new()
			cont.user_id = params[:id]
			cont.latitude = params[:latitude]
			cont.longitude = params[:longitude]
			cont.title = params[:title]
			cont.risk_level = 1
			cont.description = params[:description]
			cont.img = params[:img]
			cont.save

			semi_cont = Semicontribution.new()
			dx = 150/110956.76863201741
			dy = 150/90045.41003629414
			logger.debug "#{dy} : #{dx}"
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

	def enableContribution
		if(Organization.find_by(:name => params[:name], :pw => params[:pw]))
			Contribution.find_by(:id => params[:id]).update(:risk_level => params[:risk_level])
			render :json => ""
		else
			render :json => "request failed"
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

	def reset
		Contribution.destroy_all
		Semicontribution.destroy_all
		render :json => {:message => "all_delete"}
	end

end
