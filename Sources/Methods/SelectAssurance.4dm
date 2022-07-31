//%attributes = {}
//SelectAssurance

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="assurance_base")
$assurance_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

ALL RECORDS:C47([Assurance:22])
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([Assurance:22]ID:1; $TabId; [Assurance:22]Assurance:2; $TabLib)
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
OB SET:C1220($ParamSelect; "LigneChoisir"; "Faux")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Faux")
OB SET:C1220($ParamSelect; "Multiple"; "Vrai")
$SelectAss:=HTML_Select("Sélectionnez dans la liste (plusieurs choix possibles)"; "ID_Assurance"; ->$TabId; ->$TabLib; Null:C1517; "multiselect"; $ParamSelect)
$assurance_base:=Replace string:C233($assurance_base; "$selectAss$"; $SelectAss)

$0:=$assurance_base