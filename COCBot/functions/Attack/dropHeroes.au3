;Will drop heroes in a specific coordinates, only if slot is not -1
;Only drops when option is clicked.

Func dropHeroes($x, $y, $KingSlot = -1, $QueenSlot = -1) ;Drops for king and queen
	If _Sleep(300) Then Return
	Local $dropKing = False
	Local $dropQueen = False
	If $KingSlot <> -1 And (($iMatchMode <> $DB And $iMatchMode <> $LB) Or $KingAttack[$iMatchMode] = 1) Then
		$dropKing = True
	EndIf
	If $QueenSlot <> -1 And (($iMatchMode <> $DB And $iMatchMode <> $LB) Or $QueenAttack[$iMatchMode] = 1) Then
		$dropQueen = True
	EndIf
	If $dropKing Then
		SetLog("Dropping King", $COLOR_BLUE)
		Click(68 + (72 * $KingSlot), 595,1,0,"#0092") ;Select King
		If _Sleep(500) Then Return
		Click($x, $y,1,0,"#0093")
		$checkKPower = True
	EndIf

	If _Sleep(300) Then Return

	If $dropQueen Then
		SetLog("Dropping Queen", $COLOR_BLUE)
		Click(68 + (72 * $QueenSlot), 595,1,0,"#0094") ;Select Queen
		If _Sleep(500) Then Return
		Click($x, $y,1,0,"#0095")
		$checkQPower = True
	EndIf
EndFunc   ;==>dropHeroes
