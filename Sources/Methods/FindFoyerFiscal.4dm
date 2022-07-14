//%attributes = {}
//FindFoyerFiscal
//$1 : CodeDossier

C_TEXT:C284($Composant; $details; $1)
C_REAL:C285($Nb_UC; $quotient)
ARRAY LONGINT:C221($TabIndex; 0)
ARRAY TEXT:C222($TabLibDetail; 0)
$Composant:=""
$details:=""
If (Length:C16($1)>0)
	QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
	$annee:=Substring:C12([AnneeScolaire:21]AnneeSco:2; 1; 4)
	
	QUERY:C277([EtatCivil:14]; [EtatCivil:14]CodeDossier:30=$1)
	ORDER BY:C49([EtatCivil:14]; [EtatCivil:14]ID:1)
	CREATE SET:C116([EtatCivil:14]; "EnsCodeDossier")
	RELATE ONE SELECTION:C349([EtatCivil:14]; [FoyerFiscal:3])
	CREATE SET:C116([FoyerFiscal:3]; "EnsFoyerFIscal")
	
	For ($i; 1; Records in selection:C76([FoyerFiscal:3]))
		USE SET:C118("EnsCodeDossier")
		QUERY SELECTION:C341([EtatCivil:14]; [EtatCivil:14]ID_CodeFiscal:31=[FoyerFiscal:3]ID:1)
		
		$Nb_UC:=CalculNbUC
		
		QUERY:C277([Ressource:13]; [Ressource:13]ID_CodeFiscal:2=[FoyerFiscal:3]ID:1)
		QUERY SELECTION:C341([Ressource:13]; [Ressource:13]Annee:3=$annee)
		If ((Records in selection:C76([Ressource:13])=1) & ($Nb_UC>0))
			$quotient:=[Ressource:13]TT:40/12/$Nb_UC
			$detailTab:=[FoyerFiscal:3]CodeFiscal:2+" - Nombre d'UC : "+String:C10($Nb_UC)+" - Quotient : "+String:C10(Round:C94($quotient; 2))
		Else 
			If ($Nb_UC=0)
				$detailTab:=[EtatCivil:14]CodeDossier:30
			Else 
				$detailTab:=[FoyerFiscal:3]CodeFiscal:2+" - Nombre d'UC : "+String:C10($Nb_UC)+" - Quotient : NC"
			End if 
		End if 
		
		APPEND TO ARRAY:C911($TabIndex; [FoyerFiscal:3]ID:1)
		APPEND TO ARRAY:C911($TabLibDetail; $detailTab)
		NEXT RECORD:C51([FoyerFiscal:3])
	End for 
	
	ARRAY OBJECT:C1221($tabObj; 0)
	USE SET:C118("EnsCodeDossier")
	For ($j; 1; Records in selection:C76([EtatCivil:14]))
		$indexDetail:=Find in array:C230($TabIndex; [EtatCivil:14]ID_CodeFiscal:31)
		$detail:=$TabLibDetail{$indexDetail}
		RELATE ONE:C42([EtatCivil:14]ID_CodeFiscal:31)
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [EtatCivil:14]ID:1)[0]
		$Nom:=$SharedEC.Nom
		$Prenom:=$SharedEC.Prenom
		$DateNaissance:=$SharedEC.DateNaissance
		APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; [EtatCivil:14]UUID:34; "ID"; [EtatCivil:14]ID:1; "Nom"; $Nom; "Prénom"; $Prenom; "DateNaissance"; $DateNaissance; "Type"; [EtatCivil:14]Type:3; "Decede"; [EtatCivil:14]Decede:20; "Ordre"; [EtatCivil:14]Ordre:5; "Code"; $Detail))
		NEXT RECORD:C51([EtatCivil:14])
	End for 
	$Composant:=JSON Stringify array:C1228($tabObj)
End if 

ReturnSomething($Composant)