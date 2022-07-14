//%attributes = {}
// CrudWebUser
// $1 : Index

C_OBJECT:C1216($objMesChamps)
C_COLLECTION:C1488($AS1; $AS)
OB SET:C1220($objMesChamps; "ID"; ->[WebUser:2]ID:1)
OB SET:C1220($objMesChamps; "Email"; ->[WebUser:2]Email:2)
OB SET:C1220($objMesChamps; "Nom"; ->[WebUser:2]Nom:3)
OB SET:C1220($objMesChamps; "Prenom"; ->[WebUser:2]Prenom:4)
OB SET:C1220($objMesChamps; "Profil"; ->[Privilege:4]Profil:2)
OB SET:C1220($objMesChamps; "CodeFiscal"; ->[FoyerFiscal:3]CodeFiscal:2)
$AS1:=New collection:C1472(->[EquipeSociale:16]Nom:2)
$AS:=$AS1.concat(->[EquipeSociale:16]Prenom:3)
OB SET:C1220($objMesChamps; "AS"; $AS)
OB SET:C1220($objMesChamps; "Pole"; ->[PoleSocial:17]Nom:2)

QUERY:C277([WebUser:2]; [WebUser:2]ID_Privilege:6>1)
$composant:=Crud($1; ->[WebUser:2]; ds:C1482.WebUser; $objMesChamps)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="crud")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$Contenu:=Replace string:C233($Contenu; "$displayAdd$"; "hidden")
$Contenu:=Replace string:C233($Contenu; "$displayDelete$"; "")
$Contenu:=Replace string:C233($Contenu; "$param$"; "")
$Contenu:=Replace string:C233($Contenu; "$title$"; "Utilisateurs Web")
$Contenu:=Replace string:C233($Contenu; "$url$"; "WebUsers")
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)

WEB SEND TEXT:C677($Contenu; "text/html")