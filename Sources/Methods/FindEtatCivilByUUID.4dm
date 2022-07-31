//%attributes = {}
// FindEtatCivilByUUID
// $1 : UUID

C_TEXT:C284($1)
C_TEXT:C284($Composant)
C_OBJECT:C1216($template; $objEC)

$Composant:=""
If ($1#"")
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	$objEC:=CreerObjetEtatCivil($etatcivil)
End if 
$0:=$objEC