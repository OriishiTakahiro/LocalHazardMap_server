require 'json'

class LocationsController < ApplicationController

	def postLocation
		# params => id=user_id & pw=user_pw & latitude=user_latitude & longitude=user_longitude
		user = nil
		if(user = User.find_by(:id => params[:id], :pw => params[:pw]))
			location = Location.find_or_create_by(:user_id => user.id)
			location.update(:latitude => params[:latitude], :longitude => params[:longitude])
			# 範囲指定でSemiwarningを取得
			semi_hit = Semiwarning.where("max_lat > #{params[:latitude]} and max_lon > #{params[:longitude]} and min_lat < #{params[:latitude]} and min_lon <  #{params[:longitude]}")
			result = Array.new
			if(!semi_hit.empty?)
				candidates = Warning.where(:id => semi_hit.map{|semi_warning| semi_warning.id}, :layer_id => JSON.parse(params[:layers]))
				candidates.map{ |candidate|
					apexes = JSON.parse(candidate.apexes, :quirks_mode => true)
					lat_array = apexes.map{|apex| apex.keys.first.to_f}
					lon_array = apexes.map{|apex| apex.values.first}
					conditions = [false, false] # [指定点より小さい交点があるか, 指定点より大きい交点があるか]
					user_lat = params[:latitude].to_f
					user_lon = params[:longitude].to_f
					# 各辺とy=params[:latitude]の交点を求め, その交点の経度がリクエスト座標よりも大きい点, 小さい点を発見すればその警報の範囲内にいる
					0.upto(apexes.length-1) { |i|
						i.upto(apexes.length-1) { |j|
							if((lat_array[i] < user_lat && lat_array[j] > user_lat) || (lat_array[j] < user_lat && lat_array[i] > user_lat))
								slant = (lat_array[i]-lat_array[j])/(lon_array[i]-lon_array[j])
								x = (slant*lon_array[i]-lat_array[i]+user_lat)/slant
								logger.debug "#{x} : #{slant}"
								conditions[0] = x < user_lon ? true : conditions[0]
								conditions[1] = x > user_lon ? true : conditions[1]
								if(conditions[0]&&conditions[1])
									result << candidate.disaster_id
									break
								end
							end
						}
					}
				}
			end
			response = result.uniq.map{|warning_id| 
				disaster = Disaster.find_by(:id => warning_id)
				{:name => disaster.name, :description => disaster.description}
			}
			logger.debug response
			render :json => {:response => response}
		else
			render :json => {:result => 'failed'}
		end
	end

end
