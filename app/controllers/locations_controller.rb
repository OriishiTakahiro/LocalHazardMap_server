require 'json'

class LocationsController < ApplicationController

	A = 6378137.000
	B = 6356752.314245

	def postLocation
		# params => id=user_id & pw=user_pw & latitude=user_latitude & longitude=user_longitude
		user = User.find_by(:id => params[:id], :pw => params[:pw])
		if(user && params[:orgs]!="")
			ranks = JSON.parse(params[:rank])
			location = Location.find_or_create_by(:user_id => user.id)
			location.update(:latitude => params[:latitude], :longitude => params[:longitude])
			# 範囲指定でSemiwarningを取得
			#semi_hit = Semiwarning.where("max_lat > #{params[:latitude]} and max_lon > #{params[:longitude]} and min_lat < #{params[:latitude]} and min_lon <  #{params[:longitude]}")
			semi_hit = Semiwarning.all
			result = Array.new
			logger.debug semi_hit.empty?

			if(!semi_hit.empty?)
				candidates = Warning.where(:id => semi_hit.map{|semi_warning| semi_warning.id}, :layer_id => Layer.where(:org_id => Organization.where(:rank => ranks).map{|org| org.id if (org != 1)}).map{|layer| layer.id}, :risk_level => params[:risk_level].to_i()..6)
				user_lat = params[:latitude].to_f
				user_lon = params[:longitude].to_f
				candidates.map{ |candidate|
					if(checkRegion(user_lat, user_lon, candidate))
						result << candidate
					end
				}
			end

			response = result.uniq.map{|warning| 
				disaster = Disaster.find_by(:id => warning.disaster_id)
				{:name => disaster.name, :description => disaster.description, :risk_level => warning.risk_level, :org => Organization.find_by(:id => Layer.find_by(:id => warning.layer_id).org_id).name}
			}

			if(ranks.include?(1))
				# semis = Semicontribution.where("max_lat > #{params[:latitude]} and max_lon > #{params[:longitude]} and min_lat < #{params[:latitude]} and min_lon <  #{params[:longitude]}").map{|semi| semi.id}
				semi_list = Semicontribution.all.map{|semi| semi.id}
				cont_list = Contribution.where(:id => semi_list, :risk_level => (params[:risk_level].to_i()..6))
				cont_list.each { |cont|

					# Hubeny's formula

					pow_e = 1 - B**2/A**2
					ave = ((params[:latitude].to_f + cont.latitude)*Math::PI/180)/2.0
					dy = (params[:latitude].to_f - cont.latitude)*Math::PI/180
					dx = (params[:longitude].to_f - cont.longitude)*Math::PI/180

					sin_ave = Math.sin(ave)
					cos_ave = Math.cos(ave)

					w = Math.sqrt(1-pow_e*sin_ave**2)
					m = A*(1-pow_e)/w**3
					n = A/w

					distance = Math.sqrt((m*dy)**2 + (n*cos_ave*dx)**2)

					logger.debug "#{dy} : #{dx}"
					logger.debug distance

					if( distance < 100.0 ) 
						response << {:name => cont.title, :description => cont.description, :risk_level => cont.risk_level, :img => cont.img.force_encoding("UTF-8"), :org => "ユーザ"}
					end
						
				}
			end
			logger.debug response
			render :json => {:response => response}
		else
			render :json => {:result => 'failed'}
		end
	end

end

# reference site http://markmail.org/message/wf7xkoxzkeyfoeo3
def checkRegion(uy, ux, candidate)

	apexes = JSON.parse(candidate.apexes, :quirks_mode => true)
	py = (apexes.map{|apexe| apexe.keys.first.to_f} << apexes.first.keys.first.to_f)
	px = (apexes.map{|apexe| apexe.values.first} << apexes.first.values.first)
	logger.debug "#{ux.class} : #{uy.class}"
	counter = 0

	0.upto(px.length-2) { |i|
		if((ux - px[i])*(ux - px[i+1]) < 0)
			m = (ux - px[i])*( (ux - px[i])*(py[i+1] - py[i]) - (uy - py[i])*(px[i+1] - px[i]) )
			counter += 1 if(m < 0)
		end
	}
	logger.debug counter
	counter.odd?
end

