//%attributes = {}
// Méthode projet Get_HTTP_Field
// GetHTTPField ( Texte ) -> Texte
// GetHTTPField ( Nom en-tête HTTP ) -> Contenu en-tête HTTP
C_TEXT:C284($0; $1)
C_LONGINT:C283($vlElem)
ARRAY TEXT:C222($noms; 0)
ARRAY TEXT:C222($valeurs; 0)
$0:=""
WEB GET HTTP HEADER:C697($noms; $valeurs)
$vlElem:=Find in array:C230($noms; $1)
If ($vlElem>0)
	$0:=$valeurs{$vlElem}
End if 