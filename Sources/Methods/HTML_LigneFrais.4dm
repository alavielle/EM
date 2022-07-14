//%attributes = {}
// HTML_LigneFrais

ALL RECORDS:C47([LigneFrais:30])
C_TEXT:C284($contenu)


For ($i; 1; Records in selection:C76([LigneFrais:30]))
	$contenu:=$contenu+"<div class=\"row mt-2\">"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<label class=\"form-label\">"+[LigneFrais:30]Libelle:3+"</label>"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-2\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"Frais"+String:C10([LigneFrais:30]NumeroLigne:2; "00")+"\" class=\"form-control text-end\" data-type=\"currency\" onchange=\"totalSaisie(this.name)\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
	NEXT RECORD:C51([LigneFrais:30])
End for 

$0:=$contenu