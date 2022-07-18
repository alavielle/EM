//%attributes = {}
//ImportFiliation

C_OBJECT:C1216($etatcivil)
$imports:=ds:C1482.importRessortissant.all()
For each ($import; $imports)
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeEC)[0]
	$etatcivil.DateFinService:=$import.FinService
	$etatcivil.Statut:=$import.Statut
	$etatcivil.Situation:=$import.Situation
	$etatcivil.ImputableService:=$import.ImputableService
	$etatcivil.save()
End for each 
