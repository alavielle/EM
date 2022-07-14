//%attributes = {}
//FindBourse
//$1 : ID 

C_LONGINT:C283($1)
ARRAY TEXT:C222($names; 0)
ARRAY TEXT:C222($values; 0)
C_TEXT:C284($Retour)
$Retour:="OK"

WEB GET HTTP HEADER:C697($names; $values)
$pos:=Find in array:C230($names; "X-METHOD")

$id:=$1
If ($pos>0)
	If ($id>0)
		$entity:=ds:C1482.Bourse.query("ID= :1"; $id).first()
		Case of 
			: ($values{$pos}="DELETE")
				$statut:=$entity.drop(dk force drop if stamp changed:K85:17)
				ReturnSomething($Retour)
				
			: ($values{$pos}="GET")
				If ($entity#Null:C1517)
					DepotDossier($entity.boursier.UUID; $id)
				End if 
		End case 
	End if 
	
End if 
