//%attributes = {}
//HTML_ListGroup
//$1 : Nom de l'étiquette
//$2 : Nom du popup
//$3 : ->Tableau texte

C_TEXT:C284($Contenu; $0; $1; $2)
C_POINTER:C301($3)

If ($1#"")
	$Contenu:=$Contenu+"<label for="+Char:C90(34)+$1+Char:C90(34)+"id="+Char:C90(34)+$2+Char:C90(34)+"class="+Char:C90(34)+"form-label"+Char:C90(34)+">$Title$</label>"
	$Contenu:=Replace string:C233($Contenu; "$Title$"; $1)
End if 


$Contenu:=$Contenu+"<ul class="+Char:C90(34)+"list-group"+Char:C90(34)+">"
For ($i; 1; Size of array:C274($3->))
	$Contenu:=$Contenu+"<li class="+Char:C90(34)+"list-group-item"+Char:C90(34)+"><a href="+Char:C90(34)+"/Enfant/"+String:C10($3->{$i}.UUID)+Char:C90(34)+">"+String:C10($3->{$i}.NomPrenom)+"</a></li>"
End for 

$Contenu:=$Contenu+"</ul>"
$0:=$Contenu