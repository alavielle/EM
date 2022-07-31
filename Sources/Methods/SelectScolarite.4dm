//%attributes = {}
//SelectScolarite
//$1 : ID_Classe
//$2 : ID_NiveauEtude
C_LONGINT:C283($1; $2)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="scolarite_base")
$scolarite_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$scolarite_base:=Replace string:C233($scolarite_base; "$AnneeSco$"; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].AnneeSco)

$montantPart:=ds:C1482.MontantPart.all().orderBy("ID")
C_TEXT:C284($Select)
C_OBJECT:C1216($SelectProperties)
OB SET:C1220($SelectProperties; "onchange"; "Oui")
OB SET:C1220($SelectProperties; "onchangemethod"; "popNeSelected")
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220($ParamSelect; "LigneChoisir"; "Choisir")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Faux")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
$SelectNe:=HTML_Select_Collection("Niveau d'études *"; "ID_NiveauEtude"; $montantPart.extract("ID"); $montantPart.extract("NiveauEtude"); $SelectProperties; ""; $ParamSelect)
$scolarite_base:=Replace string:C233($scolarite_base; "$selectNe$"; $SelectNe)

OB SET:C1220($ParamSelect; "LigneChoisir"; "")
If ($1>0)
	$classes:=$montantPart.query("ID =:1"; $2)[0].classes
	$selectClasse:=HTML_Select_Collection("Classe *"; "ID_Classe"; $classes.extract("ID"); $classes.extract("Classe"); Null:C1517; ""; $ParamSelect)
Else 
	C_COLLECTION:C1488($myCol)
	$myCol:=New collection:C1472
	$selectClasse:=HTML_Select_Collection("Classe *"; "ID_Classe"; $myCol; $myCol; Null:C1517; ""; $ParamSelect)
End if 
$scolarite_base:=Replace string:C233($scolarite_base; "$selectClasse$"; $SelectClasse)

$0:=$scolarite_base