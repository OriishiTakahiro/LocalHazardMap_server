##データベースはMySQLを使用しています。
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
