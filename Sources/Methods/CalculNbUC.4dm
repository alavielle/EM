//%attributes = {}
//CalculNbUC

C_OBJECT:C1216($sharedEC)
$Nb_UC:=0
For ($i; 1; Records in selection:C76([EtatCivil:14]))
	GOTO SELECTED RECORD:C245([EtatCivil:14]; $i)
	If ([EtatCivil:14]Decede:20=False:C215)
		$sharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [EtatCivil:14]ID:1)[0]
		If (Year of:C25(Current date:C33)-Year of:C25($sharedEC.DateNaissance)>=14)
			If ($Nb_UC=0)
				$Nb_UC:=1
			Else 
				$Nb_UC:=$Nb_UC+0.5
			End if 
		Else 
			$Nb_UC:=$Nb_UC+0.3
		End if 
	End if 
End for 

$0:=$Nb_UC