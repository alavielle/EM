//%attributes = {}
//ImportBourse

C_OBJECT:C1216($etatcivil; $temp; $bourse)
$imports:=ds:C1482.ImportBourse.all()
For each ($import; $imports)
	$temp:=$import.toObject()
	$bourse:=ds:C1482.Bourse.new()
	$bourse.fromObject($temp)
	
	$postulant:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.Codec_postulant)[0]
	$representant:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.Codec_representant)[0]
	
	$bourse.ID_Boursier:=$postulant.ID
	$bourse.ID_Versement:=$representant.ID
	$bourse.TypeAide:="BOURSE"
	If ($import.Demande="Renouvellement")
		$bourse.Renouvellement:=True:C214
	End if 
	
	$bourse.save()
	
End for each 
