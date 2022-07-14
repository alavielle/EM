//%attributes = {}
//HTML_Input
//$1 : Nom de l'étiquette
//$2 : Nom de l'input
//$3 : valeur num
//$4 : méthode objet

C_TEXT:C284($Contenu; $0; $1; $2)
C_REAL:C285($3)
C_OBJECT:C1216($4)

$Contenu:="<div class="+Char:C90(34)+"row mt-1"+Char:C90(34)+">"
$Contenu:=$Contenu+"<div class="+Char:C90(34)+"col-lg-4 col-md-6 col-sm-8"+Char:C90(34)+">"

If ($1#"")
	$Contenu:=$Contenu+"<div class="+Char:C90(34)+"input-group"+Char:C90(34)+">"
	$Contenu:=$Contenu+"<span class="+Char:C90(34)+"input-group-text"+Char:C90(34)+">$Title$</span>"
	$Contenu:=Replace string:C233($Contenu; "$Title$"; $1)
End if 

$Contenu:=$Contenu+"<input type="+Char:C90(34)+"number"+Char:C90(34)+" class="+Char:C90(34)+"form-control text-center"+Char:C90(34)+" name="+Char:C90(34)+$2+Char:C90(34)+" value="+Char:C90(34)+String:C10($3)+Char:C90(34)+">"

If ($4#Null:C1517)
	$Method:=OB Get:C1224($4; "method"; Est un texte:K8:3)
	$OnMethod:=OB Get:C1224($4; "onmethod"; Est un texte:K8:3)
	$ButtonName:=OB Get:C1224($4; "buttonname"; Est un texte:K8:3)
	$Contenu:=$Contenu+"<button class="+Char:C90(34)+"btn btn-bm"+Char:C90(34)+" Type="+Char:C90(34)+"button"+Char:C90(34)+" name="+Char:C90(34)+$2+Char:C90(34)+" id="+Char:C90(34)+$2+Char:C90(34)
	If ($Method#"")
		$Contenu:=$Contenu+" "+$Method+"="+Char:C90(34)+$OnMethod+"(this.name)"+Char:C90(34)
	End if 
	$Contenu:=$Contenu+">"+$ButtonName+"</button>"
End if 

$Contenu:=$Contenu+"</div>"
$Contenu:=$Contenu+"</div>"
$Contenu:=$Contenu+"</div>"
$0:=$Contenu