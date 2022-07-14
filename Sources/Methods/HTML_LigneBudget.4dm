//%attributes = {}
// HTML_LigneBudget

$budget:=ds:C1482.LigneBudget.all()
$bugetcol1:=$budget.query("VieCourante = :1"; True:C214)
$bugetcol2:=$budget.query("Logement = :1"; True:C214)
$bugetcol3:=$budget.query("Ressource = :1"; True:C214)
C_TEXT:C284($contenu)

$contenu:=$contenu+"<div class=\"row mt-2\">"

$contenu:=$contenu+"<div class=\"col-md-4\">"
$contenu:=$contenu+"<div class=\"mt-2 fst-italic text-center\">Vie courante</div>"
For each ($b; $bugetcol1)
	$contenu:=$contenu+"<div class=\"row mt-2\">"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<label class=\"form-label\">"+$b.Libelle+"</label>"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"Budget"+String:C10($b.NumeroLigne; "00")+"\" class=\"form-control text-end\" data-type=\"currency\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
End for each 
$contenu:=$contenu+"</div>"

$contenu:=$contenu+"<div class=\"col-md-4\">"
$contenu:=$contenu+"<div class=\"mt-2 fst-italic text-center\">Logement et assurances</div>"
For each ($b; $bugetcol2)
	$contenu:=$contenu+"<div class=\"row mt-2\">"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<label class=\"form-label\">"+$b.Libelle+"</label>"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"Budget"+String:C10($b.NumeroLigne; "00")+"\" class=\"form-control text-end\" data-type=\"currency\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
End for each 
$contenu:=$contenu+"</div>"

$contenu:=$contenu+"<div class=\"col-md-4\">"
$contenu:=$contenu+"<div class=\"mt-2 fst-italic text-center\">Ressources</div>"
For each ($b; $bugetcol3)
	$contenu:=$contenu+"<div class=\"row mt-2\">"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<label class=\"form-label\">"+$b.Libelle+"</label>"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-6\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"Budget"+String:C10($b.NumeroLigne; "00")+"\" class=\"form-control text-end\" data-type=\"currency\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
End for each 
$contenu:=$contenu+"</div>"

$contenu:=$contenu+"</div>"
$0:=$contenu