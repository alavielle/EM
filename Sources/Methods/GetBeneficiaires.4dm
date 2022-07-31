//%attributes = {}
//GetBeneficiaires
//$1 : Type de bénéficiaire

C_TEXT:C284($Composant; $display; $autres; $autre; $feminin; $Classe; $Assurances)
ARRAY OBJECT:C1221($tabObj; 0)
C_OBJECT:C1216($etatCivil)

If ($1="AUTRE")
	$autres:="PERSONNES A CHARGE"
	$autre:="personne à charge"
	$feminin:="e"
End if 

For each ($etatCivil; ds:C1482.EtatCivil.query("Type = :1"; $1))
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatCivil.ID)
	If ($SharedEC.length>0)
		$Nom:=$SharedEC[0].Nom
		$Email:=$SharedEC[0].Email
		$DateNaissance:=$SharedEC[0].DateNaissance
		$Ville:=$SharedEC[0].Ville
		Case of 
			: ($1="RESSORTISSANT")
				APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $etatcivil.UUID; "ID"; $etatcivil.ID; "Nom"; $Nom; "Prenom"; $etatcivil.Prenom; "Assurances"; $Assurance; "CodeDossier"; $etatCivil.CodeDossier; "Decede"; $etatcivil.Decede; "DateDeces"; $etatCivil.DateDeces))
				
			: ($1="CONJOINT")
				APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $etatcivil.UUID; "ID"; $etatcivil.ID; "Nom"; $Nom; "Prenom"; $etatcivil.Prenom; "Ville"; $Ville; "Email"; $Email; "CodeDossier"; $etatCivil.CodeDossier; "Decede"; $etatcivil.Decede; "DateDeces"; $etatCivil.DateDeces))
				
			: ($1="ENFANT")
				$scolarite:=$etatCivil.scolarites.query("ID_AnneeSco = :1"; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].ID)
				If ($scolarite.length>0)
					$Classe:=$scolarite[0].classe.Classe
				Else 
					$Classe:=""
				End if 
				APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $etatcivil.UUID; "ID"; $etatcivil.ID; "Nom"; $Nom; "Prenom"; $etatcivil.Prenom; "DateNaissance"; $DateNaissance; "Ville"; $Ville; "Classe"; $Classe; "CodeDossier"; $etatCivil.CodeDossier; "IndependantFiscal"; $etatCivil.IndependantFiscal; "Handicap"; $etatCivil.Handicap; "SuperIsole"; $etatCivil.SuperIsole))
			Else 
				APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $etatcivil.UUID; "ID"; $etatcivil.ID; "Nom"; $Nom; "Prenom"; $etatcivil.Prenom; "Ville"; $Ville; "Email"; $Email; "CodeDossier"; $etatCivil.CodeDossier; "Decede"; $etatcivil.Decede; "DateDeces"; $etatCivil.DateDeces))
		End case 
	End if 
End for each 

$Composant:=JSON Stringify array:C1228($tabObj)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="beneficiaires")
If (Records in selection:C76([ModelesHTML:15])=1)
	$contenu:=[ModelesHTML:15]Detail:3
	UNLOAD RECORD:C212([ModelesHTML:15])
	
	QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
	$navBar:=[ModelesHTML:15]Detail:3
	UNLOAD RECORD:C212([ModelesHTML:15])
	$prenomNom:=Session:C1714.userName
	$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
	$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)
	
	$Contenu:=Replace string:C233($Contenu; "$Type$"; $1)
	$Contenu:=Replace string:C233($Contenu; "$autres$"; $autres)
	$Contenu:=Replace string:C233($Contenu; "$autre$"; $autre)
	$Contenu:=Replace string:C233($Contenu; "$feminin$"; $feminin)
	$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
	$Contenu:=Replace string:C233($Contenu; "$Display$"; $display)
	WEB SEND TEXT:C677($Contenu; "text/html")
End if 
