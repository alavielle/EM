//%attributes = {}
// CRUD 
// $1 : index (ID)
// $2 : table pointeur
// $3 : entity 
// $4 : optionnel - objet des champs de la table à afficher si sélection

C_OBJECT:C1216($3)
ARRAY TEXT:C222($names; 0)
ARRAY TEXT:C222($values; 0)
C_TEXT:C284($Retour)
$Retour:="OK"

WEB GET HTTP HEADER:C697($names; $values)
$pos:=Find in array:C230($names; "X-METHOD")

$Index:=$1
$TablePtr:=$2
$ordaEntity:=$3

If ($pos>0)
	Case of 
		: ($values{$pos}="GET")
			If (Length:C16($Index)>0)
				$entities:=$ordaEntity.query("ID= :1"; $Index)
				$entity:=$entities[0]
				$Retour:=JSON Stringify:C1217($entity.toObject())
			Else 
				ALL RECORDS:C47($TablePtr->)
				If (Count parameters:C259=3)
					$Retour:=Selection to JSON:C1234($TablePtr->)
				Else 
					$Retour:=Selection to JSON:C1234($TablePtr->; $4)
				End if 
			End if 
			
		: ($values{$pos}="DELETE")
			If (Length:C16($Index)>0)
				$entities:=$ordaEntity.query("ID= :1"; $Index)
				$entity:=$entities[0]
				$statut:=$entity.drop(dk force drop if stamp changed:K85:17)
			End if 
			
		: ($values{$pos}="PUT")
			C_TEXT:C284($Receivedtexte)
			WEB GET HTTP BODY:C814($Receivedtexte)
			C_OBJECT:C1216($ReceivedObject)
			$ReceivedObject:=JSON Parse:C1218($Receivedtexte)
			$ID:=Num:C11(JSON Parse:C1218($ReceivedObject.ID))
			$entities:=$ordaEntity.query("ID= :1"; $ID)
			$entity:=$entities[0]
			$entity.fromObject($ReceivedObject)
			$entity.save()
			
		: ($values{$pos}="POST")
			C_TEXT:C284($Receivedtexte)
			WEB GET HTTP BODY:C814($Receivedtexte)
			C_OBJECT:C1216($ReceivedObject)
			$ReceivedObject:=JSON Parse:C1218($Receivedtexte)
			C_OBJECT:C1216($entity)
			$entity:=$ordaEntity.new()
			$entity.fromObject($ReceivedObject)
			$entity.save()
	End case 
End if 

$0:=$Retour