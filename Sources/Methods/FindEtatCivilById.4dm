//%attributes = {}
// FindEtatCivilById
// $1 : Id

C_TEXT:C284($Composant)
C_OBJECT:C1216($objEC)
$Composant:=""
If ($1>0)
	$etatcivil:=ds:C1482.EtatCivil.query("ID = :1"; $1).first()
	$composant:=JSON Stringify:C1217(CreerObjetEtatCivil($etatcivil))
End if 
$0:=$composant