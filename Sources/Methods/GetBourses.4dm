//%attributes = {}
// GetBourses
// $1 : UUID 

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="bourse")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
C_TEXT:C284($composant)
ARRAY OBJECT:C1221($tabObj; 0)

$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
$display:=""
$visible:="true"

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
			$display:="hidden"
			$visible:="false"
			QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID_CodeFiscal:31=$user.ID_CodeFiscal)
			QUERY:C277([Bourse:12]; [EtatCivil:14]ID_CodeFiscal:31=$user.ID_CodeFiscal)
		End if 
	End if 
End if 
QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
$id_anneeSco:=[AnneeScolaire:21]ID:1
QUERY SELECTION:C341([Bourse:12]; [Bourse:12]ID_AnneeSco:2=$id_anneeSco)
If (Records in selection:C76([Bourse:12])>0)
	
	For ($i; 1; Records in selection:C76([Bourse:12]))
		$scolarite:=ds:C1482.Scolarite.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; [Bourse:12]ID_Boursier:8; $id_anneeSco)
		$classe:=""
		If ($scolarite.length>0)
			$classe:=$scolarite[0].classe.Classe
		End if 
		If ([Bourse:12]ID_Boursier:8>0)
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [Bourse:12]ID_Boursier:8)[0]
			$NomPrenom:=$SharedEC.Nom+" "+$SharedEC.Prenom
			$CodeDossier:=$SharedEC.CodeDossier
			$etatCivil:=ds:C1482.EtatCivil.query("ID = :1"; [Bourse:12]ID_Boursier:8)[0]
			APPEND TO ARRAY:C911($tabObj; New object:C1471("ID"; [Bourse:12]ID:1; "Nom Pr??nom"; $NomPrenom; "Classe"; $classe; "UC"; [Bourse:12]UC:51; "Montant"; [Bourse:12]Montant:55; "Dossier"; $CodeDossier; "Type"; [Bourse:12]TypeAide:60; "Ann??e"; [AnneeScolaire:21]AnneeSco:2; "BM"; [Bourse:12]BM:17; "IndFiscal"; $etatCivil.IndependantFiscal; "SuperIsole"; $etatCivil.SuperIsole; "MontantAvance"; [Bourse:12]MontantAvance:25; "DateAvance"; [Bourse:12]DateAvance:26; "MontantSolde"; [Bourse:12]MontantSolde:36; "DateSolde"; [Bourse:12]DateSolde:37; "MontantBM"; [Bourse:12]MontantBM:18; "NbMois"; [Bourse:12]NbMois:19))
		End if 
		NEXT RECORD:C51([Bourse:12])
	End for 
	$Composant:=JSON Stringify array:C1228($tabObj)
	$Contenu:=Replace string:C233($Contenu; "$noData$"; "")
	
Else 
	$noData:=HTML_Trouble("Pas de dossier en cours")
	$Contenu:=Replace string:C233($Contenu; "$noData$"; $noData)
End if 


$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$Display$"; $display)
$Contenu:=Replace string:C233($Contenu; "$Visible$"; $visible)
$Contenu:=Replace string:C233($Contenu; "$admin$"; $admin)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

WEB SEND TEXT:C677($Contenu; "text/html")