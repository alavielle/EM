//%attributes = {}
// NewCodeDossier

$prefixe:=ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].PrefixeCodeDossier
$usedCodes:=ds:C1482.EtatCivil.query("CodeDossier = :1"; $prefixe+"@")
If ($usedCodes.length=0)
	$nvCode:=Num:C11($prefixe)+1
Else 
	$formula:=Formula:C1597(Num:C11(This:C1470.CodeDossier))
	$last:=Num:C11($usedCodes.orderByFormula($formula).last().CodeDossier)
	$nvCode:=$prefixe+String:C10($last+1)
End if 

$0:=$nvCode