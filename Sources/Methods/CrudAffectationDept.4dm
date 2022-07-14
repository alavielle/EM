//%attributes = {}
// CrudAffectationDept
// $1 : Index

C_OBJECT:C1216($objMesChamps)
OB SET:C1220($objMesChamps; "ID"; ->[AffectationDept:27]ID:1)
OB SET:C1220($objMesChamps; "PoleSocial"; ->[PoleSocial:17]Nom:2)
OB SET:C1220($objMesChamps; "Departement"; ->[AffectationDept:27]Departement:3)
ALL RECORDS:C47([EquipeSociale:16])
$composant:=Crud($1; ->[AffectationDept:27]; ds:C1482.AffectationDept; $objMesChamps)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="crud")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$Contenu:=Replace string:C233($Contenu; "$displayAdd$"; "")
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "")
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Affectation des départements")
$Contenu:=Replace string:C233($Contenu; "$url$"; "AffectationDept")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")