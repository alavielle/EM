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
		$ressortEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Ressortissant)[0]
		OB SET:C1220($objEC; "NomRessortissant"; $ressortEC.Nom+" "+$ressortEC.Prenom; "UUID_Ressortissant"; $etatcivil.ressortissant.UUID)
	End if 
	If ($etatcivil.ID_Conjoint>0)
		$conjointEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Conjoint)[0]
		OB SET:C1220($objEC; "NomConjoint"; $conjointEC.Nom+" "+$conjointEC.Prenom; "UUID_Conjoint"; $etatcivil.conjoint.UUID)
	End if 
	If ($etatcivil.ID_Tuteur>0)
		$tuteurEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Tuteur)[0]
		OB SET:C1220($objEC; "NomTuteur"; $tuteurEC.Nom+" "+$tuteurEC.Prenom; "UUID_Tuteur"; $etatcivil.tuteur.UUID)
	End if 
	OB SET:C1220($objEC; "FoyerFiscal"; $etatcivil.foyerFiscal.CodeFiscal)
End if 
$0:=JSON Stringify:C1217($objEC)

