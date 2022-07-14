//%attributes = {}
//ImportFiliation

C_OBJECT:C1216($etatcivil; $etatcivil_R; $etatcivil_C)
$imports:=ds:C1482.ImportEtatCivil.query("Type # :1"; "RESSORTISSANT")
For each ($import; $imports)
	If ($import.RessortissantConjoint>0)
		$etatcivil_R:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.RessortissantConjoint)[0]
	Else 
		$etatcivil_R:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeRessortissant)[0]
	End if 
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeEC)[0]
	$etatcivil.ID_Ressortissant:=$etatcivil_R.ID
	If ($import.CodeConjoint>0)
		$etatcivil_C:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeConjoint)
		If ($etatcivil_C.length>0)
			$etatcivil.ID_Conjoint:=$etatcivil_C[0].ID
		End if 
	End if 
	$etatcivil.save()
End for each 
