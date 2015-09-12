class OrganizationsController < ApplicationController
	def getOrgList
		render :json => Organization.all.map{|org| {org.id => org.name}}
	end
end
