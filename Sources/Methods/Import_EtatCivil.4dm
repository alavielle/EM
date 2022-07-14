//%attributes = {}
//ImportEtatCivil

C_OBJECT:C1216($etatcivil; $temp; $ObjCrypte)
$imports:=ds:C1482.ImportEtatCivil.all()
For each ($import; $imports)
	$temp:=$import.toObject()
	$etatcivil:=ds:C1482.EtatCivil.new()
	$etatcivil.fromObject($temp)
	$etatcivil.save()
	
	OB SET:C1220($objCrypte; "Nom"; Uppercase:C13($temp.Nom))
	OB SET:C1220($objCrypte; "NomNaissance"; Uppercase:C13($temp.NomNaissance))
	OB SET:C1220($objCrypte; "DateNaissance"; Date:C102($temp.DateNaissance))
	OB SET:C1220($objCrypte; "CP"; $temp.CodePostal)
	OB SET:C1220($objCrypte; "Ville"; Uppercase:C13($temp.Ville))
	OB SET:C1220($objCrypte; "Tel"; $temp.Tel)
	OB SET:C1220($objCrypte; "Email"; $temp.Email)
	
	$toBlob:=JSON Stringify:C1217($objCrypte)
	QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID:1=$etatcivil.ID)
	TEXT TO BLOB:C554($toBlob; [EtatCivil:14]BlobCrypted:8)
	QUERY:C277([Keys:25]; [Keys:25]TimeStampKeyPair:4#"")
	ENCRYPT BLOB:C689([EtatCivil:14]BlobCrypted:8; [Keys:25]PrivateKey:2)  //On crypte le blob
	SAVE RECORD:C53([EtatCivil:14])
	UNLOAD RECORD:C212([EtatCivil:14])
	UNLOAD RECORD:C212([Keys:25])
	
End for each 
