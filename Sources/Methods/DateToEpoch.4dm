//%attributes = {}
// DateToEpoch
// $1 : timestamp

C_TEXT:C284($1)
C_REAL:C285($0)

C_DATE:C307($d_Date)
C_TIME:C306($h_Time)
C_LONGINT:C283($l_Days)
C_LONGINT:C283($l_Hours)
C_LONGINT:C283($l_Minutes)
C_LONGINT:C283($l_Time)
C_REAL:C285($r_Epoch)

$t_Timestamp:=$1
//strip the Z at the end
$t_Timestamp:=Substring:C12($t_Timestamp; 1; 19)
//now get the GMT date and time for calculations
$d_Date:=Date:C102($t_Timestamp)
$h_Time:=Time:C179($t_Timestamp)
//get number of days
$l_Days:=$d_Date-!00-00-00!
//start calculating the unix time
//add the days
$r_Epoch:=$l_Days*86400
$l_Time:=$h_Time*1  //make it a longint
//add the hours
$l_Hours:=Trunc:C95($l_Time/3600; 0)
$r_Epoch:=$r_Epoch+($l_Hours*3600)
$l_Time:=Mod:C98($l_Time; 3600)
//add the minutes
$l_Minutes:=Trunc:C95($l_Time/60; 0)
$r_Epoch:=$r_Epoch+($l_Minutes*60)
$l_Time:=Mod:C98($l_Time; 60)
//add the seconds
$r_Epoch:=$r_Epoch+$l_Time

$0:=$r_Epoch
