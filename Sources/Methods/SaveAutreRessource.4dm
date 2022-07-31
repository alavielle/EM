//%attributes = {}
// SaveAutreRessource
// $1 : ID_Ressource
// $2 : Collection ID_Ligne Valeur

C_LONGINT:C283($1)
C_COLLECTION:C1488($colAutre; $colLigne)
$colLigne:=New collection:C1472
$colAutre:=New collection:C1472
$colAutre:=$2

$colActuelle:=ds:C1482.AutreRessource.query("ID_Ressource = :1"; $1).extract("ID_Ligne")
For each ($col; $colAutre)
	OB GET PROPERTY NAMES:C1232($col; $tabProp)
	$prop:=$tabProp{1}
	$ligne:=Num:C11($prop)
	$colLigne.push($ligne)
	$valeur:=OB Get:C1224($col; $prop)
	$Autres:=ds:C1482.AutreRessource.query("ID_Ressource = :1 & ID_Ligne = :2"; $1; $ligne)
	If ($Autres.length=0)
		$newAutre:=ds:C1482.AutreRessource.new()
		$newAutre.ID_Ressource:=$1
		$newAutre.ID_Ligne:=$ligne
		$newAutre.Valeur:=$valeur
		$newAutre.save()
	Else 
		$a:=$Autres[0]
		$a.ID_Ligne:=$ligne
		$a.Valeur:=$valeur
		$a.save()
	End if 
End for each 

For each ($c; $colActuelle)
	If ($colLigne.indexOf($c)<0)
		ds:C1482.AutreRessource.query("ID_Ressource = :1 & ID_Ligne = :2"; $1; $c).drop()
	End if 
End for each 

