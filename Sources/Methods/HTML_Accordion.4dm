//%attributes = {}
// HTML_Accordion
//$1 : Nom de l'étiquette
//$2 : Nom du libellé si non null, sinon, nome et prénom
//$3 : ->Tableau texte

C_TEXT:C284($Contenu; $0; $1; $2)
C_POINTER:C301($3)

If ($1#"")
	$Contenu:=$Contenu+"<label for="+Char:C90(34)+$1+Char:C90(34)+"id="+Char:C90(34)+$2+Char:C90(34)+"class="+Char:C90(34)+"form-label"+Char:C90(34)+">$Title$</label>"
End if 
$Contenu:=Replace string:C233($Contenu; "$Title$"; $1)

$Contenu:=$Contenu+"<div class="+Char:C90(34)+"accordion"+Char:C90(34)+"id="+Char:C90(34)+"accordionExample"+Char:C90(34)+">"

For ($i; 1; Size of array:C274($3->))
	$Contenu:=$Contenu+"<div class="+Char:C90(34)+"accordion-item"+Char:C90(34)+">"
	$Contenu:=$Contenu+"<h2 class="+Char:C90(34)+"accordion-header"+Char:C90(34)+"id="+Char:C90(34)+"heading"+String:C10($i)+Char:C90(34)+">"
	//$Contenu:=$Contenu+"<button class="+Caractère(34)+"accordion-button"+Caractère(34)+"Type="+Caractère(34)+"button"+Caractère(34)+"data-bs-toggle="+Caractère(34)+"collapse"+Caractère(34)+"data-bs-target="+Caractère(34)+"#collapse"+Chaîne($i)+Caractère(34)+"aria-expanded="+Caractère(34)+"true"+Caractère(34)+"aria-controls="+Caractère(34)+"collapse"+Chaîne($i)+Caractère(34)+">"
	$Contenu:=$Contenu+"<button class="+Char:C90(34)+"accordion-button"+Char:C90(34)+"Type="+Char:C90(34)+"button"+Char:C90(34)+"aria-expanded="+Char:C90(34)+"true"+Char:C90(34)+"aria-controls="+Char:C90(34)+"collapse"+String:C10($i)+Char:C90(34)+">"
	If ($2="Libelle")
		$Contenu:=$Contenu+String:C10($3->{$i}.Libelle)
	Else 
		$Contenu:=$Contenu+"<a href="+Char:C90(34)+"/Conjoint/"+String:C10($3->{$i}.UUID)+Char:C90(34)+">"+String:C10($3->{$i}.NomPrenom)+"</a>"
	End if 
	$Contenu:=$Contenu+"</button>"
	$Contenu:=$Contenu+"</h2>"
	$Contenu:=$Contenu+"<div id="+Char:C90(34)+"collapse"+String:C10($i)+Char:C90(34)+"class="+Char:C90(34)+"accordion-collapse collapse show"+Char:C90(34)+"aria-labelledby="+Char:C90(34)+"heading"+String:C10($i)+Char:C90(34)+">"
	$Contenu:=$Contenu+"<div class="+Char:C90(34)+"accordion-body ms-5"+Char:C90(34)+">"
	$Contenu:=$Contenu+"<ul class="+Char:C90(34)+"list-group list-group-flush"+Char:C90(34)+">"
	For ($j; 0; $3->{$i}.Enfant.length-1)
		$Contenu:=$Contenu+"<li class="+Char:C90(34)+"list-group-item"+Char:C90(34)+"><a href="+Char:C90(34)+"/Enfant/"+String:C10($3->{$i}.Enfant[$j].UUID)+Char:C90(34)+">"+String:C10($3->{$i}.Enfant[$j].NomPrenom)+"</a></li>"
	End for 
	$Contenu:=$Contenu+"</ul>"
	$Contenu:=$Contenu+"</div>"
	$Contenu:=$Contenu+"</div>"
	$Contenu:=$Contenu+"</div>"
End for 

$Contenu:=$Contenu+"</div>"

$0:=$Contenu
