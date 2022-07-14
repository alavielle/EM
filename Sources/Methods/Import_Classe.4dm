//%attributes = {}
//ImportClasse

C_OBJECT:C1216($etatcivil)
$imports:=ds:C1482.lmportClasse.all()
For each ($import; $imports)
	$etatcivil:=ds:C1482.EtatCivil.query("CodeEC =:1"; $import.CodeEnfant)[0]
	$classe:=ds:C1482.Classe.query("Classe =:1"; $import.Classe)
	If ($classe.length>0)
		$entity:=ds:C1482.Scolarite.new()
		$entity.ID_AnneeSco:=1
		$entity.ID_EtatCivil:=$etatcivil.ID
		$entity.ID_Classe:=$classe[0].ID
		$entity.Filiere:=$import.Filiere
		$entity.save()
	End if 
	
End for each 