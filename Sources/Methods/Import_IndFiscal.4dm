//%attributes = {}
//ImportFiliation

C_OBJECT:C1216($etatcivil)
$imports:=ds:C1482.ImportBourse.all()
For each ($import; $imports)
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.Codec_postulant)[0]
	$etatcivil.IndependantFiscal:=$import.Independant_fiscal
	$etatcivil.SuperIsole:=$import.SuperIsole
	$etatcivil.save()
End for each 
