Case of 
	: (Trigger event:C369=Sur sauvegarde nouvel enreg:K3:1)
		Case of 
			: ([EtatCivil:14]Type:3="RESSORTISSANT")
				[EtatCivil:14]Ordre:5:=1
			: ([EtatCivil:14]Type:3="CONJOINT")
				[EtatCivil:14]Ordre:5:=2
			: ([EtatCivil:14]Type:3="ENFANT")
				[EtatCivil:14]Ordre:5:=3
			: ([EtatCivil:14]Type:3="TUTEUR")
				[EtatCivil:14]Ordre:5:=4
		End case 
		[EtatCivil:14]LieuNaissance:10:=Uppercase:C13([EtatCivil:14]LieuNaissance:10)
		[EtatCivil:14]Type:3:=Uppercase:C13([EtatCivil:14]Type:3)
End case 