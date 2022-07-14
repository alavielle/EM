//%attributes = {}
//AttribuerCodeDossier

C_TEXT:C284($0)
$Prefixe:=ds:C1482.AnneeScolaire.query("EnCours = :1"; True:C214).PrefixeCodeDossier[0]

$etatCivil:=ds:C1482.EtatCivil.query("CodeDossier = :1"; $Prefixe+"@").distinct("CodeDossier")

If ($etatCivil.length>0)
	$last:=$etatCivil[$etatCivil.length-1]
	$increment:=Num:C11($last)+1
Else 
	$increment:=1
End if 

$0:=$prefixe+String:C10($increment)