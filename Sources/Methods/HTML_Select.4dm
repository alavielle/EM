//%attributes = {}
// HTML_Select
//$1 : Nom de l'étiquette
//$2 : Nom du popup
//$3 : ->tableau texte des id 
//$4 : ->tableau texte des valeurs 
//$5 : méthode objet
//$6 : classe supplémentaire
//$7 : objet
//$8 : ->tableau texte codeDossier (optionnel)

C_TEXT:C284($Contenu; $0; $1; $2; $6)
C_POINTER:C301($3; $4; $8)
C_OBJECT:C1216($5; $7)
$HasOnchange:=OB Get:C1224($5; "onchange"; Est un texte:K8:3)

If (Count parameters:C259>6)
	$Required:=OB Get:C1224($7; "Required"; Est un texte:K8:3)
	$LigneVide:=OB Get:C1224($7; "LigneVide"; Est un texte:K8:3)
	$LigneChoisir:=OB Get:C1224($7; "LigneChoisir"; Est un texte:K8:3)
	$Disabled:=OB Get:C1224($7; "Disabled"; Est un texte:K8:3)
	$Hidden:=OB Get:C1224($7; "Hidden"; Est un texte:K8:3)
	$Mulitple:=OB Get:C1224($7; "Multiple"; Est un texte:K8:3)
Else 
	$Required:="Faux"
	$LigneVide:="Faux"
	$LigneChoisir:="Faux"
	$Disabled:="Faux"
	$Hidden:="Faux"
	$Mulitple:="Faux"
End if 

$Contenu:="<div class="+Char:C90(34)+"mb-3"+Char:C90(34)+" data-group="+Char:C90(34)+$2+Char:C90(34)
If ($Hidden="Vrai")
	$Contenu:=$Contenu+" hidden"
End if 
$Contenu:=$Contenu+">"

If ($1#"")
	$Contenu:=$Contenu+"<label for="+Char:C90(34)+$1+Char:C90(34)+"id="+Char:C90(34)+$2+Char:C90(34)+"class="+Char:C90(34)+"form-label"+Char:C90(34)+">$Title$</label>"
End if 

$Contenu:=Replace string:C233($Contenu; "$Title$"; $1)
$Contenu:=$Contenu+"<select name="+Char:C90(34)+$2+Char:C90(34)+"class="+Char:C90(34)+"form-select "+$6+Char:C90(34)

If ($HasOnchange="Oui")
	$HasOnchangeMethod:=OB Get:C1224($5; "onchangemethod"; Est un texte:K8:3)
	$Contenu:=$Contenu+" onchange="+Char:C90(34)+$HasOnchangeMethod+"(this.name)"+Char:C90(34)
End if 

If ($Required="Vrai")
	$Contenu:=$Contenu+" required"
End if 

If ($Disabled="Vrai")
	$Contenu:=$Contenu+" disabled"
End if 

If ($Hidden="Vrai")
	$Contenu:=$Contenu+" hidden"
End if 

If ($Mulitple="Vrai")
	$Contenu:=$Contenu+" multiple"
End if 

$Contenu:=$Contenu+">"
If ($LigneChoisir#"Faux")
	$Contenu:=$Contenu+"<option disabled selected>"+$LigneChoisir+"</option>"
End if 


For ($i; 1; Size of array:C274($3->))
	$optionid:=String:C10($3->{$i})
	$optionname:=$4->{$i}
	If (Count parameters:C259=8)
		If ($8#Null:C1517)
			$optionname:=$optionname+" - "+$8->{$i}
		End if 
	End if 
	$OptionLine:="<option value="+Char:C90(34)+$optionid+Char:C90(34)+">"+$optionname+"</option>"
	$Contenu:=$Contenu+$OptionLine
End for 

If ($LigneVide="Vrai")
	$Contenu:=$Contenu+"<option>"+"</option>"
End if 

$Contenu:=$Contenu+"</select></div>"
$0:=$Contenu
