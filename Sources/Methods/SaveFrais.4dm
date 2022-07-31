//%attributes = {}
// SaveFrais
// $1 : ID_EtatCivil
// $2 : ID_AnneeSco
// $3 : Collection ID_Ligne Montant

C_LONGINT:C283($1; $2)
C_COLLECTION:C1488($colFrais; $colLigne)
$colLigne:=New collection:C1472
$colFrais:=New collection:C1472
$colFrais:=$3

$colActuelle:=ds:C1482.Frais.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $1; $2).extract("ID_Ligne")
For each ($col; $colFrais)
	OB GET PROPERTY NAMES:C1232($col; $tabProp)
	$prop:=$tabProp{1}
	$ligne:=Num:C11($prop)
	$colLigne.push($ligne)
	$montant:=OB Get:C1224($col; $prop)
	$Frais:=ds:C1482.Frais.query("ID_EtatCivil = :1 & ID_AnneeSco = :2 & ID_Ligne = :3"; $1; $2; $ligne)
	If ($Frais.length=0)
		$newFrais:=ds:C1482.Frais.new()
		$newFrais.ID_EtatCivil:=$1
		$newFrais.ID_AnneeSco:=$2
		$newFrais.ID_Ligne:=ds:C1482.LigneFrais.query("NumeroLigne = :1"; $ligne)[0].ID
		$newFrais.Montant:=$montant
		$newFrais.save()
	Else 
		$f:=$Frais[0]
		$f.ID_Ligne:=ds:C1482.LigneFrais.query("NumeroLigne = :1"; $ligne)[0].ID
		$f.Montant:=$montant
		$f.save()
	End if 
End for each 

For each ($c; $colActuelle)
	If ($colLigne.indexOf($c)<0)
		ds:C1482.Frais.query("ID_EtatCivil = :1 & ID_AnneeSco = :2 & ID_Ligne = :3"; $1; $2; $c).drop()
	End if 
End for each 

