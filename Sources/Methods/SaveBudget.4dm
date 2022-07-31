//%attributes = {}
// SaveBudget
// $1 : ID_EtatCivil
// $2 : ID_AnneeSco
// $3 : Collection ID_Ligne Montant

C_LONGINT:C283($1; $2)
C_COLLECTION:C1488($colBudget; $colLigne)
$colLigne:=New collection:C1472
$colBudget:=New collection:C1472
$colBudget:=$3

$colActuelle:=ds:C1482.Budget.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $1; $2).extract("ID_Ligne")
For each ($col; $colBudget)
	OB GET PROPERTY NAMES:C1232($col; $tabProp)
	$prop:=$tabProp{1}
	$ligne:=Num:C11($prop)
	$colLigne.push($ligne)
	$montant:=OB Get:C1224($col; $prop)
	$Budget:=ds:C1482.Budget.query("ID_EtatCivil = :1 & ID_AnneeSco = :2 & ID_Ligne = :3"; $1; $2; $ligne)
	If ($Budget.length=0)
		$newBudget:=ds:C1482.Budget.new()
		$newBudget.ID_EtatCivil:=$1
		$newBudget.ID_AnneeSco:=$2
		$newBudget.ID_Ligne:=ds:C1482.LigneBudget.query("NumeroLigne = :1"; $ligne)[0].ID
		$newBudget.Montant:=$montant
		$newBudget.save()
	Else 
		$b:=$Budget[0]
		$b.ID_Ligne:=ds:C1482.LigneBudget.query("NumeroLigne = :1"; $ligne)[0].ID
		$b.Montant:=$montant
		$b.save()
	End if 
End for each 

For each ($c; $colActuelle)
	If ($colLigne.indexOf($c)<0)
		ds:C1482.Budget.query("ID_EtatCivil = :1 & ID_AnneeSco = :2 & ID_Ligne = :3"; $1; $2; $c).drop()
	End if 
End for each 

