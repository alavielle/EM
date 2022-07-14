//%attributes = {}
//GetClasses
//$1 :  id niveau d'études

C_LONGINT:C283($1)
If ($1>0)
	ALL RECORDS:C47([Classe:8])
	QUERY:C277([Classe:8]; [Classe:8]ID_NiveauEtude:2=$1)
	ORDER BY:C49([Classe:8]; [Classe:8]ID:1; >)
	ARRAY LONGINT:C221($TabId; 0)
	ARRAY TEXT:C222($TabLib; 0)
	SELECTION TO ARRAY:C260([Classe:8]ID:1; $TabId; [Classe:8]Classe:3; $TabLib)
	C_OBJECT:C1216(ParamSelect)
	OB SET:C1220(ParamSelect; "Required"; "Faux")
	OB SET:C1220(ParamSelect; "LigneVide"; "Vrai")
	OB SET:C1220(ParamSelect; "LigneChoisir"; "Choisir")
	OB SET:C1220(ParamSelect; "Disabled"; "Faux")
	OB SET:C1220(ParamSelect; "Hidden"; "Faux")
	OB SET:C1220(ParamSelect; "Multiple"; "Faux")
	C_TEXT:C284($Select)
	$Select:=HTML_Select("Classe"; "Classe"; ->$TabId; ->$TabLib; Null:C1517; ""; ParamSelect)
	ReturnSomething($select)
End if 