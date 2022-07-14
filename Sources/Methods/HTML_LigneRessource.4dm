//%attributes = {}
// HTML_LigneRessource

ALL RECORDS:C47([LigneRessource:23])
C_TEXT:C284($contenu)
C_OBJECT:C1216($autreRessource)


For ($i; 1; Records in selection:C76([LigneRessource:23]))
	$contenu:=$contenu+"<div class=\"row mt-2 $marge$\">"
	$contenu:=$contenu+"<div class=\"col-4\">"
	$contenu:=$contenu+"<label class=\"form-label\">"+[LigneRessource:23]Libelle:3+"</label>"
	$autreRessource:=ds:C1482.AutreRessource.query("ID_Ligne = :1"; [LigneRessource:23]NumeroLigne:2)
	If ($autreRessource.length>0)
		$Contenu:=Replace string:C233($Contenu; "$marge$"; "align-items-end")
		For each ($autre; $autreRessource)
			$contenu:=$contenu+"<div class=\"form-check m-0\">"
			$contenu:=$contenu+"<label class=\"form-check-label\" >"+$autre.Libelle+"</label>"
			$contenu:=$contenu+"<input class="+Char:C90(34)+$autre.ClassForm+Char:C90(34)+" type="+Char:C90(34)+$autre.Type+Char:C90(34)+">"
			$contenu:=$contenu+"</div>"
		End for each 
	Else 
		$Contenu:=Replace string:C233($Contenu; "$marge$"; "")
	End if 
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-2\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"A"+String:C10([LigneRessource:23]NumeroLigne:2; "00")+"\" class=\"form-control text-end\" data-type=\"currency\" onchange=\"totalSaisie(this.name)\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-2\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"B"+String:C10([LigneRessource:23]NumeroLigne:2; "00")+"\" class=\"form-control text-end\" data-type=\"currency\" onchange=\"totalSaisie(this.name)\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-2\">"
	$contenu:=$contenu+"<input type=\"number\" name=\"C"+String:C10([LigneRessource:23]NumeroLigne:2; "00")+"\" class=\"form-control text-end\" data-type=\"currency\" onchange=\"totalSaisie(this.name)\">"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-2\">"
	$contenu:=$contenu+"<input type=\"text\" name=\"T"+String:C10([LigneRessource:23]NumeroLigne:2; "00")+"\" class=\"form-control text-end\" data-type=\"currency\" disabled>"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
	NEXT RECORD:C51([LigneRessource:23])
End for 

$0:=$contenu