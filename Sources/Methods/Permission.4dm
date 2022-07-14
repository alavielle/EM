//%attributes = {}
//Permission
// $1 : UUID
// $2 : zone

C_TEXT:C284($0; $1)

$0:=""
$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)
	QUERY:C277([Privilege:4]; [Privilege:4]ID:1=$user.ID_Privilege)
	If (Records in selection:C76([Privilege:4])=1)
		$0:=$2->
	End if 
End if 