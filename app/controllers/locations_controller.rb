require 'json'

class LocationsController < ApplicationController

	def postLocation
		# params => id=user_id & pw=user_pw & latitude=user_latitude & longitude=user_longitude
		user = nil
		if(user = User.find_by(:id => params[:id], :pw => params[:pw]) && params[:orgs]!="")
			orgs = JSON.parse(params[:orgs])
			#location = Location.find_or_create_by(:user_id => user.id)
			#location.update(:latitude => params[:latitude], :longitude => params[:longitude])
			# 範囲指定でSemiwarningを取得
			semi_hit = Semiwarning.where("max_lat > #{params[:latitude]} and max_lon > #{params[:longitude]} and min_lat < #{params[:latitude]} and min_lon <  #{params[:longitude]}")
			result = Array.new
			if(!semi_hit.empty?)
				candidates = Warning.where(:id => semi_hit.map{|semi_warning| semi_warning.id}, :layer_id => Layer.where(:org_id => orgs.map{|org| org if (org != 1)}))
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

			if(orgs.include?(1))
				#semi_list = Semicontribution.where("max_lat > #{params[:latitude]} and max_lon > #{params[:longitude]} and min_lat < #{params[:latitude]} and min_lon <  #{params[:longitude]}").map{|semi| semi.id}
				semi_list = Semicontribution.all.map{|semi| semi.id}
				logger.debug "semilist#{semi_list}"
				cont_list = Contribution.where(:id => semi_list)
				cont_list.each { |cont|

					# Hubeny's formula
					logger.debug "#{cont.latitude} : #{cont.longitude}"
					logger.debug "#{params[:latitude]} : #{params[:longitude]}"

=begin
					dy = params[:latitude].to_f - cont.latitude
					dx = params[:longitude].to_f - cont.longitude
					e_2 = 0.00669437999
					nu_y = (params[:latitude].to_f + cont.latitude)/2
					w = (1-e_2*Math.sin(nu_y/180*Math::PI)**2)**0.5
					m = 6335439.32729246/(w**3)
					n = 6378137.0/w
=end

					dy = params[:latitude].to_f*Math::PI*180 - cont.latitude*Math::PI*180
					dx = params[:longitude].to_f*Math::PI*180 - cont.longitude*Math::PI*180
					e_2 = 0.00669437999
					nu_y = (params[:latitude].to_f*Math::PI*180 + cont.latitude*Math::PI*180)/2
					w = (1-e_2*Math.sin(nu_y/180*Math::PI)**2)**0.5
					m = 6335439.32729246/(w**3)
					n = 6378137.0/w

					logger.debug ((dy*m)**2+(dx*n*Math.cos(nu_y/180*Math::PI))**2)**0.5

					if( ((dy*m)**2+(dx*n*Math.cos(nu_y/180*Math::PI))**2)**0.5 < 500 ) 
						response << {:name => cont.title, :description => cont.description}
					end
						
				}
			end
			render :json => {:response => response}
		else
			render :json => {:result => 'failed'}
		end
	end

end
