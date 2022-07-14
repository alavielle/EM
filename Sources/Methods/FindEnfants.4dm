//%attributes = {}
//FindEnfants
// $1 : UUID

C_TEXT:C284($1; $pluriel)
C_OBJECT:C1216($obj)
ARRAY OBJECT:C1221($tabObj; 0)
C_TEXT:C284($Composant)
$Composant:=""
If ($1#"")
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	$enfants:=$etatcivil.enfants
	If ($enfants.length>0)
		$enfantsDuRessortissant:=$enfants.query("ID_Ressortissant = :1 & Type = ENFANT"; $etatcivil.ID_Ressortissant)
		$autresEnfants:=$enfants.query("ID_Ressortissant # :1  & Type = ENFANT"; $etatcivil.ID_Ressortissant)
		If ($enfantsDuRessortissant.length>0)
			If ($enfantsDuRessortissant.length>1)
				$pluriel:="s"
			Else 
				$pluriel:=""
			End if 
			$obj:=New object:C1471()
			ARRAY OBJECT:C1221($tabObjE; 0)
			For each ($enfant; $enfantsDuRessortissant)
				$ece:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
				APPEND TO ARRAY:C911($tabObjE; New object:C1471("UUID"; $enfant.UUID; "NomPrenom"; $ece.Nom+" "+$ece.Prenom))
			End for each 
			OB SET:C1220($obj; "Libelle"; "Enfant"+$pluriel+" du ressortissant")
			OB SET ARRAY:C1227($obj; "Enfant"; $tabObjE)
			APPEND TO ARRAY:C911($tabObj; $obj)
		End if 
		If ($autresEnfants.length>0)
			If ($autresEnfants.length>1)
				$pluriel:="s"
			Else 
				$pluriel:=""
			End if 
			$obj:=New object:C1471()
			ARRAY OBJECT:C1221($tabObjE; 0)
			For each ($enfant; $autresEnfants)
				$ece:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
				APPEND TO ARRAY:C911($tabObjE; New object:C1471("UUID"; $enfant.UUID; "NomPrenom"; $ece.Nom+" "+$ece.Prenom))
			End for each 
			OB SET:C1220($obj; "Libelle"; "Autre"+$pluriel+" Enfant"+$pluriel)
			OB SET ARRAY:C1227($obj; "Enfant"; $tabObjE)
			APPEND TO ARRAY:C911($tabObj; $obj)
			$composant:=HTML_Accordion("Enfant"+$pluriel; "Libelle"; ->$tabObj)
		Else 
			$composant:=HTML_ListGroup("Enfant"+$pluriel; "Enfant"+$pluriel; ->$tabObjE)
		End if 
	End if 
End if 
$0:=$composant