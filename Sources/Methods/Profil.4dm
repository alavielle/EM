//%attributes = {}
// Profil
// $1 : UUID

C_TEXT:C284($1)
C_BOOLEAN:C305($0)
$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)
	$0:=$user.profil.Profil
End if 