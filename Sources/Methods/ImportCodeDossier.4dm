//%attributes = {}
//ImportCodeDossier

C_OBJECT:C1216($etatcivil)
$etatcivil:=ds:C1482.EtatCivil.all()
For each ($etat; $etatcivil)
	$import:=ds:C1482.ImportCodeDossier.query("CodeEC =:1"; $etat.CodeEC)
	If ($import.length>0)
		$etat.CodeDossier:=Uppercase:C13($import.CodeDossier[0])
		$etat.save()
	Else 
		
	End if 
End for each 