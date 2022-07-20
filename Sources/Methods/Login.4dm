//%attributes = {"publishedWeb":true}
// Login

var $indexEmail; $indexPassword : Integer
var $Email; $password : Text
var $user : Object
var $cookie : Text
var $collectionUser : Collection

ARRAY TEXT:C222($Tnames; 0)
ARRAY TEXT:C222($Tvalues; 0)

// get values sent in the header of the request
WEB GET VARIABLES:C683($Tnames; $Tvalues)
// look for header login fields
$indexEmail:=Find in array:C230($Tnames; "Email")
$Email:=$Tvalues{$indexEmail}
$indexPassword:=Find in array:C230($Tnames; "password")
$password:=$Tvalues{$indexPassword}

//look for a user with the entered name in the users table
$user:=ds:C1482.WebUser.query("Email = :1"; $Email).first()

If ($user#Null:C1517)  //a user was found
	//check the password
	If (Verify password hash:C1534($password; $user.Password))
		//password ok, fill the session
		FillSession($user)
		// sauvegarder le timestamp pour gérer l'inactivité
		$user.TimeStamp:=Timestamp:C1445
		$user.save()
		
		WEB SEND HTTP REDIRECT:C659("/menu")
	Else 
		Connexion("Identifiant ou mot de passe incorrect.")
	End if 
Else 
	Connexion("Identifiant ou mot de passe incorrect.")
End if 
