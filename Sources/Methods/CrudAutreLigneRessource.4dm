//%attributes = {}
// CrudAutreLigneRessource
// $1 : Index

ALL RECORDS:C47([AutreLigneRessource:40])
$composant:=Crud($1; ->[AutreLigneRessource:40]; ds:C1482.AutreLigneRessource)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="crud")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$displayAdd$"; "")
$Contenu:=Replace string:C233($Contenu; "$displayMail$"; "hidden")
$Contenu:=Replace string:C233($Contenu; "$TypeEnvoi$"; "")
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "")
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Autres Lignes Ressources")
$Contenu:=Replace string:C233($Contenu; "$url$"; "AutresLignesRessources")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")