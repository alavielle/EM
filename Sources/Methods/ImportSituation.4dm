//%attributes = {}
//ImportSituation

C_OBJECT:C1216($etatcivil; $etatcivil_R; $etatcivil_C)
$imports:=ds:C1482.ImportEtatCivil.query("Type # :1"; "RESSORTISSANT")
For each ($import; $imports)
	
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeEC)[0]
	If ($import.Type="CONJOINT")
		$etatcivil.Situation:=$import.SituConjoint
		$etatcivil.Statut:=$import.StatutConjoint
	Else 
		$etatcivil.Handicap:=$import.Infirmite
		$etatcivil.Statut:=$import.StatutEnfant
	End if 
	
	$etatcivil.save()
End for each 