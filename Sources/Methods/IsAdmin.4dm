//%attributes = {}
// IsAdmin
// $1 : UserUUID

C_TEXT:C284($1)
C_BOOLEAN:C305($0)
$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)
	If ($user.ID_Privilege<3)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 