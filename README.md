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
		// {"response":{org_id:org_name}, {org_id:org_name}, {org_id:org_name}, ...}
	+ org/register(post) => name=org_name & pw=org_pw & description=org_description
		// {"org_id":org_id, "layer_id":layer_id}
* disaster
	+ disaster/getList(get) => none  
		// [[disaster_id, disaster_name, disaster_description],[disaster_id, disaster_name, disaster_description], ...]
* contribution
	+ contribution/postContribution(post) => id=user_id & pw=user_pw & latitude=user_latitude & longitude=user_longitude & title=title & description=description
		// ["result":"succeeded","id":contribution_id]
	+ contribution/enableContribution(post) => name=org_name & pw=org_name & id=contribution_id & risk_level=new_level
		//""
* layer
	+ layer/register(post) => name=org_name & pw=org_pw
		// ["result":true_or_false, "id":"registerd_layer_id"]
	+ layer/update(post) => name=hoge & pw=hoge & layer_id=hoge & warnings=[disaster_id,risk_level,{"lat:lon","lat:lon"},{"lat:lon"}],[disaster_id,risk_level,{"lat:lon"},{"lat:lon"},{"lat:lon"}],...]  
		// ["result":true_or_false, "layer_id":layer.id, "warnings":[id,layer_id,disaster_id,apexes,created_date,updated_date]]
	+ layer/getMap(get) =>	request=["risk_rank", "risk_rank",...]  
		// {"response":[[disaster_id,[{"latitude":longitude},{"latitude":longitude},{"latitude":longitude}, ...]] ...]}
*	location
	+ location/postLocation(post) => id=user_id & pw=user_pw & latitude=users_latitude & longitude=user_longitude & orgs=[org_id,org_id,...]  
		// {"response":[disaster_id, disaster_id, disaster_id, ...]}
	+ location/getLocation
 
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
