//%attributes = {}
// CreerObjetEtatCivil
// $1 : entitySelection

C_OBJECT:C1216($1)
$etatcivil:=$1
$objEC:=$etatcivil.toObject()
OB REMOVE:C1226($objEC; "BlobCrypted")
If ($etatcivil#Null:C1517)
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID)[0]
	If ($SharedEC#Null:C1517)
		OB SET:C1220($objEC; "Nom"; $SharedEC.Nom)
		OB SET:C1220($objEC; "NomNaissance"; $SharedEC.NomNaissance)
		OB SET:C1220($objEC; "DateNaissance"; $SharedEC.DateNaissance)
		OB SET:C1220($objEC; "CP"; $SharedEC.CP)
		OB SET:C1220($objEC; "Ville"; $SharedEC.Ville)
		OB SET:C1220($objEC; "Tel"; $SharedEC.Tel)
		OB SET:C1220($objEC; "Email"; $SharedEC.Email)
	End if 
	If ($etatcivil.ID_Ressortissant>0)
		OB SET:C1220($objEC; "UUID_Ressortissant"; $etatcivil.ressortissant.UUID)
	End if 
	If ($etatcivil.ID_Conjoint>0)
		OB SET:C1220($objEC; "UUID_Conjoint"; $etatcivil.conjoint.UUID)
	End if 
	If ($etatcivil.ID_Tuteur>0)
		OB SET:C1220($objEC; "UUID_Tuteur"; $etatcivil.tuteur.UUID)
	End if 
	OB SET:C1220($objEC; "FoyerFiscal"; $etatcivil.foyerFiscal.CodeFiscal)
End if 
$mutuelles:=ds:C1482.Mutuelle.query("ID_EtatCivil = :1 "; $etatcivil.ID)
If ($mutuelles.length>0)
	C_COLLECTION:C1488($col)
	$col:=New collection:C1472()
	For each ($mutuelle; $mutuelles)
		$col.push($mutuelle.ID_Assurance)
	End for each 
	OB SET:C1220($ObjEC; "Assurances"; $col)
End if 
If ($etatCivil.Type="ENFANT")
	$scolarite:=ds:C1482.Scolarite.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $etatcivil.ID; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].ID)
	If ($scolarite.length>0)
		OB SET:C1220($ObjEC; "ID_NiveauEtude"; $scolarite[0].classe.niveau.ID)
		OB SET:C1220($ObjEC; "ID_Classe"; $scolarite[0].classe.ID)
		OB SET:C1220($ObjEC; "Filiere"; $scolarite[0].Filiere)
	Else 
		OB SET:C1220($objEC; "ID_Classe"; 0)
		OB SET:C1220($objEC; "ID_NiveauEtude"; 0)
	End if 
End if 
$0:=$objEC
