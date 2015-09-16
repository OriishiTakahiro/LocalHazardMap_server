class OrganizationsController < ApplicationController
	def getOrgList
		response = Hash.new()
		Organization.all.each{|org| response.store(org.id, org.name)}
		render :json => {:response => response}
	end
end
