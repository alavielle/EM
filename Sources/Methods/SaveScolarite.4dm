//%attributes = {}
// SaveScolarite
// $1 : ID_EtatCivil
// $2 : ID_AnneeSco
// $3 : ID_Classe
// $4 : Filiere

C_LONGINT:C283($1; $2; $3)
C_TEXT:C284($4)
$Scolarite:=ds:C1482.Scolarite.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $1; $2)
If ($Scolarite.length=0)
	$newScolarite:=ds:C1482.Scolarite.new()
	$newScolarite.ID_EtatCivil:=$1
	$newScolarite.ID_AnneeSco:=$2
	$newScolarite.ID_Classe:=$3
	$newScolarite.Filiere:=$4
	$newScolarite.save()
Else 
	$Scol:=$Scolarite[0]
	$Scol.ID_Classe:=$3
	$Scol.Filiere:=$4
	$Scol.save()
End if 