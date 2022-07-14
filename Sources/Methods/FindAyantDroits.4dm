//%attributes = {}
//FindAyantDroits
// $1 : UUID

C_TEXT:C284($1)
C_TEXT:C284($Composant)
C_OBJECT:C1216($obj)
ARRAY OBJECT:C1221($tabObj; 0)
$Composant:=""
If ($1#"")
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	$ayantDroits:=$etatcivil.ayantDroits
	$conjoints:=$ayantDroits.query("Type = CONJOINT")
	If ($conjoints.length>0)
		For each ($conjoint; $conjoints)
			$obj:=New object:C1471()
			ARRAY OBJECT:C1221($tabObjE; 0)
			$ecc:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $conjoint.ID)[0]
			$enfants:=$ayantDroits.query("ID_Conjoint = :1"; $conjoint.ID)
			For each ($enfant; $enfants)
				$ece:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
				APPEND TO ARRAY:C911($tabObjE; New object:C1471("UUID"; $enfant.UUID; "NomPrenom"; $ece.Nom+" "+$ece.Prenom))
			End for each 
			OB SET:C1220($obj; "UUID"; $conjoint.UUID; "NomPrenom"; $ecc.Nom+" "+$ecc.Prenom)
			OB SET ARRAY:C1227($obj; "Enfant"; $tabObjE)
			APPEND TO ARRAY:C911($tabObj; $obj)
		End for each 
		$composant:=HTML_Accordion("Ayant-Droits"; ""; ->$tabObj)
	Else 
		$enfants:=$ayantDroits.query("Type = ENFANT")
		For each ($enfant; $enfants)
			$ece:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
			APPEND TO ARRAY:C911($tabObjE; New object:C1471("UUID"; $enfant.UUID; "NomPrenom"; $ece.Nom+" "+$ece.Prenom))
		End for each 
		$autres:=$ayantDroits.query("Type = AUTRE")
		For each ($autre; $autres)
			$ece:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $autre.ID)[0]
			APPEND TO ARRAY:C911($tabObjE; New object:C1471("UUID"; $autre.UUID; "NomPrenom"; $ece.Nom+" "+$ece.Prenom))
		End for each 
	End if 
	
End if 
$0:=$composant