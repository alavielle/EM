//%attributes = {}
// ModifPwd
// $1 : UUID

C_TEXT:C284($1)
C_OBJECT:C1216($user)
$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)  //a user was found
	ARRAY TEXT:C222(tNoms; 0)
	ARRAY TEXT:C222(tvaleurs; 0)
	C_BLOB:C604($requete)
	C_TEXT:C284($texteRequete)
	WEB GET HTTP BODY:C814($requete)
	WEB GET VARIABLES:C683(tNoms; tvaleurs)
	C_LONGINT:C283($erreur)
	C_TEXT:C284($JsonRecu)
	$erreur:=0
	$JsonRecu:=""
	If (Size of array:C274(tNoms)>0)
		$texteRequete:=BLOB to text:C555($requete; UTF8 texte sans longueur:K22:17)
		ARRAY OBJECT:C1221($sel; 0)
		JSON PARSE ARRAY:C1219(tNoms{1}; $sel)
		C_OBJECT:C1216($Obj)
		For ($i; 1; Size of array:C274($sel))
			$Obj:=$sel{$i}
			$newPassword:=OB Get:C1224($Obj; "newpassword")
			$confirmPassword:=OB Get:C1224($Obj; "confirmpassword")
		End for 
		If ($newPassword=$confirmPassword)
			If (Match regex:C1019("(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(.{8,})"; $newPassword))
				
				$user.Password:=Generate password hash:C1533($newPassword)
				$user.save()
				$JsonRecu:="Votre mot de passe a été modifié avec succès."
				
			Else 
				$erreur:=403
				$JsonRecu:="Le mot de passe n'est pas valide."
			End if 
		Else 
			$erreur:=403
			$JsonRecu:="Les mots de passe ne sont pas identiques."
		End if 
	Else 
		$erreur:=404
		$JsonRecu:="Une erreur est survenue..."
	End if 
Else 
	$erreur:=403
	$JsonRecu:="Une erreur est survenue..."
End if 
If ($erreur>0)
	ReturnSomething($JsonRecu; String:C10($erreur))
Else 
	ReturnSomething($JsonRecu)
End if 