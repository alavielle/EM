//%attributes = {}
//SauvegarderEtatCivil
//$1 : ID 

C_LONGINT:C283($1)
$id:=$1
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
	Case of 
		: ($values{$pos}="POST")
			var $entity : cs:C1710.EtatCivilEntity
			$entity:=ds:C1482.EtatCivil.new()
			$return:="L'ajout a été effectué"
			
		: ($values{$pos}="PUT")
			$ID:=Num:C11(JSON Parse:C1218($ReceivedObject.ID))
			$ordaEntity:=ds:C1482.EtatCivil
			$entities:=$ordaEntity.query("ID= :1"; $ID)
			$entity:=$entities[0]
			$return:="Les données ont été sauvegardées"
			
	End case 
	$entity.fromObject($ReceivedObject)
	$entity.save()
	SauvegarderStorageEtatCivil($entity.ID; $ReceivedObject.Nom; $ReceivedObject.NomNaissance; $ReceivedObject.DateNaissance; $ReceivedObject.CP; $ReceivedObject.Ville; $ReceivedObject.Tel; $ReceivedObject.Email)
End if 
$0:=$return