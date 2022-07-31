//%attributes = {}
// GetWebUser

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="user_new")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([EtatCivil:14]; [EtatCivil:14]Type:3="RESSORTISSANT")
ORDER BY:C49([EtatCivil:14]Prenom:7; >)

ARRAY LONGINT:C221(tabIdRessort; 0)
ARRAY TEXT:C222(TabLibRessort; 0)
ARRAY TEXT:C222(TabCodeDossier; 0)
SELECTION TO ARRAY:C260([EtatCivil:14]ID:1; tabIdRessort; [EtatCivil:14]Prenom:7; TabLibRessort; [EtatCivil:14]CodeDossier:30; TabCodeDossier)

C_TEXT:C284($Composant)
C_OBJECT:C1216($ComposantProperties)
OB SET:C1220($ComposantProperties; "onchange"; "Oui")
OB SET:C1220($ComposantProperties; "onchangemethod"; "popRessortSelected")
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
OB SET:C1220($ParamSelect; "LigneChoisir"; "Le ressortissant")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Vrai")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$Composant:=HTML_Select("Choisir dans la liste"; "ressortSelected"; ->tabIdRessort; ->TabLibRessort; $ComposantProperties; ""; $ParamSelect)

$Contenu:=Replace string:C233($Contenu; "$optionRessort$"; $Composant)

ALL RECORDS:C47([EtatCivil:14])
QUERY:C277([EtatCivil:14]; [EtatCivil:14]Type:3="CONJOINT")
ORDER BY:C49([EtatCivil:14]Prenom:7; >)

ARRAY LONGINT:C221(tabIdConjoint; 0)
ARRAY TEXT:C222(TabLibConjoint; 0)
SELECTION TO ARRAY:C260([EtatCivil:14]ID:1; tabIdConjoint; [EtatCivil:14]Prenom:7; TabLibConjoint)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
OB SET:C1220($ParamSelect; "LigneChoisir"; "Le Conjoint")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Vrai")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$Composant:=HTML_Select("Choisir dans la liste"; "conjointSelected"; ->tabIdConjoint; ->TabLibConjoint; Null:C1517; ""; $ParamSelect)

$Contenu:=Replace string:C233($Contenu; "$optionConjoint$"; $Composant)

ALL RECORDS:C47([EtatCivil:14])
ARRAY TEXT:C222($tabType; 0)
ARRAY TEXT:C222($tabIdType; 0)
DISTINCT VALUES:C339([EtatCivil:14]Type:3; $tabType)
DISTINCT VALUES:C339([EtatCivil:14]Type:3; $tabIdType)

OB SET:C1220($ComposantProperties; "onchangemethod"; "popTypeSelected")
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
OB SET:C1220($ParamSelect; "LigneChoisir"; "Le type")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Vrai")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$Composant:=HTML_Select("Choisir dans la liste"; "typeSelected"; ->$tabIdType; ->$tabType; $ComposantProperties; ""; $ParamSelect)

$Contenu:=Replace string:C233($Contenu; "$optionType$"; $Composant)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

WEB SEND TEXT:C677($Contenu; "text/html")