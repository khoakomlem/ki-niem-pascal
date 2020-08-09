HotKeySet("",'ex')
Func ex()
   Exit
EndFunc
While 1
   If ProcessExists("virus.exe") Then
	  ProcessClose("virus.exe")
	  Run("drug.exe")
   Else
	  Exit
   EndIf
WEnd