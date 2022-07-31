//%attributes = {}
// SendMail
// $1 : Emetteur
// $2 : Sujet
// $3 : Corps
// $4 : Destinataire
// $5 : Prenom Nom

C_TEXT:C284($1)

$erreur:=0

$destinataire:=New object:C1471
$destinataire.email:=$4
$destinataire.name:=$5
$destinataire.type:="to"
$colDestinataire:=New collection:C1472($destinataire)

$mail:=New object:C1471
$mail.from_email:="contact@ifcv.fr"  //$1
$mail.to:=$colDestinataire
$mail.autotext:="true"
$mail.subject:=$2
$mail.html:=Replace string:C233($3; Char:C90(Guillemets:K15:41); Char:C90(Apostrophe:K15:44))

$mandrill:=New object:C1471
$mandrill.key:="8JPBjTnl5KR4LBYu7_Qvbw"
$mandrill.message:=$mail

$toPost:=JSON Stringify:C1217($mandrill)
C_TEXT:C284($reponse)
$erreur:=HTTP Request:C1158(HTTP méthode POST:K71:2; "https://mandrillapp.com/api/1.0/messages/send"; $toPost; $reponse)

$0:=$erreur
//{
//"key" : "8JPBjTnl5KR4LBYu7_Qvbw", 
//"message" : {
//"from_email" : "toto@ifcv.fr", 
//"to" : [{
//"email" : "alavielle@gmail.com", 
//"name" : "Anne", 
//"type" : "to"
//}], 
//"autotext" : "true", 
//"subject" : "test", 
//"html" : "test test"
//}
//}