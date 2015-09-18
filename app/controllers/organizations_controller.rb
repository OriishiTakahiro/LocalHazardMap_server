class OrganizationsController < ApplicationController

	def getOrgList
		response = Hash.new()
		Organization.all.each{|org| response.store(org.id, org.name)}
		render :json => {:response => response}
	end

	def registerOrg
		new_org = Organization.new
		if(params[:id]) then
			new_org.id = params[:id]
		end
		new_org.name = params[:name]
		new_org.pw = params[:pw]
		new_org.description = params[:description]
		new_org.save
		render :json => Organization.all
	end
end
