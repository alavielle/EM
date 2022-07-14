//%attributes = {}
// HTML_Select_Only
//$1 : Classe supplementaire
//$2 : Nom du popup
//$3 : ->tableau texte des id 
//$4 : ->tableau texte des valeurs 

C_TEXT:C284($Contenu; $0; $1; $2)
C_POINTER:C301($3; $4)

$Contenu:="<select name="+Char:C90(34)+$2+Char:C90(34)+"class="+Char:C90(34)+"form-select "+$1+Char:C90(34)+" required>"
$Contenu:=$Contenu+"<option selected disabled>Choisir</option>"

For ($i; 1; Size of array:C274($3->))
	$optionid:=String:C10($3->{$i})
	$optionname:=$4->{$i}
	$OptionLine:="<option value="+Char:C90(34)+$optionid+Char:C90(34)+">"+$optionid+" - "+$optionname+"</option>"
	$Contenu:=$Contenu+$OptionLine
End for 

$Contenu:=$Contenu+"</select>"
$0:=$Contenu