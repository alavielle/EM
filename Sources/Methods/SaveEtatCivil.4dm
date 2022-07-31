//%attributes = {}
//SaveEtatCivil
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
			var $entity : cs:C1710.EtatCivilEntity
			$entity:=ds:C1482.EtatCivil.new()
			$return:="L'ajout a été effectué"
			If ($ReceivedObject.ID_Ressortissant=Null:C1517)
				If (($ReceivedObject.Type="CONJOINT") | ($ReceivedObject.Type="ENFANT"))
					$erreur:=True:C214
					$return:="Erreur : Merci de sélectionner un ressortissant"
				End if 
			End if 
			If (($ReceivedObject.ID_Conjoint=Null:C1517) & ($erreur=False:C215))
				If (($ReceivedObject.Type="AUTRE") | ($ReceivedObject.Type="ENFANT"))
					$erreur:=True:C214
					$return:="Erreur : Merci de sélectionner un conjoint"
				End if 
			End if 
			
		: ($values{$pos}="PUT")
			$ID:=Num:C11(JSON Parse:C1218($ReceivedObject.ID))
			$ordaEntity:=ds:C1482.EtatCivil
			$entities:=$ordaEntity.query("ID= :1"; $ID)
			$entity:=$entities[0]
			$return:="Les données ont été sauvegardées"
			
	End case 
	
	If ($erreur=False:C215)
		$entity.fromObject($ReceivedObject)
		
		If ($entity.Type="RESSORTISSANT")
			If ($entity.ID_CodeFiscal=0)
				$entity.ID_CodeFiscal:=NewCodeFiscal($entity.CodeDossier; $entity.Decede)
			End if 
		Else 
			If (($entity.CodeDossier=Null:C1517) & ($entity.Type#"AUTRE") & ($entity.Type#"TUTEUR"))
				$entity.CodeDossier:=$entity.ressortissant.CodeDossier
			End if 
			If ($entity.ID_CodeFiscal=0)
				If (($entity.Type#"AUTRE") & ($entity.Type#"TUTEUR"))
					If ((($entity.ressortissant.Decede=True:C214) & ($entity.Type="CONJOINT")) | ($entity.Divorce=True:C214) | ($entity.IndependantFiscal=True:C214))
						$entity.ID_CodeFiscal:=NewCodeFiscal($entity.ressortissant.CodeDossier; False:C215)
					End if 
				Else 
					If ($entity.Type="CONJOINT")
						$entity.ID_CodeFiscal:=$entity.ressortissant.ID_CodeFiscal
					End if 
					If (($entity.Type="ENFANT") | ($entity.Type="AUTRE"))
						$entity.ID_CodeFiscal:=$entity.conjoint.ID_CodeFiscal
						If (($entity.CodeDossier=Null:C1517) & ($entity.Type="AUTRE"))
							$entity.CodeDossier:=$entity.conjoint.CodeDossier
						End if 
					End if 
				End if 
			End if 
		End if 
		If ($entity.ID_Tuteur>0)
			$etatCivilTuteur:=ds:C1482.EtatCivil.query("ID = :1"; $entity.ID_Tuteur)[0]
			$etatCivilTuteur.CodeDossier:=$entity.CodeDossier
			$etatCivilTuteur.ID_CodeFiscal:=$entity.ID_CodeFiscal
			$etatCivilTuteur.save()
		End if 
		For each ($e; $entity)
			If (Position:C15("Date"; $e)>0)
				$entity[$e]:=Date:C102($ReceivedObject[$e])
			End if 
		End for each 
		$entity.save()
		SaveStorageEtatCivil($entity.ID; $ReceivedObject.Nom; $ReceivedObject.NomNaissance; $ReceivedObject.DateNaissance; $ReceivedObject.CP; $ReceivedObject.Ville; $ReceivedObject.Tel; $ReceivedObject.Email; $ReceivedObject.Prenom; $entity.CodeDossier; $ReceivedObject.Type)
		SaveAssurance($entity.ID; $ReceivedObject.ID_Assurance)
		SaveScolarite($entity.ID; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].ID; Num:C11($ReceivedObject.ID_Classe); $ReceivedObject.Filiere)
	End if 
	$0:=$return
End if 