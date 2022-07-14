//%attributes = {}
//ImportRessource

C_OBJECT:C1216($etatcivil; $temp; $bourse)
$imports:=ds:C1482.ImportBourse.all()
For each ($import; $imports)
	
	$postulant:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.Codec_postulant)[0]
	$CodeFiscal:=$postulant.ID_CodeFiscal
	
	$totalRessource:=$import.toObject("Total_ressource")
	$ressource:=ds:C1482.Ressource.query("ID_CodeFiscal = :1"; $CodeFiscal)
	If ($ressource.length=0)
		$ressourceNew:=ds:C1482.Ressource.new()
		$ressourceNew.TT:=$totalRessource.Total_ressource
		$ressourceNew.Annee:="2021"
		$ressourceNew.ID_CodeFiscal:=$CodeFiscal
		$ressourceNew.save()
	End if 
End for each 
