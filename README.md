#LocalHazardMap_server

---
##APIへのリクエストパラメータ形式
---
path(HTTP_method) => request  
// response
* user
	+ user/entry(post) => name=user_name & pw=user_pw  
		// {"result":false}
* organization
	+ org/getList(get) => none  
		// [{org_id:org_name}, {org_id:org_name}, {org_id:org_name}, ...]
* disaster
	+ disaster/getList(get) => none  
		// [[disaster_id, disaster_name, disaster_description],[disaster_id, disaster_name, disaster_description], ...]
* layer
	+ layer/register(post) => name=org_name & pw=org_pw & max_lat=max_lat & max_lon=max_lon & min_lat=min_lat & min_lon=min_lon  
		// ["result":true_or_false, "id":"registerd_layer_id"]
	+ layer/update(post) => name=hoge & pw=hoge & layer_id=hoge & warnings=["disaster_id",{"lat:lon","lat:lon"},{"lat:lon"}],["disaster_id",{"lat:lon"},{"lat:lon"},{"lat:lon"}],...]  
		// ["result":true_or_false, :layer_id => layer.id, :warnings => Warning.where(:layer_id => layer.id).to_a]
	+ layer/getMap(get) =>	request=["org_id", "org_id",...]  
		// [[disaster_id,[{"latitude":longitude},{"latitude":longitude},{"latitude":longitude}, ...]] ...]
*	location
	+ location/postLocation => id=user_id & pw=user_pw & latitude=users_latitude & longitude=user_longitude  
		// [disaster_id, disaster_id, disaster_id, ...]
 
---
##データベースはMySQLを使用しています。
---
* database	: LlocalHazardMap_development
* user			: procon
* pw		 		: pass

---
##注意
---
proconユーザには各データベースへの接続権限を与えてください.
* 追加するDB名( "grant all privileges on データベース名.\* to ユーザ名@localhost;" でユーザに権限が追加可能 )
	+ LocalHazardMap_development
	+ LocalHazardMap_test
  権限の確認は"show grants for ユーザ名;"で可能.

---
##MySQLの導入
---
