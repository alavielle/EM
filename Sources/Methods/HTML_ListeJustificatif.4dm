//%attributes = {}
// HTML_ListeJustificatif

C_TEXT:C284($contenu)
C_OBJECT:C1216($autreJustif)

For ($i; 1; Records in selection:C76([Document:28]))
	$contenu:=$contenu+"<div class=\"row my-3\">"
	$contenu:=$contenu+"<div class=\"col-md-6\">"
	$contenu:=$contenu+"<label for=\"\" class=\"form-label\\ id=\""+String:C10([Document:28]ID:1)+"\">"+[Document:28]Document:2+"</label>"
	$autreJustif:=ds:C1482.AutreRessource.query("ID_Document = :1"; [Document:28]ID:1)
	If ($autreJustif.length>0)
		$contenu:=$contenu+"<ul>"
		For each ($autre; $autreJustif)
			$contenu:=$contenu+"<li>"+$autre.Libelle+"</li>"
		End for each 
		$contenu:=$contenu+"</ul>"
	End if 
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"<div class=\"col-md-6\">"
	$contenu:=$contenu+"<input type=\"file\" name=\""+String:C10([Document:28]ID:1)+"\" class=\"form-control text-end\" multiple >"
	$contenu:=$contenu+"</div>"
	$contenu:=$contenu+"</div>"
	NEXT RECORD:C51([Document:28])
End for 

$0:=$contenu