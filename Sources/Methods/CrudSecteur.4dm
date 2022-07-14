//%attributes = {}
// CrudSecteur
// $1 : Index

ALL RECORDS:C47([SecteurMarine:35])
$composant:=Crud($1; ->[SecteurMarine:35]; ds:C1482.SecteurMarine)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="crud")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$Contenu:=Replace string:C233($Contenu; "$displayAdd$"; "")
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "")
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Secteurs Marine")
$Contenu:=Replace string:C233($Contenu; "$url$"; "Secteurs")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")