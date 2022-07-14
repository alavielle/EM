//%attributes = {}
//NewBourse
//$1 : ID_Boursier
//$2 : Id_AnneeSco
// $0  : ID_Bourse

READ WRITE:C146([Bourse:12])
CREATE RECORD:C68([Bourse:12])
[Bourse:12]ID_Boursier:8:=$1
[Bourse:12]ID_AnneeSco:2:=$2
[Bourse:12]DateDemande:3:=Current date:C33()
SAVE RECORD:C53([Bourse:12])
READ ONLY:C145([Bourse:12])
$0:=[Bourse:12]ID:1
