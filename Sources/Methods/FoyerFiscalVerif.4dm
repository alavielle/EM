//%attributes = {}
//FoyerFiscalVerif
//$1 : code Dossier

QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]CodeFiscal:2=$1)
If (Records in selection:C76([FoyerFiscal:3])=0)
	$id:=FoyerFiscalCreate($1; 0; 0)
Else 
	$id:=[FoyerFiscal:3]ID:1
End if 
UNLOAD RECORD:C212([FoyerFiscal:3])
ALL RECORDS:C47([EtatCivil:14])
QUERY:C277([EtatCivil:14]; [EtatCivil:14]CodeDossier:30=$1; *)
QUERY:C277([EtatCivil:14];  & ; [EtatCivil:14]ID_CodeFiscal:31=0)
If (Records in selection:C76([EtatCivil:14])>0)
	READ WRITE:C146([EtatCivil:14])
	For ($VElEnreg; 1; Records in selection:C76([EtatCivil:14]))
		[EtatCivil:14]ID_CodeFiscal:31:=$id
		SAVE RECORD:C53([EtatCivil:14])
		NEXT RECORD:C51([EtatCivil:14])
	End for 
	READ ONLY:C145([EtatCivil:14])
End if 

$0:=$id