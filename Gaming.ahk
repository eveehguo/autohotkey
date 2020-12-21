;===============================================================================
; Civilization VI
;

#IfWinActive ahk_exe CivilizationVI_DX12.exe
W:: Send {Up down}
W up:: Send {Up up}
A:: Send {Left down}
A up:: Send {Left up}
S:: Send {Down down}
S up:: Send {Down up}
D:: Send {Right down}
D up:: Send {Right up}

!W:: Send {w}
!A:: Send {a}
!S:: Send {s}
!D:: Send {d}

!+W:: Send {W}
!+A:: Send {A}
!+S:: Send {S}
!+D:: Send {D}


#IfWinActive


#IfWinActive ahk_exe WorldOfTanks.exe
MButton:: Click, Right
RButton:: Click, Middle

#IfWinActive


;==Anti-Anti-Idle==
; moveMouseTimerOn = false;
; !F9::
; 	if moveMouseTimerOn {
; 		SetTimer, MoveMouse, Off
; 		ShowToolTip("MoveMouse timer off.")
; 	} else {
; 		SetTimer, MoveMouse, 1000 ; Run MoveMouse every 1 second
; 		ShowToolTip("MoveMouse timer on.")
; 	}
; 	moveMouseTimerOn := !moveMouseTimerOn
; return 

; MoveMouse:
;     MouseMove, 2, 0, 2, R  ; Move the mouse two pixels to the right
;     MouseMove, -2, 0, 2, R ; Move the mouse back two pixels
; return
