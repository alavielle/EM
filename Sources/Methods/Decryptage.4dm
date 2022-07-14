//%attributes = {}
// Decryptage 
// Champs cryptés : Nom - NomNaissance - DateNaissance - CP - Ville - Tel - Mail
// Créer la collection des données décryptées (selon profil)
// $1 : User

C_OBJECT:C1216($1; $sharedObj; $objCopy)
C_COLLECTION:C1488($sharedCollection)
$sharedCollection:=New shared collection:C1527()
$sharedObj:=New shared object:C1526()
$user:=$1

SelectionEtatCivilSelonProfil($user.UUID)
For ($i; 1; Records in selection:C76([EtatCivil:14]))
	GOTO SELECTED RECORD:C245([EtatCivil:14]; $i)
	$sharedObj:=DecryptageBlob(->[EtatCivil:14]BlobCrypted:8)
	$sharedObj.ID:=[EtatCivil:14]ID:1
	$sharedObj.Prenom:=[EtatCivil:14]Prenom:7
	$sharedObj.CodeDossier:=[EtatCivil:14]CodeDossier:30
	$sharedObj.Type:=[EtatCivil:14]Type:3
	$objCopy:=OB Copy:C1225($sharedObj; ck shared:K85:29; $sharedCollection)
	
	Use ($sharedCollection)
		$sharedCollection.push($objCopy)
	End use 
	
End for 

Use (Storage:C1525)
	Storage:C1525.SharedEtatCivil:=New shared collection:C1527()
	Storage:C1525.SharedEtatCivil:=$sharedCollection.copy(ck shared:K85:29)
End use 