//%attributes = {}
//MAJ_CodeFiscal_Ressortissant
// Création du code fiscal 

var $foyer : cs:C1710.FoyerFiscalEntity

$etatcivil1:=ds:C1482.EtatCivil.query("Decede = :1 & Type = :2 & ID_CodeFiscal = 0"; True:C214; "RESSORTISSANT")
For each ($etat; $etatcivil1)
	$foyer:=ds:C1482.FoyerFiscal.new()
	$foyer.CodeFiscal:=$etat.CodeDossier+"-0"
	$foyer.save()
	$etat.ID_CodeFiscal:=$foyer.ID
	$etat.save()
End for each 

$etatcivil1b:=ds:C1482.EtatCivil.query("Decede = :1 & Type = :2 "; True:C214; "CONJOINT")
For each ($etat; $etatcivil1b)
	$foyer:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $etat.CodeDossier+"-0")
	If ($foyer.length=0)
		$newfoyer:=ds:C1482.FoyerFiscal.new()
		$newfoyer.CodeFiscal:=$etat.CodeDossier+"-0"
		$newfoyer.save()
		$id:=$newfoyer.ID
	Else 
		$id:=$foyer[0].ID
	End if 
	$etat.ID_CodeFiscal:=$id
	$etat.save()
End for each 

$etatcivil2:=ds:C1482.EtatCivil.query("Decede = :1 & Type = :2 & ID_CodeFiscal = 0"; False:C215; "RESSORTISSANT")
For each ($etat; $etatcivil2)
	$foyer:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $etat.CodeDossier+"-1")
	If ($foyer.length=0)
		$newfoyer:=ds:C1482.FoyerFiscal.new()
		$newfoyer.CodeFiscal:=$etat.CodeDossier+"-1"
		$newfoyer.save()
		$id:=$newfoyer.ID
	Else 
		$id:=$foyer[0].ID
	End if 
	$etat.ID_CodeFiscal:=$id
	$etat.save()
End for each 



$etatcivil3:=ds:C1482.EtatCivil.query("Divorce = :1 & Type = :2 & ID_CodeFiscal = 0"; False:C215; "CONJOINT")
For each ($etat; $etatcivil3)
	$foyer:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $etat.CodeDossier+"-1")
	If ($foyer.length=0)
		$newfoyer:=ds:C1482.FoyerFiscal.new()
		$newfoyer.CodeFiscal:=$etat.CodeDossier+"-1"
		$newfoyer.save()
		$id:=$newfoyer.ID
	Else 
		$id:=$foyer[0].ID
	End if 
	$etat.ID_CodeFiscal:=$id
	$etat.save()
End for each 

//$etatcivil4:=ds.EtatCivil.query("IndependantFiscal = :1 | Divorce = :2 "; Vrai; Vrai)
//Pour chaque ($etat; $etatcivil4)
//$etat.ID_CodeFiscal:=AttribuerCodeFiscal($etat.CodeDossier)
//$etat.save()
//Fin de chaque 


//$etatcivil5:=ds.EtatCivil.query("Type = :1 & IndependantFiscal = :2"; "ENFANT"; Faux)
//Pour chaque ($etat; $etatcivil5)
//$etat.ID_CodeFiscal:=$etat.conjoint.foyerFiscal.ID
//$etat.save()
//Fin de chaque 

$etatcivil6:=ds:C1482.EtatCivil.query("Type = :1 & IndependantFiscal = :2 & ID_CodeFiscal = 0"; "ENFANT"; False:C215)
For each ($etat; $etatcivil6)
	$etat.ID_CodeFiscal:=$etat.conjoint.foyerFiscal.ID
	$etat.save()
End for each 