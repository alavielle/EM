//%attributes = {}
//SaveDocument
//$1 : UUID boursier


C_TEXT:C284($1)
$uuid:=$1
C_TEXT:C284($return)
ARRAY TEXT:C222($names; 0)
ARRAY TEXT:C222($values; 0)
WEB GET HTTP HEADER:C697($names; $values)
$pos:=Find in array:C230($names; "X-METHOD")

If ($pos>0)
	C_TEXT:C284($Receivedtexte)
	WEB GET HTTP BODY:C814($Receivedtexte)
	C_OBJECT:C1216($ReceivedObject)
	$ReceivedObject:=JSON Parse:C1218($Receivedtexte)[0]
	$etatCivil:=ds:C1482.EtatCivil.query("UUID =:1"; $uuid)
	If ($etatCivil.length>0)
		$ID_EtatCivil:=$etatCivil[0].ID
		
		Case of 
			: ($values{$pos}="POST")
				$documents:=ds:C1482.Justificatif.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $ID_EtatCivil; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].ID)
				If ($documents.length=0)
					$document:=ds:C1482.Justificatif.new()
				Else 
					$document:=$documents[0]
				End if 
				$document.fromObject($ReceivedObject)
				$document.save()
				
				$user:=ds:C1482.WebUser.query("UUID = :1"; Session:C1714.storage.clientUuid.value).first()
				If ($user#Null:C1517)
					If ($user.ID_Privilege>3)
						$return:="Signature"
					Else 
						$return:="validation"
					End if 
				End if 
		End case 
	End if 
	$0:=$return
End if 