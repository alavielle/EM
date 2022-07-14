//%attributes = {}
//AttribuerCodeFiscal
//$1 : CodeDossier

C_TEXT:C284($1)
C_LONGINT:C283($0)

$foyerFiscal:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $1+"@")
$autresFoyers:=ds:C1482.FoyerFiscal.query("CodeFiscal = :1"; $1+"@").distinct("CodeFiscal")
If ($foyerFiscal.length>0)
	$last:=$autresFoyers[$autresFoyers.length-1]
	$TabLast:=Split string:C1554($last; "-")
	If ($TabLast.length>1)
		$increment:=Num:C11($TabLast[1])+1
	Else 
		$increment:=1
	End if 
	C_OBJECT:C1216($entity)
	$entity:=ds:C1482.FoyerFiscal.new()
	$entity.ID_ASA:=$foyerFiscal[0].ID_ASA
	$entity.ID_ASEM:=$foyerFiscal[0].ID_ASEM
	$entity.CodeFiscal:=$1+"-"+String:C10($increment)
	$entity.save()
	$0:=$entity.ID
End if 

