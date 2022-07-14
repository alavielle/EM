//%attributes = {}
//GetBeneficiaires
//$1 : Type de bénéficiaire

C_TEXT:C284($Composant; $display; $autres)
ARRAY OBJECT:C1221($tabObj; 0)
C_OBJECT:C1216($etatCivil)

If ($1="AUTRE")
	$autres:="PERSONNES A CHARGE"
End if 

For each ($etatCivil; ds:C1482.EtatCivil.query("Type = :1"; $1))
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatCivil.ID)
	If ($SharedEC.length>0)
		$Nom:=$SharedEC[0].Nom
		$Email:=$SharedEC[0].Email
		$Ville:=$SharedEC[0].Ville
		APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; $etatcivil.UUID; "ID"; $etatcivil.ID; "Nom"; $Nom; "Prenom"; $etatcivil.Prenom; "Email"; $Email; "Decede"; $etatcivil.Decede; "Ville"; $Ville))
	End if 
End for each 

$Composant:=JSON Stringify array:C1228($tabObj)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="beneficiaires")
If (Records in selection:C76([ModelesHTML:15])=1)
	$contenu:=[ModelesHTML:15]Detail:3
	$Contenu:=Replace string:C233($Contenu; "$Type$"; $1)
	$Contenu:=Replace string:C233($Contenu; "$autres$"; $autres)
	$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
	$Contenu:=Replace string:C233($Contenu; "$Display$"; $display)
	WEB SEND TEXT:C677($Contenu; "text/html")
	UNLOAD RECORD:C212([ModelesHTML:15])
End if 
