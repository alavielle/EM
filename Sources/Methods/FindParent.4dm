//%attributes = {}
//FindParent
//$1 : BourseID/Type/UUID EtatCivil (type 1 : ressortissant, type 2 : conjoint)

C_COLLECTION:C1488($param)
$param:=New collection:C1472
$param:=Split string:C1554($1; "/")
$bourseID:=$param[1]
$type:=$param[2]
$uuid:=$param[3]

QUERY:C277([EtatCivil:14]; [EtatCivil:14]UUID:34=$uuid)
If (Records in selection:C76([EtatCivil:14])=1)
	$id_ressortissant:=[EtatCivil:14]ID_Ressortissant:32
	$id_conjoint:=[EtatCivil:14]ID_Conjoint:33
End if 

If ($type="1")
	$composant:=FindEtatCivilById($id_ressortissant)
Else 
	$composant:=FindEtatCivilById($id_conjoint)
End if 

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossier_parent"+$type)
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil_base")
$contenu_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$assurance_base:=SelectAssurance()
$contenu_activite:=SelectActiviteMarine()

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $contenu_base)
$Contenu:=Replace string:C233($Contenu; "$assurance_base$"; $assurance_base)
$Contenu:=Replace string:C233($Contenu; "$activite_marine$"; $contenu_activite)
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$UUID_boursier$"; $uuid)
$Contenu:=Replace string:C233($Contenu; "$BourseID$"; $BourseID)

WEB SEND TEXT:C677($Contenu; "text/html")
