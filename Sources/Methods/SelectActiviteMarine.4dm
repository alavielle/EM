//%attributes = {}
//SelectAcitiviteMarine


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="activite_marine")
$contenu_activite:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

ALL RECORDS:C47([SecteurMarine:35])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([SecteurMarine:35]ID:1; $TabId; [SecteurMarine:35]Secteur:2; $TabLib)
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220($ParamSelect; "LigneChoisir"; "")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Faux")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$SelectSecteur:=HTML_Select("Sélectionnez dans la liste"; "ID_SecteurMarine"; ->$TabId; ->$TabLib; Null:C1517; ""; $ParamSelect)
$contenu_activite:=Replace string:C233($contenu_activite; "$SelectSecteur$"; $SelectSecteur)

ALL RECORDS:C47([Grade:6])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([Grade:6]ID:1; $TabId; [Grade:6]GradeRessortissant:2; $TabLib)
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220($ParamSelect; "LigneChoisir"; "")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Faux")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$SelectGrade:=HTML_Select("Dernier Grade"; "ID_Grade"; ->$TabId; ->$TabLib; Null:C1517; ""; $ParamSelect)
$contenu_activite:=Replace string:C233($contenu_activite; "$SelectGrade$"; $SelectGrade)

$0:=$contenu_activite