require "json"

class LayersController < ApplicationController

### --------------------------------
	def registerNewLayer
		org = Organization.find_by(:name => params[:name], :pw => params[:pw])
		if(org)
			new_layer = Layer.new(:org_id => org.id, :max_lat => params[:max_lat], :max_lon => params[:max_lon], :min_lat => params[:min_lat], :min_lon => params[:min_lon])
			if(new_layer.save)
				render :json => [:result => true, :id => new_layer.id]
			else
				render :json => [:result => false]
			end
		end
	end

### --------------------------------
	def updateLayer
		org = Organization.find_by(:name => params[:name], :pw => params[:pw])
		layer = Layer.find_by(:org_id => org.id)
		if(layer)
			Warning.destroy_all(:layer_id => layer.id)
			warnings = JSON.parse(params[:warnings], :quirks_mode => true)
			# save each warning
			new_warning = nil
			0.upto(warnings.length-1) do |i|
				new_warning = Warning.new
				new_warning.layer_id = params[:layer_id]
				new_warning.disaster_id = warnings[i][0]
				new_warning.apexes = JSON.generate(warnings[i].each.with_index.map{|info, j| info if j != 0}.compact)
				new_warning.save
			end
			render :json => [:result => :succeeded!, :layer_id => layer.id, :warnings => Warning.where(:layer_id => layer.id).to_a]
		else
			render :json => [:result => :failed!]
		end
	end

### --------------------------------

end
