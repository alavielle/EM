//%attributes = {}
//DecompositionFoyerFiscal


var $foyer : cs:C1710.FoyerFiscalEntity
ARRAY OBJECT:C1221($tabObj; 0)
$etatcivil1:=ds:C1482.EtatCivil.query("Decede = :1 & Type = :2"; True:C214; "RESSORTISSANT")
For each ($etat; $etatcivil1)
	$conjoints:=ds:C1482.EtatCivil.query("Type = :1 && ID_Ressortissant = :2"; "CONJOINT"; $etat.ID)
	If ($conjoints.length>1)
		For each ($conjoint; $conjoints)
			$code:=$conjoint.foyerFiscal.CodeFiscal
			APPEND TO ARRAY:C911($tabObj; New object:C1471("ID_Ressortissant"; $conjoint.ID_Ressortissant; "ID_conjoint"; $conjoint.ID_Conjoint; "Code"; $code))
		End for each 
	End if 
End for each 