//%attributes = {}
// NewWebUser
// $1 : email
// $2 : nom
// $3 : prénom
// $4 : privilege
// $5 : ID_Equipe
// $6 : ID_CodeFiscal

C_TEXT:C284($1; $2; $3)
C_LONGINT:C283($4; $5; $6)
READ WRITE:C146([WebUser:2])
var $webUser : cs:C1710.WebUserEntity

$webUser:=ds:C1482.WebUser.new()
$webUser.Email:=$1
$webUser.Nom:=$2
$webUser.Prenom:=$3
// provisional password : the password would be entered by the user
$webUser.Password:=Generate password hash:C1533("A9z1#3eM_p£X")
$webUser.ID_Privilege:=$4
$webUser.ID_Equipe:=$5
$webUser.ID_CodeFiscal:=$6
$webUser.save()

READ ONLY:C145([WebUser:2])