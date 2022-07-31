//%attributes = {}
// CrudPrivilege
// $1 : Index


$composant:=Crud($1; ->[Privilege:4]; ds:C1482.Privilege)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="crud")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$displayAdd$"; "hidden")
$Contenu:=Replace string:C233($Contenu; "$displayMail$"; "hidden")
$Contenu:=Replace string:C233($Contenu; "$TypeEnvoi$"; "")
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "hidden")
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Privilèges")
$Contenu:=Replace string:C233($Contenu; "$url$"; "Privileges")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")