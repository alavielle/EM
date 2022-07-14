//%attributes = {}
// GetBourses
// $1 : UUID 

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="bourse")
$contenu:=[ModelesHTML:15]Detail:3

$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
$display:=""
If ($user#Null:C1517)
	If (IsAdmin($1))
		ALL RECORDS:C47([Bourse:12])
		$admin:=""
	Else 
		$admin:="hidden"
		If ($user.ID_Equipe>0)
			Case of 
				: ($user.ID_Privilege=3)
					QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID_ASEM:4=$user.ID_Equipe)
				: ($user.ID_Privilege=4)
					QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID_ASA:3=$user.ID_Equipe)
					$display:="hidden"
			End case 
			CREATE EMPTY SET:C140([EtatCivil:14]; "beneficiaires")
			While (Not:C34(End selection:C36([FoyerFiscal:3])))
				QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID_CodeFiscal:31=[FoyerFiscal:3]ID:1)
				While (Not:C34(End selection:C36([EtatCivil:14])))
					ADD TO SET:C119([EtatCivil:14]; "beneficiaires")
					NEXT RECORD:C51([EtatCivil:14])
				End while 
				NEXT RECORD:C51([FoyerFiscal:3])
			End while 
			USE SET:C118("beneficiaires")
			RELATE MANY SELECTION:C340([Bourse:12]ID_Boursier:8)
			CLEAR SET:C117("beneficiaires")
		Else 
			QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID_CodeFiscal:31=$user.ID_CodeFiscal)
			QUERY:C277([Bourse:12]; [EtatCivil:14]ID_CodeFiscal:31=$user.ID_CodeFiscal)
		End if 
	End if 
End if 
QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
$id_anneeSco:=[AnneeScolaire:21]ID:1
QUERY SELECTION:C341([Bourse:12]; [Bourse:12]ID_AnneeSco:2=$id_anneeSco)
If (Records in selection:C76([Bourse:12])>0)
	C_TEXT:C284($Composant)
	ARRAY OBJECT:C1221($tabObj; 0)
	For ($i; 1; Records in selection:C76([Bourse:12]))
		$scolarite:=ds:C1482.Scolarite.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; [Bourse:12]ID_Boursier:8; $id_anneeSco)
		$classe:=""
		If ($scolarite.length>0)
			$classe:=$scolarite[0].classe.Classe
		End if 
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [Bourse:12]ID_Boursier:8)[0]
		$NomPrenom:=$SharedEC.Nom+" "+$SharedEC.Prenom
		$CodeDossier:=$SharedEC.CodeDossier
		APPEND TO ARRAY:C911($tabObj; New object:C1471("ID"; [Bourse:12]ID:1; "Nom Prénom"; $NomPrenom; "Classe"; $classe; "UC"; [Bourse:12]UC:51; "Montant"; [Bourse:12]Montant:55; "Dossier"; $CodeDossier; "Type"; [Bourse:12]TypeAide:60; "Année"; [AnneeScolaire:21]AnneeSco:2; "MontantAvance"; [Bourse:12]MontantAvance:25; "DateAvance"; [Bourse:12]DateAvance:26; "MontantSolde"; [Bourse:12]MontantSolde:36; "DateSolde"; [Bourse:12]DateSolde:37))
		NEXT RECORD:C51([Bourse:12])
	End for 
	
	$Composant:=JSON Stringify array:C1228($tabObj)
	$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
	$Contenu:=Replace string:C233($Contenu; "$noData$"; "")
	$Contenu:=Replace string:C233($Contenu; "$Display$"; $display)
	$Contenu:=Replace string:C233($Contenu; "$admin$"; $admin)
	
Else 
	$Contenu:=Replace string:C233($Contenu; "$noData$"; "Pas de dossier en cours")
End if 

WEB SEND TEXT:C677($Contenu; "text/html")
UNLOAD RECORD:C212([ModelesHTML:15])