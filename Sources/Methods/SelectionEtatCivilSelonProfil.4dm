//%attributes = {}
// SelectionEtatCivilSelonProfil
//$1 : UUIDuser

C_TEXT:C284($1)
$uuid:=$1
$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If (IsAdmin($uuid))
	ALL RECORDS:C47([EtatCivil:14])
Else 
	If ($user.ID_Equipe>0)
		Case of 
			: ($user.ID_Privilege=3)
				//CHERCHER([FoyerFiscal]; [FoyerFiscal]ID_ASEM=$user.ID_Equipe)
				ALL RECORDS:C47([FoyerFiscal:3])
			: ($user.ID_Privilege=4)
				QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID_ASA:3=$user.ID_Equipe)
		End case 
		RELATE MANY SELECTION:C340([EtatCivil:14]ID_CodeFiscal:31)
	Else 
		If ($user.ID_CodeFiscal>0)
			QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID_CodeFiscal:31=$user.ID_CodeFiscal)
		End if 
	End if 
End if 