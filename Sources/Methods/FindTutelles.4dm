//%attributes = {}
//FindAyantDroits
// $1 : UUID

C_TEXT:C284($1)
C_TEXT:C284($Composant; $pluriel)
C_OBJECT:C1216($obj)
ARRAY OBJECT:C1221($tabObj; 0)
$Composant:=""
If ($1#"")
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	$tutelles:=$etatcivil.tutelles
	If ($tutelles.length>0)
		If ($tutelles.length>1)
			$pluriel:="s"
		End if 
		For each ($tutelle; $tutelles)
			$obj:=New object:C1471()
			ARRAY OBJECT:C1221($tabObjE; 0)
			$ec:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $tutelle.ID)[0]
			APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $tutelle.UUID; "NomPrenom"; $ec.Nom+" "+$ec.Prenom+" - "+$tutelle.Type))
		End for each 
		$composant:=HTML_ListGroup("Tutelle"+$pluriel; "Tutelle"+$pluriel; ->$tabObj)
	End if 
End if 
$0:=$composant