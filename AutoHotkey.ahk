/********************************************************************************

Hotkeys:
  Win-S: Open Snipping Tool
  Win-Shift-D: Open My Documents
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
SetTitleMatchMode 1 ; Window's title must start with the specified WinTitle.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;===============================================================================
; INCLUDES
;

#Include %A_ScriptDir%\Hotstrings.ahk
#Include %A_ScriptDir%\HTMLHotstrings.ahk
#Include %A_ScriptDir%\ExplorerPathLib.ahk
#Include %A_ScriptDir%\Gaming.ahk
; #Include %A_ScriptDir%\DisableAltGr.ahk


;===============================================================================
; SHORTCUTS
;

#J:: Run, "C:\Users\Ethan\Downloads"
#N:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default"
+#N:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" --incognito
^#N:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1"
^+#N:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1" --incognito

#C:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" --app=https://calendar.google.com/calendar/u/0/r
+#C:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" --app=https://calendar.google.com/calendar/b/ethan@hackthenorth.com/r
^#C:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1" --app=https://outlook.office.com/calendar/view/workweek
^#O:: Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1" --app=https://outlook.office.com/mail/

#M:: Run, "C:\Users\Ethan\Desktop\Messenger.lnk"
#S:: Run, "C:\Users\Ethan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Slack Technologies Inc\Slack.lnk"
#D:: Run, "C:\Users\Ethan\Desktop\Discord.lnk"

#A:: Run, "C:\Users\Ethan\Desktop\Microsoft Teams.lnk"

#K:: Run, % "wt nt -d " . Explorer_GetPath()
#B:: Run, % "wt nt -p Ubuntu -d " . Explorer_GetPath()

+#K:: Run, % "cmd /K @cd " . Explorer_GetPath() . " && cmd"
+#B:: Run, "C:\Users\Ethan\Desktop\Ubuntu.lnk"

#Y:: Run, "Bluetooth Settings.url"

;==SUBLIME==
; Open selected file or folder in new window
#T:: Run, % "subl.exe -n " . Explorer_GetSelectedOrPath()
; Add selected file to existing window
+#T:: Run, % "subl.exe " . Explorer_GetSelected()
; Create new window
^#T:: Run, % "subl.exe -n"

;==MEDIA==
#F7::
#F9::
Launch_Media::
	Run, "C:\Users\Ethan\Desktop\Spotify.lnk"
return


;===============================================================================
; KEY REMAPPINGS
;

Launch_App2::F13

;==MEDIA KEYS==
; $F1:: Send, {Volume_Mute}
; $#F1:: Send, {F1}
#F10:: Send, {Media_Prev}
#F11:: Send, {Media_Play_Pause}
#F12:: Send, {Media_Next}


;==WINDOWS==
; Disable Win-M (Show desktop)
; #M:: return

; Shift-Win-Up to Maximize
+#Up:: WinMaximize, A

; Shift-Win-Down to Minimize
+#Down:: WinMinimize, A


;==RCtrl-Arrow Keys for PgUp/PgDn/Home/End (alternative to native Fn+Arrow Keys)
>^Up:: Send, {PgUp}
>^Down:: Send, {PgDn}
>^Left:: Send, {Home}
>^Right:: Send, {End}

<^>^Up:: Send, ^{PgUp}
<^>^Down:: Send, ^{PgDn}
<^>^Left:: Send, ^{Home}
<^>^Right:: Send, ^{End}

+>^Up:: Send, +{PgUp}
+>^Down:: Send, +{PgDn}
+>^Left:: Send, +{Home}
+>^Right:: Send, +{End}

!>^Up:: Send, !{PgUp}
!>^Down:: Send, !{PgDn}
!>^Left:: Send, !{Home}
!>^Right:: Send, !{End}

<^+>^Up:: Send, ^+{PgUp}
<^+>^Down:: Send, ^+{PgDn}
<^+>^Left:: Send, ^+{Home}
<^+>^Right:: Send, ^+{End}

<^!>^Up:: Send, ^!{PgUp}
<^!>^Down:: Send, ^!{PgDn}
<^!>^Left:: Send, ^!{Home}
<^!>^Right:: Send, ^!{End}

+!>^Up:: Send, +!{PgUp}
+!>^Down:: Send, +!{PgDn}
+!>^Left:: Send, +!{Home}
+!>^Right:: Send, +!{End}

<^+!>^Up:: Send, ^+!{PgUp}
<^+!>^Down:: Send, ^+!{PgDn}
<^+!>^Left:: Send, ^+!{Home}
<^+!>^Right:: Send, ^+!{End}

; AppsKey is Fn+RCtrl, so consider it a ^ modifier
AppsKey:: Send, {Ctrl down}
AppsKey Up:: Send, {Ctrl up}


;===============================================================================
; UTILITIES
;

; ;==ALT CLIPBOARD==
; <^!C::
; 	tempClipboard := clipboardAll
; 	clipboard := altClipboard
; 	altClipboard := tempClipboard
; 	ShowToolTip("Clipboard Swapped")
; return

; ;==CLEAR CLIPBOARDS==
; ^!#C::
; 	altClipboard =
; 	clipboard =
; 	ShowToolTip("Clipboards Cleared")
; return

;==AUTOCLICK==
#MaxThreadsPerHotkey 2

!F7::AutoClickHotkey("Auto Click", "AutoClick", 100)
!+F7::AutoClickHotkey("Fast Auto Click", "AutoClick", 1)
^!F7::AutoClickHotkey("Slow Auto Click", "AutoClick", 300)
^!+F7::AutoClickHotkey("Auto Right Click", "AutoClickRight", 100)

#MaxThreadsPerHotkey 1


;===============================================================================
; COLEMAK
;

;==Ctrl-Alt-PgUp to enable QWERTY to Colemak and show On-Screen Colemak==*
^!PgUp::
	Run, "On-Screen Colemak.ahk"
	; Run, "QWERTY to Colemak.ahk"
return

; Ctrl-Alt-PgDn disables both of these scripts.

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
#IfWinActive ahk_class CabinetWClass

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

RunAndFocus(Command, WinSelector) {
	Run, %Command%

	WinWait, %WinSelector%
	WinActivate
}

RunSingleInstance(Command, WinSelector, DetectHidden:="Off") {
	DetectHiddenWindows, %DetectHidden%
	if WinExist(WinSelector) {
		WinActivate
	} else {
		RunAndFocus(Command, WinSelector)
	}
}


ShowToolTip(Text, Duration:=3000) {
	ToolTip, %Text%
	SetTimer, RemoveToolTip, %Duration%
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
^!F12:: ExitApp
