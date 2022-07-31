//%attributes = {}
//SaveRessource
//$1 : UUID boursier


C_LONGINT:C283($1)
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
	$ID_CodeFiscal:=JSON Parse:C1218($ReceivedObject.ID_CodeFiscal)
	$Annee:=JSON Parse:C1218($ReceivedObject.Annee)
	Case of 
		: ($values{$pos}="POST")
			$ressources:=ds:C1482.Ressource.query("ID_CodeFiscal = :1 & Annee = :2"; $ID_CodeFiscal; $Annee)
			If ($ressources.length=0)
				$ressource:=ds:C1482.Ressource.new()
			Else 
				$ressource:=$ressources[0]
			End if 
			$ressource.fromObject($ReceivedObject)
			$ressource.save()
			$return:="OK"
			
			C_COLLECTION:C1488($colAutre)
			$colAutre:=New collection:C1472
			$nbLignes:=ds:C1482.AutreLigneRessource.query("ID_Ligne >0").length
			For ($i; 1; $nbLignes)
				If ($ReceivedObject["Autre"+String:C10($i; "00")]#"")
					$colAutre.push(New object:C1471("Autre"+String:C10($i; "00"); $ReceivedObject["Autre"+String:C10($i; "00")]))
				End if 
			End for 
			SaveAutreRessource($ressource.ID; $colAutre)
			
		: ($values{$pos}="PUT")
	End case 
	$0:=$return
End if 