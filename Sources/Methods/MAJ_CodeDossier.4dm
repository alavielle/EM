//%attributes = {}
// MAJ_CodeDossier

$etatCivil:=ds:C1482.EtatCivil.query("Type = :1"; "TUTEUR")
For each ($etat; $etatCivil)
	$tutelles:=$etat.tutelles.first()
	$etat.CodeDossier:=$tutelles.CodeDossier
	$etat.ID_CodeFiscal:=$tutelles.ID_CodeFiscal
	$etat.save()
	
End for each 