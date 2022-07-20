//%attributes = {}
//NewCodeFiscal
//$1 : CodeDossier
//$2 : Décédé

C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($0)
C_OBJECT:C1216($entity)

$foyerFiscal:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $1+"@")
$autresFoyers:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $1+"@").distinct("CodeFiscal")

$entity:=ds:C1482.FoyerFiscal.new()
If ($foyerFiscal.length>0)
	$last:=$autresFoyers[$autresFoyers.length-1]
	$TabLast:=Split string:C1554($last; "-")
	$increment:=Num:C11($TabLast[$TabLast.length-1])+1
	$entity.ID_ASA:=$foye]rFiscal[0].ID_ASA
	$entity.ID_ASEM:=$foyerFiscal[0].ID_ASEM
	$entity.CodeFiscal:=$1+"-"+String:C10($increment)
Else 
	If ($2=True:C214)
		$entity.CodeFiscal:=$1+"-0"
	Else 
		$entity.CodeFiscal:=$1+"-1"
	End if 
End if 
$entity.save()
$0:=$entity.ID