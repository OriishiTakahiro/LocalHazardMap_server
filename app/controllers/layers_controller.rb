require "json"

class LayersController < ApplicationController

### --------------------------------
	def registerNewLayer
		#params => name=org_name & pw=org_pw & max_lat=max_lat & max_lon=max_lon & min_lat=min_lat & min_lon=min_lon
		org = Organization.find_by(:name => params[:name], :pw => params[:pw])
		if(org)
			new_layer = Layer.new
			new_layer.org_id = new_org.id
			new_layer.cener_lat = params[:center_lat] if(params[:cener_lat])
			new_layer.cener_lon = params[:center_lon] if(params[:cener_lon])
			if(new_layer.save)
				render :json => [:result => true, :id => new_layer.id]
			else
				render :json => [:result => false]
			end
		end
	end

### --------------------------------
	def updateLayer
		#params	=> name=hoge & pw=hoge & layer_id=hoge & warnings=["disaster_id",{"lat:lon","lat:lon"},{"lat:lon"}],["disaster_id",{"lat:lon"},{"lat:lon"},{"lat:lon"}],...]
		org = Organization.find_by(:name => params[:name], :pw => params[:pw])
		layer = Layer.find_by(:org_id => org.id)
		if(layer)
			### delete old warnings
			old_warnings = Warning.where(:layer_id => layer.id)
			old_semi_warnings = Semiwarning.where(:id => old_warnings.map{|warning| warning.id})
			old_warnings.delete_all
			old_semi_warnings.delete_all
			###
			
			warnings = JSON.parse(params[:warnings], :quirks_mode => true)
			# save each warning
			new_warning = nil
			0.upto(warnings.length-1) do |i|

				apexes = warnings[i].each.with_index.map{|info, j| info if j > 1}.compact
				lat_array = apexes.map{|apexe| apexe.keys[0]}
				lon_array = apexes.map{|apexe| apexe.values[0]}

				new_warning = Warning.new
				new_warning.layer_id = params[:layer_id]
				new_warning.disaster_id = warnings[i][0]
				new_warning.apexes = JSON.generate(apexes)
				new_warning.risk_level = warnings[i][1]
				new_warning.save

				Semiwarning.create(:id => new_warning.id, :max_lat => lat_array.max, :max_lon => lon_array.max, :min_lat => lat_array.min, :min_lon => lon_array.min)
			end
			###
			render :json => [:result => true, :layer_id => layer.id, :warnings => Warning.where(:layer_id => layer.id).to_a]
		else
			render :json => [:result => false]
		end
	end

### --------------------------------
	def getMap
		rank_list = JSON.parse(params[:request], :quirks_mode => true)
		orgs = Organization.where(:rank => rank_list)
		layers = Layer.where(:org_id => orgs)
		warnings = Warning.where(:layer_id => layers.map{|layer| layer.id}).map{|warning| [warning.disaster_id, JSON.parse(warning.apexes, :quirks_mode => true)] if warning}
		if(rank_list.include?(1))
			Contribution.all.each{|cont| warnings << [0, [cont.latitude.to_s => cont.longitude.to_f]]}
		end
		warnings.each{ |polygon|
			logger.debug polygon
		}
		render :json => {:response => warnings}
	end

end
