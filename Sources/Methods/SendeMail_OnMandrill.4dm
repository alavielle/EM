//%attributes = {}
//SendeMail_OnMandrill
// $1 : Emetteur
// $2 : Sujet
// $3 : Corps
// $4 : Destinataire
// Optionnel
// $5 : CC

$return:="Mail envoyé avec success"
$V_smtp:="smtp.mandrillapp.com"
$V_pass:="0nPN0qMlFDPZ4dHJ5XSMlg"

var $mail; $server; $status : Object

$mail:=New object:C1471
$mail.textBody:=""
$mail.htmlBody:=$3
$mail.from:=$1
$mail.to:=$4
$mail.subject:=$2
If (Count parameters:C259>4)
	If ($5#"")
		$mail.cc:=$5
	End if 
End if 

$server:=New object:C1471
$server.host:=$V_smtp
$server.port:=587
$server.user:="alcedi"
$server.password:=$V_pass

var $transporter : 4D:C1709.SMTPTransporter
$transporter:=SMTP New transporter:C1608($server)
$status:=$transporter.send($mail)
If (Not:C34($status.success))
	$return:="Une erreur s'est produite à l'envoi du mail"
End if 
$0:=$return

//$SmtpOption:=8  
//$SmtpPort:=587  

//$erreur:=SMTP_New($smtp_id)
//$erreur:=SMTP_SetPrefs(-1; 15; -1)
//$erreur:=SMTP_Charset(1; 1)

//$erreur:=SMTP_AddHeader($smtp_id; "Content-Type:"; "text/html;charset=UTF-8"; 1)
//$erreur:=SMTP_AddHeader($smtp_id; "X-MC-Metadata:"; "{userid:12345}")

//$erreur:=IT_SetPort($SmtpOption; $SmtpPort)
//$erreur:=SMTP_Host($smtp_id; $V_smtp)
//$erreur:=SMTP_Auth($smtp_id; "alcedi"; $V_pass)

//$erreur:=SMTP_From($smtp_id; $1)
//$erreur:=SMTP_ReplyTo($smtp_id; $1)
//$erreur:=SMTP_Subject($smtp_id; $2)
//$erreur:=SMTP_To($smtp_id; $4; 0)
//Si (Nombre de paramètres>4)
//Si ($5#"")
//$erreur:=SMTP_Cc($smtp_id; $5; 0)
//Fin de si 
//Fin de si 
//$erreur:=SMTP_Subject($smtp_id; $2)
//$erreur:=SMTP_Body($smtp_id; $3)

//$erreur:=SMTP_Send($smtp_id) 

//$0:=$erreur

//$clear:=SMTP_Clear($smtp_id)
