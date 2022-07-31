//%attributes = {}
// FindEmail
// $1 : email

C_TEXT:C284($1)
C_OBJECT:C1216($objEC)
C_TEXT:C284($Composant)
$Composant:=""
If ($1#"")
	QUERY:C277([WebUser:2]; [WebUser:2]Email:2=$1)
	If (Records in selection:C76([WebUser:2])=1)
		$Composant:="<div class="+Char:C90(34)+"alert alert-danger text-center my-3"+Char:C90(34)+">"
		$Composant:=$Composant+"Un compte web existe déjà avec cette adresse mail</div>"
	Else 
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("Email = :1"; $1)
		Case of 
			: ($SharedEC.length>1)
				C_TEXT:C284($Composant)
				C_OBJECT:C1216($ComposantProperties)
				OB SET:C1220($ComposantProperties; "onchange"; "Oui")
				OB SET:C1220($ComposantProperties; "onchangemethod"; "popVnomprenomSelected")
				C_OBJECT:C1216($ParamSelect)
				OB SET:C1220($ParamSelect; "Required"; "Faux")
				OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
				OB SET:C1220($ParamSelect; "LigneChoisir"; "L'état civil")
				OB SET:C1220($ParamSelect; "Disabled"; "Faux")
				OB SET:C1220($ParamSelect; "Hidden"; "Faux")
				OB SET:C1220($ParamSelect; "Multiple"; "Faux")
				C_COLLECTION:C1488($nomPrenom)
				$nomPrenom:=New collection:C1472()
				For each ($c; $SharedEC)
					$nomPrenom.push($c.Nom+" "+$c.Prenom)
				End for each 
				$Composant:=HTML_Select_Collection("Choisir dans la liste"; "vnomprenom"; $SharedEC.extract("ID"); $nomPrenom; $ComposantProperties; ""; $ParamSelect; $SharedEC.extract("Type"))
			: ($SharedEC.length=1)
				OB SET:C1220($objEC; "Nom"; $SharedEC[0].Nom)
				OB SET:C1220($objEC; "Prenom"; $SharedEC[0].Prenom)
				OB SET:C1220($objEC; "Type"; $SharedEC[0].Type)
				$Composant:=JSON Stringify:C1217($objEC)
		End case 
	End if 
End if 
ReturnSomething($composant)