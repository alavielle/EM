//%attributes = {}
// FoyerFiscalCreate
// $1 : codeFiscal
// $2 : ID_ASA
// $3 : ID_ASEM

READ WRITE:C146([FoyerFiscal:3])
var $foyerFiscal : cs:C1710.FoyerFiscalEntity

$foyerFiscal:=ds:C1482.FoyerFiscal.new()
$foyerFiscal.CodeFiscal:=$1
$foyerFiscal.ID_ASA:=$2
$foyerFiscal.ID_ASEM:=$3
$foyerFiscal.save()

$0:=$foyerFiscal.ID

READ ONLY:C145([FoyerFiscal:3])
