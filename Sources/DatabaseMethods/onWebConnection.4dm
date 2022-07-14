// Sur connexion Web 
C_TEXT:C284($1; $2; $3; $4; $5; $6)
$URL:=$1
$Browser:=$2
$BrowserIP:=$3
$ServerIP:=$4
$name:=$5
$password:=$6

WebH_NoContext($URL; $Browser; $BrowserIP; $ServerIP; $name; $password)



