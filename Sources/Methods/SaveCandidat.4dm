//%attributes = {}
//SaveCandidat
//$1 : ID 

C_LONGINT:C283($1)
C_BOOLEAN:C305($erreur)
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
			
			
		: ($values{$pos}="PUT")
			$ID:=Num:C11(JSON Parse:C1218($ReceivedObject.ID))
			$ordaEntity:=ds:C1482.EtatCivil
			$entities:=$ordaEntity.query("ID= :1"; $ID)
			$entity:=$entities[0]
			
	End case 
	
	If ($erreur=False:C215)
		$entity.fromObject($ReceivedObject)
		
		For each ($e; $entity)
			If (Position:C15("Date"; $e)>0)
				$entity[$e]:=Date:C102($ReceivedObject[$e])
			End if 
		End for each 
		$entity.save()
		SaveStorageEtatCivil($ID; $ReceivedObject.Nom; $ReceivedObject.NomNaissance; $ReceivedObject.DateNaissance; $ReceivedObject.CP; $ReceivedObject.Ville; $ReceivedObject.Tel; $ReceivedObject.Email; $ReceivedObject.Prenom; $entity.CodeDossier; $ReceivedObject.Type)
		SaveAssurance($ID; $ReceivedObject.ID_Assurance)
		$ID_AnneeSco:=ds:C1482.AnneeScolaire.query("AnneeSco = :1"; $ReceivedObject.AnneeSco)[0].ID
		SaveScolarite($ID; $ID_AnneeSco; Num:C11($ReceivedObject.ID_Classe); $ReceivedObject.Filiere)
		
		C_COLLECTION:C1488($colFrais)
		$colFrais:=New collection:C1472
		$nbLignes:=ds:C1482.LigneFrais.all().length
		For ($i; 1; $nbLignes)
			If ($ReceivedObject["Frais"+String:C10($i; "00")]#"")
				$colFrais.push(New object:C1471("Frais"+String:C10($i; "00"); $ReceivedObject["Frais"+String:C10($i; "00")]))
			End if 
		End for 
		SaveFrais($id; $ID_AnneeSco; $colFrais)
		
		C_COLLECTION:C1488($colBudget)
		$colBudget:=New collection:C1472
		$nbLignes:=ds:C1482.LigneBudget.all().length
		For ($i; 1; $nbLignes)
			If ($ReceivedObject["Budget"+String:C10($i; "00")]#"")
				$colBudget.push(New object:C1471("Budget"+String:C10($i; "00"); $ReceivedObject["Budget"+String:C10($i; "00")]))
			End if 
		End for 
		SaveBudget($id; $ID_AnneeSco; $colBudget)
	End if 
	$0:=$return
End if 