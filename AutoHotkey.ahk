﻿/********************************************************************************

Hotkeys:
  Win-S: Open Snipping Tool
  Win-Shift-D: Open My Documents
  Win-J: Open Downloads
  Win-J: Open Downloads


Modifiers:
  ^ : Ctrl
  ! : Alt
  + : Shift
  # : Win

Docs:
  https://autohotkey.com/docs/KeyList.htm
  https://autohotkey.com/docs/Hotkeys.htm


*/

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode 1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include %A_ScriptDir%\Hotstrings.ahk
#Include %A_ScriptDir%\HTMLHotstrings.ahk

;===============================================================================
; HOTKEYS
;

;==SPECIAL KEYS==
#S:: Run, "C:\WINDOWS\system32\SnippingTool.exe"
#D:: Run, %A_MyDocuments%
#J:: Run, "C:\Users\Ethan\Downloads"
#K:: Run, "cmd"
#N:: Run, "chrome.exe" --profile-directory="Default"

Launch_App2:: Run, % "subl.exe " . Explorer_GetSelection()
+Launch_App2:: Run, % "subl.exe -n " . Explorer_GetSelection()

#Launch_App2:: Run, calc.exe

#F2::
Launch_Mail::
	RunSingleInstance("C:\Users\Ethan\Desktop\Inbox by Gmail.lnk", "Inbox – ahk_class Chrome_WidgetWin_1")
return

#F9::
Launch_Media::
	RunSingleInstance("C:\Users\Ethan\AppData\Roaming\Spotify\Spotify.exe", "ahk_class SpotifyMainWindow", "On")
return


#F10:: Send, {Media_Prev}
#F11:: Send, {Media_Play_Pause}
#F12:: Send, {Media_Next}

;==ALT CLIPBOARD==
^!C::
	tempClipboard := clipboardAll
	clipboard := altClipboard
	altClipboard := tempClipboard
	ShowToolTip("Clipboard Swapped")
return

;==CLEAR CLIPBOARDS==
^!#C::
	altClipboard =
	clipboard =
	ShowToolTip("Clipboards Cleared")
return

;==AUTOCLICK==
#MaxThreadsPerHotkey 2

!F7::AutoClickHotkey("Auto Click", "AutoClick", 100)
!+F7::AutoClickHotkey("Fast Auto Click", "AutoClick", 1)
^!F7::AutoClickHotkey("Slow Auto Click", "AutoClick", 300)
^!+F7::AutoClickHotkey("Auto Right Click", "AutoClickRight", 100)

#MaxThreadsPerHotkey 1


;==Ctrl-Alt-PgUp to show On-Screen Colemak==*
^!PgUp:: Run, "On-Screen Colemak.ahk"


;===============================================================================
; APPLICATION SPECIFIC
;


;===============================================================================
; CHROME
;
#IfWinActive ahk_exe chrome.exe

;==Disable close all==
^+Q:: return


;===============================================================================
; WINDOWS EXPLORER
;
#IfWinActive, ahk_class CabinetWClass

;==Middle mouse for Alt-Up (move up one level)==
~MButton:: Send !{Up} 

;==Always Shift-RightClick==
RButton::
   SendInput, {Shift down}{RButton down}
   KeyWait, RButton
   SendInput, {RButton up}{Shift up}
return


#IfWinActive


;===============================================================================
; UTILITY FUNCTIONS
;

Explorer_GetSelection(hwnd="") {
	hwnd := hwnd ? hwnd : WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
    sel := window.Document.SelectedItems
	for item in sel {
		path .= """" . item.path . """ "
	}
	path := RTrim(path, " ")
	return path
}

RunSingleInstance(Path, WinTitle, DetectHidden:="Off") {
	DetectHiddenWindows, %DetectHidden%
	if WinExist(WinTitle) {
		WinActivate
	} else {
		Run, %Path%
	}
}


ShowToolTip(Text) {
	ToolTip, %Text%
	SetTimer, RemoveToolTip, 2000
}

RemoveToolTip:
	SetTimer,, Off
	ToolTip
return


AutoClickHotkey(Name, ClickType, Delay) {
	global autoClick
	if autoClick {
		ShowToolTip("Auto Click Off")
		autoClick := false
	} else {
		ShowToolTip(Name . " On")
		autoClick := true
		SetTimer, %ClickType%, %Delay%
	}
}

AutoClick:
	Click
	if not autoClick {
		SetTimer,, Off
	}
return

AutoClickRight:
	Click right
	if not autoClick {
		SetTimer,, Off
	}
return


;==ABORT==
; !F12:: pause, toggle

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

;==TILDE FOR BACKSPACE==
; $`:: Backspace
; $+`:: send {~}
; $!`:: send ``
