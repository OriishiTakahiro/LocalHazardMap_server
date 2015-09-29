class OrganizationsController < ApplicationController

	def getOrgList
		response = Hash.new()
		Organization.all.each{|org| response.store(org.id, org.name)}
		render :json => response
	end

	def registerOrg

		new_org = Organization.new
		new_org.name = params[:name]
		new_org.pw = params[:pw]
		new_org.description = params[:description]
		new_org.save

		new_layer = Layer.new
		new_layer.org_id = new_org.id
		new_layer.cener_lat = params[:center_lat] if(params[:cener_lat])
		new_layer.cener_lon = params[:center_lon] if(params[:cener_lon])
		new_layer.save

		render :json => {:org_id => new_org.id, :layer_id => new_layer_id}
	end
end
