//%attributes = {}
//InitMail
// $1 : Id

C_TEXT:C284($return)
$mail:=ds:C1482.ModelesMail.query("Type = :1"; $1)
If ($mail.length>0)
	$return:=JSON Stringify:C1217($mail[0].toObject())
End if 
ReturnSomething($return)