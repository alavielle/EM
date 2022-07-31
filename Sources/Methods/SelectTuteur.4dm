//%attributes = {}
//SelectTuteur

$tuteurs:=ds:C1482.EtatCivil.query("Type='TUTEUR'")

C_COLLECTION:C1488($myCol)
C_OBJECT:C1216($ParamSelect)
OB SET:C1220($ParamSelect; "Required"; "Faux")
OB SET:C1220($ParamSelect; "LigneVide"; "Vrai")
OB SET:C1220($ParamSelect; "LigneChoisir"; " ")
OB SET:C1220($ParamSelect; "Disabled"; "Faux")
OB SET:C1220($ParamSelect; "Hidden"; "Faux")
OB SET:C1220($ParamSelect; "Multiple"; "Faux")
ARRAY LONGINT:C221($tabIdEC; 0)
ARRAY TEXT:C222($tabLibEC; 0)
For each ($tuteur; $tuteurs)
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $tuteur.ID)[0]
	APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
	APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
End for each 
$myCol:=New collection:C1472
ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
$myCol:=$myCol.orderBy("NomPrenom")
$SelectTuteur:=HTML_Select_Collection("Tuteur"; "ID_Tuteur"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; ""; $ParamSelect)

$0:=$SelectTuteur
