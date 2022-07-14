//%attributes = {}
//ImportDatesBourses

C_OBJECT:C1216($bourse)
$imports:=ds:C1482.ImportDatesBourses.all()
For each ($import; $imports)
	
	$bourse:=ds:C1482.Bourse.query("ID =:1"; $import.ID_import)[0]
	$bourse.DateAvance:=$import.DateAvance
	$bourse.DateSolde:=$import.DateSolde
	$bourse.DateComplCA:=$import.DateComplCA
	
	$bourse.save()
End for each 