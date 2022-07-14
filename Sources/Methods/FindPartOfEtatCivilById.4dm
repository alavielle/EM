//%attributes = {}
// FindPartOfEtatCivilById
// $1 : Id

C_TEXT:C284($1)
C_OBJECT:C1216($objEC)
C_TEXT:C284($Composant)
$Composant:=""
If ($1#"")
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $1)
	If ($SharedEC.length>0)
		OB SET:C1220($objEC; "Nom"; $SharedEC[0].Nom)
		OB SET:C1220($objEC; "Prenom"; $SharedEC[0].Prenom)
		OB SET:C1220($objEC; "Email"; $SharedEC[0].Email)
		OB SET:C1220($objEC; "Type"; $SharedEC[0].Type)
	End if 
	$Composant:=JSON Stringify:C1217($objEC)
End if 
$0:=$composant