#LocalHazardMap_server

---
##APIへのリクエストパラメータ形式
---
*user
	+ user/entry => {"name"="user_name", "pw"="user_pw"}
* layer
	+ layer/register => {"name"="org_name", "pw"="org_pw", "max_lat"="max_lat", "max_lon"="max_lon", "min_lat"="min_lat", "min_lon"="min_lon"}
	+ layer/update => {"name"="org_name", "pw"="org_pw", "layer_id"="layer_id", "warnings"="{["disaster_id",{"lat:lon","lat:lon"},{"lat:lon"}],["disaster_id",{"lat:lon"},{"lat:lon"},{"lat:lon"}]...}

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
