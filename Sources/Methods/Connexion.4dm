//%attributes = {}
// Connexion
// $1 : message

$cookie:="Set-Cookie: 4DUUID=0; PATH=/"
WEB SET HTTP HEADER:C660($cookie)
$prenomNom:=""
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="login")
$contenu:=[ModelesHTML:15]Detail:3
C_TEXT:C284($Composant)
$Composant:=HTML_Trouble($1)
$Contenu:=Replace string:C233($Contenu; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$trouble$"; $Composant)
WEB SEND TEXT:C677($Contenu; "text/html")
UNLOAD RECORD:C212([ModelesHTML:15])