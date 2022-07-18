//%attributes = {}
// CrudClasse
// $1 : Index

C_OBJECT:C1216($objMesChamps)
OB SET:C1220($objMesChamps; "ID"; ->[Classe:8]ID:1)
OB SET:C1220($objMesChamps; "NiveauEtude"; ->[MontantPart:7]NiveauEtude:2)
OB SET:C1220($objMesChamps; "Classe"; ->[Classe:8]Classe:3)
ALL RECORDS:C47([Classe:8])
$composant:=Crud($1; ->[Classe:8]; ds:C1482.Classe; $objMesChamps)


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
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Classes")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Classes")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")