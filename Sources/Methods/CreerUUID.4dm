//%attributes = {}
// CreerUUID

ALL RECORDS:C47([EtatCivil:14])
For ($i; 1; Records in selection:C76([EtatCivil:14]))
	[EtatCivil:14]UUID:34:=Generate UUID:C1066
	SAVE RECORD:C53([EtatCivil:14])
	NEXT RECORD:C51([EtatCivil:14])
End for 