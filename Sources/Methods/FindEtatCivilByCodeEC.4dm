//%attributes = {}
// FindEtatCivilByCodeEC
// $1 : CodeEC

C_TEXT:C284($Composant)
$Composant:=""
If ($1>0)
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC = :1"; $1).first()
	$composant:=JSON Stringify:C1217(CreerObjetEtatCivil($etatcivil))
End if 

$0:=$composant