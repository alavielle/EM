//%attributes = {}
//SaveStorageEtatCivil
//$1 : ID
//$2 : Nom
//$3 : NomNaissance
//$4 : DateNaissance
//$5 : CP
//$6 : Ville
//$7 : Tel
//$8 : Email
//$9 : Prenom
//$10: CodeDossier
//$11: Type

C_LONGINT:C283($1)
C_TEXT:C284($2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $toBlob)
C_OBJECT:C1216($objEC; $objToBlob)
$id:=$1

CLEAR VARIABLE:C89($objEC)
$SharedEtatCivil:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $id)
If ($SharedEtatCivil.length=0)
	$objEC:=New shared object:C1526()
	Use ($objEC)
		OB SET:C1220($objEC; "ID"; $id)
		OB SET:C1220($objEC; "Nom"; Uppercase:C13($2))
		OB SET:C1220($objEC; "NomNaissance"; Uppercase:C13($3))
		OB SET:C1220($objEC; "DateNaissance"; Date:C102($4))
		OB SET:C1220($objEC; "CP"; $5)
		OB SET:C1220($objEC; "Ville"; Uppercase:C13($6))
		OB SET:C1220($objEC; "Tel"; $7)
		OB SET:C1220($objEC; "Email"; $8)
		OB SET:C1220($objEC; "Prenom"; $9)
		OB SET:C1220($objEC; "CodeDossier"; $10)
		OB SET:C1220($objEC; "Type"; $11)
	End use 
	Use (Storage:C1525.SharedEtatCivil)
		Storage:C1525.SharedEtatCivil.push($objEC)
	End use 
Else 
	Use (Storage:C1525.SharedEtatCivil)
		$sharedEC:=$SharedEtatCivil[0]
		$SharedEC.Nom:=Uppercase:C13($2)
		$SharedEC.NomNaissance:=Uppercase:C13($3)
		$SharedEC.DateNaissance:=Date:C102($4)
		$SharedEC.CP:=$5
		$SharedEC.Ville:=Uppercase:C13($6)
		$SharedEC.Tel:=$7
		$SharedEC.Email:=$8
		$sharedEC.Prenom:=$9
		$sharedEC.CodeDossier:=$10
		$sharedEC.Type:=$11
	End use 
End if 
OB SET:C1220($objToBlob; "ID"; $id)
OB SET:C1220($objToBlob; "Nom"; Uppercase:C13($2))
OB SET:C1220($objToBlob; "NomNaissance"; Uppercase:C13($3))
OB SET:C1220($objToBlob; "DateNaissance"; Date:C102($4))
OB SET:C1220($objToBlob; "CP"; $5)
OB SET:C1220($objToBlob; "Ville"; Uppercase:C13($6))
OB SET:C1220($objToBlob; "Tel"; $7)
OB SET:C1220($objToBlob; "Email"; $8)
$toBlob:=JSON Stringify:C1217($objToBlob)
READ WRITE:C146([EtatCivil:14])
QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID:1=$id)
TEXT TO BLOB:C554($toBlob; [EtatCivil:14]BlobCrypted:8)
QUERY:C277([Keys:25]; [Keys:25]TimeStampKeyPair:4#"")
ENCRYPT BLOB:C689([EtatCivil:14]BlobCrypted:8; [Keys:25]PrivateKey:2)  //On crypte le blob
SAVE RECORD:C53([EtatCivil:14])
UNLOAD RECORD:C212([EtatCivil:14])
UNLOAD RECORD:C212([Keys:25])
