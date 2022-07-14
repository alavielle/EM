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
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="assurance_base")
$assurance_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="activite_marine")
$contenu_activite:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

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

ALL RECORDS:C47([SecteurMarine:35])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([SecteurMarine:35]ID:1; $TabId; [SecteurMarine:35]Secteur:2; $TabLib)
C_OBJECT:C1216(ParamSelect)
OB SET:C1220(ParamSelect; "Required"; "Faux")
OB SET:C1220(ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220(ParamSelect; "LigneChoisir"; "")
OB SET:C1220(ParamSelect; "Disabled"; "Faux")
OB SET:C1220(ParamSelect; "Hidden"; "Faux")
OB SET:C1220(ParamSelect; "Multiple"; "Faux")
$SelectSecteur:=HTML_Select("Sélectionnez dans la liste"; "ID_SecteurMarine"; ->$TabId; ->$TabLib; Null:C1517; ""; ParamSelect)
$contenu_activite:=Replace string:C233($contenu_activite; "$SelectSecteur$"; $SelectSecteur)

ALL RECORDS:C47([Grade:6])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([Grade:6]ID:1; $TabId; [Grade:6]GradeRessortissant:2; $TabLib)
C_OBJECT:C1216(ParamSelect)
OB SET:C1220(ParamSelect; "Required"; "Faux")
OB SET:C1220(ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220(ParamSelect; "LigneChoisir"; "")
OB SET:C1220(ParamSelect; "Disabled"; "Faux")
OB SET:C1220(ParamSelect; "Hidden"; "Faux")
OB SET:C1220(ParamSelect; "Multiple"; "Faux")
$SelectGrade:=HTML_Select("Dernier Grade"; "ID_Grade"; ->$TabId; ->$TabLib; Null:C1517; ""; ParamSelect)
$contenu_activite:=Replace string:C233($contenu_activite; "$SelectGrade$"; $SelectGrade)

$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $contenu_base)
$Contenu:=Replace string:C233($Contenu; "$assurance_base$"; $assurance_base)
$Contenu:=Replace string:C233($Contenu; "$activite_marine$"; $contenu_activite)
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$UUID_boursier$"; $uuid)
$Contenu:=Replace string:C233($Contenu; "$BourseID$"; $BourseID)

WEB SEND TEXT:C677($Contenu; "text/html")
