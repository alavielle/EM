//%attributes = {}
// CalculNvSeuils
// $1 : Index

WEB GET HTTP HEADER:C697($names; $values)
$pos:=Find in array:C230($names; "X-METHOD")
C_REAL:C285($nvSeuil)
$nvSeuil:=Num:C11($1)

If ($pos>0)
	Case of 
		: ($values{$pos}="PUT")
			$seuil:=ds:C1482.Seuil.all().first()
			$seuil.Seuil:=$nvSeuil
			$seuil.Date_MAJ:=Current date:C33()
			$seuil.save()
	End case 
End if 

$paliers:=ds:C1482.Palier.all()
For each ($palier; $paliers)
	$palier.Seuil:=$nvSeuil+($nvSeuil*$palier.Indice)
	$palier.save()
End for each 

ReturnSomething("OK")