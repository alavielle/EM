//%attributes = {}
// HTML_Trouble
//$1 : message


C_TEXT:C284($Contenu; $0; $1)

If ($1#"")
	$Contenu:="<div class="+Char:C90(34)+"alert alert-warning text-center my-3"+Char:C90(34)+">"+$1+"</div>"
End if 

$0:=$Contenu