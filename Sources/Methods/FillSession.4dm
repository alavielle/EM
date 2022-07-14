//%attributes = {}
// FillSession
// $1 : $user

C_OBJECT:C1216($1)
var $info : Object

$user:=$1
$info:=New object:C1471()
$info.userName:=$user.Prenom+" "+$user.Nom
Session:C1714.setPrivileges($info)
//You can use the user session to store any information
Decryptage($user)
Use (Session:C1714.storage)
	Session:C1714.storage.clientUuid:=New shared object:C1526("value"; $user.UUID)
End use 

$userCookie:="Set-Cookie: 4DUUID="+$user.UUID+"; PATH=/"
WEB SET HTTP HEADER:C660($userCookie)