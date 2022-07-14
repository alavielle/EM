//%attributes = {}
// Envoi_lien
// $1 : delai d'expiration (en secondes)

var $indexEmail; $1 : Integer
var $Email : Text
var $user : Object

ARRAY TEXT:C222($Tnames; 0)
ARRAY TEXT:C222($Tvalues; 0)

// get values sent in the header of the request
WEB GET VARIABLES:C683($Tnames; $Tvalues)
// look for header login fields
$indexEmail:=Find in array:C230($Tnames; "Email")
$Email:=$Tvalues{$indexEmail}

//look for a user with the entered name in the users table
$user:=ds:C1482.WebUser.query("Email = :1"; $Email).first()

If ($user#Null:C1517)  //a user was found
	// créer un token unique
	$token:=Generate UUID:C1066+String:C10(DateToEpoch(Timestamp:C1445))
	$lien:="http://localhost/reinit_pwd/"+$user.UUID+"/"+$token
	// sauvegarder le token et le delai d'expiration
	$user.Expiration:=DateToEpoch(Timestamp:C1445)+$1
	$user.Token:=$token
	$user.save()
	// Envoyer le mail
	QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="mail_reinit_pwd")
	If (Records in selection:C76([ModelesHTML:15])>0)
		$contenu:=[ModelesHTML:15]Detail:3
		$Contenu:=Replace string:C233($Contenu; "$lien$"; $lien)
		
		SendeMail_OnMandrill("contact@alcedi.fr"; "Nouveau mot de passe de votre compte Entraid'Union"; $contenu; "contact@alcedi.fr")
		
	End if 
End if 