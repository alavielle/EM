//%attributes = {}
// ReturnSomething

C_TEXT:C284(TextEmp; $1)
TextEmp:=$1

C_TEXT:C284($Cookie)

$Cookie:="Access-Control-Allow-Headers: Access-Control-Allow-Origin"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

$Cookie:="Access-Control-Allow-Headers: X-Requested-With, X-Prototype-Version, Content-Disposition, Cache-Control, Content-Type"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

$Cookie:="Access-Control-Allow-Origin: *"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

$Cookie:="X-STATUS:200 OK"
WEB SET HTTP HEADER:C660($Cookie)

If (Count parameters:C259>1)  //Il y a un code de retour http à envoyer
	Case of 
		: (($2="403") | ($2="404"))
			$Cookie:="X-STATUS: "+$2
			WEB SET HTTP HEADER:C660($Cookie)
			C_BLOB:C604($BlobCalTxt)
			TEXT TO BLOB:C554(TextEmp; $BlobCalTxt; UTF8 texte sans longueur:K22:17)
			WEB SEND BLOB:C654($BlobCalTxt; "application/json")
	End case 
End if 

C_BLOB:C604($BlobCalTxt)
TEXT TO BLOB:C554(TextEmp; $BlobCalTxt; UTF8 texte sans longueur:K22:17)
WEB SEND BLOB:C654($BlobCalTxt; "application/json")

