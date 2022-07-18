//%attributes = {}
// GetCompte
// $1 : UUID

C_TEXT:C284($1)
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="compte")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([WebUser:2]; [WebUser:2]UUID:7=$1)

If (Records in selection:C76([WebUser:2])=1)
	vnom:=[WebUser:2]Nom:3
	vprenom:=[WebUser:2]Prenom:4
	vemail:=[WebUser:2]Email:2
	
	QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
	$navBar:=[ModelesHTML:15]Detail:3
	UNLOAD RECORD:C212([ModelesHTML:15])
	$prenomNom:=Session:C1714.userName
	$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
	$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)
	
	WEB SEND TEXT:C677($Contenu; "text/html")
Else 
	WEB SEND HTTP REDIRECT:C659("/403.shtml")
End if 