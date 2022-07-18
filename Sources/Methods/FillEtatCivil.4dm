//%attributes = {}
//FillEtatCivil 
//$1 Type/id

C_TEXT:C284($composant; $hideIfNew; $SelectFiscal; $SelectAyantDroits; $SelectEnfants; $SelectTutelles; $autre; $activite_marine)
$position:=Position:C15("/"; $1)
$type:=Substring:C12($1; 1; $position-1)
$uuid:=Substring:C12($1; $position+1; Length:C16($1))

If ($type="AUTRE")
	$autre:="PERSONNE A CHARGE"
End if 

If (Length:C16($uuid)>0)
	$composant:=FindEtatCivilByUUID($uuid)
	$SelectFiscal:=FindAutresFoyers($uuid)
	$SelectAyantDroits:=FindAyantDroits($uuid)
	$SelectEnfants:=FindEnfants($uuid)
	$SelectTutelles:=FindTutelles($uuid)
End if 

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil_base")
$contenu_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="assurance_base")
$assurance_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
If ($type="RESSORTISSANT")
	QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="activite_marine")
	$activite_marine:=[ModelesHTML:15]Detail:3
	UNLOAD RECORD:C212([ModelesHTML:15])
End if 

$tuteur:=ds:C1482.EtatCivil.query("Type='TUTEUR'")
C_COLLECTION:C1488($myCol)
ARRAY LONGINT:C221($tabIdEC; 0)
ARRAY TEXT:C222($tabLibEC; 0)
C_OBJECT:C1216(ParamSelect)
OB SET:C1220(ParamSelect; "Required"; "Faux")
OB SET:C1220(ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220(ParamSelect; "LigneChoisir"; "")
OB SET:C1220(ParamSelect; "Disabled"; "Faux")
OB SET:C1220(ParamSelect; "Hidden"; "Faux")
OB SET:C1220(ParamSelect; "Multiple"; "Faux")
For each ($ec; $tuteur)
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $ec.ID)[0]
	APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
	APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
End for each 
$myCol:=New collection:C1472
ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
$myCol:=$myCol.orderBy("NomPrenom")
$SelectTuteurs:=HTML_Select_Collection("Tuteur"; "ID_Tuteur"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; ""; ParamSelect)

ALL RECORDS:C47([Assurance:22])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([Assurance:22]ID:1; $TabId; [Assurance:22]Assurance:2; $TabLib)
C_OBJECT:C1216(ParamSelect)
OB SET:C1220(ParamSelect; "Required"; "Faux")
OB SET:C1220(ParamSelect; "LigneVide"; "Faux")
OB SET:C1220(ParamSelect; "LigneChoisir"; "Faux")
OB SET:C1220(ParamSelect; "Disabled"; "Faux")
OB SET:C1220(ParamSelect; "Hidden"; "Faux")
OB SET:C1220(ParamSelect; "Multiple"; "Vrai")
$SelectAss:=HTML_Select("Sélectionnez dans la liste (plusieurs choix possibles)"; "Assurance"; ->$TabId; ->$TabLib; Null:C1517; "multiselect"; ParamSelect)
$assurance_base:=Replace string:C233($assurance_base; "$selectAss$"; $SelectAss)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$hideIfNew$"; $hideIfNew)
$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $contenu_base)
$Contenu:=Replace string:C233($Contenu; "$assurance_base$"; $assurance_base)
$Contenu:=Replace string:C233($Contenu; "$activite_marine$"; $activite_marine)
$Contenu:=Replace string:C233($Contenu; "$selectFiscal$"; $SelectFiscal)
$Contenu:=Replace string:C233($Contenu; "$SelectAyantDroits$"; $SelectAyantDroits)
$Contenu:=Replace string:C233($Contenu; "$SelectEnfants$"; $SelectEnfants)
$Contenu:=Replace string:C233($Contenu; "$SelectTutelles$"; $SelectTutelles)
$Contenu:=Replace string:C233($Contenu; "$SelectTuteurs$"; $SelectTuteurs)
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$Type$"; $type)
$Contenu:=Replace string:C233($Contenu; "$autre$"; $autre)
$Contenu:=Replace string:C233($Contenu; "$UUID$"; $uuid)
WEB SEND TEXT:C677($Contenu; "text/html")
