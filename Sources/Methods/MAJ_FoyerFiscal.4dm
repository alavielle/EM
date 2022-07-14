//%attributes = {}
// MAJ_FoyerFiscal

ALL RECORDS:C47([EtatCivil:14])
For ($i; 1; Records in selection:C76([EtatCivil:14]))
	GOTO RECORD:C242([EtatCivil:14]; $i)
	If ([EtatCivil:14]CodeDossier:30#"")
		QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]CodeFiscal:2=[EtatCivil:14]CodeDossier:30)
		If (Records in selection:C76([FoyerFiscal:3])>0)
		Else 
			CREATE RECORD:C68([FoyerFiscal:3])
			[FoyerFiscal:3]CodeFiscal:2:=[EtatCivil:14]CodeDossier:30
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID =:1"; [EtatCivil:14]ID:1)[0]
			$dept:=Substring:C12($SharedEC.CP; 1; 2)
			If (($dept="22") | ($dept="29") | ($dept="35") | ($dept="56") | ($dept="50"))
				[FoyerFiscal:3]ID_ASEM:4:=2
			Else 
				If (($dept="04") | ($dept="05") | ($dept="06") | ($dept="13") | ($dept="83") | ($dept="84") | ($dept="20"))
					[FoyerFiscal:3]ID_ASEM:4:=3
				Else 
					[FoyerFiscal:3]ID_ASEM:4:=1
				End if 
			End if 
		End if 
		SAVE RECORD:C53([FoyerFiscal:3])
	End if 
	NEXT RECORD:C51([EtatCivil:14])
End for 