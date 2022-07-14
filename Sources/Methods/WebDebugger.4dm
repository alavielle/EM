//%attributes = {}
// WebDebugger
//$1 : Message
//$2 : Is tab ?
//$3 :  ->tab 
CREATE RECORD:C68([WebDebugger:5])
[WebDebugger:5]ID:1:=Sequence number:C244([WebDebugger:5])
[WebDebugger:5]TimeStamp:2:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
If ($2)
	For ($i; 1; Size of array:C274($3->))
		[WebDebugger:5]Contenu:3:=[WebDebugger:5]Contenu:3+$3->{$i}+" - "
	End for 
Else 
	[WebDebugger:5]Contenu:3:=$1
End if 
[WebDebugger:5]Contenu:3:=[WebDebugger:5]Contenu:3+Char:C90(13)
SAVE RECORD:C53([WebDebugger:5])