//%attributes = {}
//SauvegarderStorageEtatCivil
//$1 : ID
//$2 : Nom
//$3 : NomNaissance
//$4 : DateNaissance
//$5 : CP
//$6 : Ville
//$7 : Tel
//$8 : Email

C_LONGINT:C283($1)
C_TEXT:C284($2; $3; $4; $5; $6; $7; $8; $toBlob)
C_OBJECT:C1216($objEC)
$id:=$1

CLEAR VARIABLE:C89($objEC)
If ($id=0)
	OB SET:C1220($objEC; "Nom"; Uppercase:C13($2))
	OB SET:C1220($objEC; "NomNaissance"; Uppercase:C13($3))
	OB SET:C1220($objEC; "DateNaissance"; Date:C102($4))
	OB SET:C1220($objEC; "CP"; $5)
	OB SET:C1220($objEC; "Ville"; Uppercase:C13($6))
	OB SET:C1220($objEC; "Tel"; $7)
	OB SET:C1220($objEC; "Email"; $8)
	Use (Storage:C1525.SharedEtatCivil)
		$SharedEC:=Storage:C1525.SharedEtatCivil.push($objEC)
	End use 
	$toBlob:=JSON Stringify:C1217($objEC)
Else 
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $id)[0]
	If ($SharedEC#Null:C1517)
		Use (Storage:C1525.SharedEtatCivil)
			$SharedEC.Nom:=Uppercase:C13($2)
			$SharedEC.NomNaissance:=Uppercase:C13($3)
			$SharedEC.DateNaissance:=Date:C102($4)
			$SharedEC.CP:=$5
			$SharedEC.Ville:=Uppercase:C13($6)
			$SharedEC.Tel:=$7
			$SharedEC.Email:=$8
		End use 
		$toBlob:=JSON Stringify:C1217($SharedEC)
	End if 
End if 
READ WRITE:C146([EtatCivil:14])
QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID:1=$id)
TEXT TO BLOB:C554($toBlob; [EtatCivil:14]BlobCrypted:8)
QUERY:C277([Keys:25]; [Keys:25]TimeStampKeyPair:4#"")
ENCRYPT BLOB:C689([EtatCivil:14]BlobCrypted:8; [Keys:25]PrivateKey:2)  //On crypte le blob
SAVE RECORD:C53([EtatCivil:14])
UNLOAD RECORD:C212([EtatCivil:14])
UNLOAD RECORD:C212([Keys:25])
