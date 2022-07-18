//%attributes = {}
// CrudPalier
// $1 : Index

ALL RECORDS:C47([Palier:11])
$composant:=Crud($1; ->[Palier:11]; ds:C1482.Palier)

$seuil:=ds:C1482.Seuil.all().first()
$seuilValue:=$seuil.Seuil
C_OBJECT:C1216($InputProperties)
OB SET:C1220($InputProperties; "method"; "")
OB SET:C1220($InputProperties; "onmethod"; "")
OB SET:C1220($InputProperties; "buttonname"; "Calculer")
$param:=HTML_InputGroup("Seuil de pauvreté"; "Seuil"; $seuilValue; $InputProperties)

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
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "")
$Contenu:=Replace string:C233($Contenu; "$param$"; $param)
$Contenu:=Replace string:C233($Contenu; "$title$"; "Paliers")
$Contenu:=Replace string:C233($Contenu; "$url$"; "Paliers")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")