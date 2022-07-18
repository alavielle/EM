//%attributes = {}
//FindAutresFoyers
// $1 : UUID

C_TEXT:C284($1)
C_TEXT:C284($Composant)
$Composant:=""
If ($1#"")
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	$Prefixe:=Split string:C1554($etatcivil.CodeDossier; "-")
	C_OBJECT:C1216(ParamSelect)
	OB SET:C1220(ParamSelect; "Required"; "Faux")
	OB SET:C1220(ParamSelect; "LigneVide"; "Vrai")
	OB SET:C1220(ParamSelect; "LigneChoisir"; "Faux")
	OB SET:C1220(ParamSelect; "Disabled"; "Faux")
	OB SET:C1220(ParamSelect; "Hidden"; "Faux")
	OB SET:C1220(ParamSelect; "Multiple"; "Faux")
	$autresFoyers:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1 & CodeFiscal # :2 "; $Prefixe[0]+"-@"; $Prefixe[0]+"-0")
	$Composant:=HTML_Select_Collection("Foyer Fiscal"; "ID_CodeFiscal"; $autresFoyers.ID; $autresFoyers.CodeFiscal; Null:C1517; ""; ParamSelect)
End if 
$0:=$composant


