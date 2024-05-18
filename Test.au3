#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Batsu

 Script Function: Sends Discord Status Payload #Vibes

#ce ----------------------------------------------------------------------------

#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <File.au3>

Opt("WinTitleMatchMode",2)

StatusMessagePayload()

Func StatusMessagePayload()

	;Check Status of Discord Process
	If ProcessExists("Discord.exe") then 
		;Set prority level to high
		ProcessSetPriority("Discord.exe",4)
			
		;Check if browser discord window is open and titled "Discord"
		if WinExists("• Discord") Then 
			;Set title to "XYV"
			WinSetTitle("• Discord", "", "ᘛ⁐̤ᕐᐷ✗")
		EndIf
			
		;Retrieve full title of discord window
		Local $D = WinGetTitle("[TITLE:Discord; CLASS:Chrome_WidgetWin_1]")
		;Activate Discord Window
		WinActivate($D)
		;Set load type variable
		local $load = 1
		;Disable user Input
	;BlockInput($BI_DISABLE)
		;Retrieve current mouse position
		Local $MOrigPos = MouseGetPos()
		;Retrieve current Discord client dimensions
		Local $DSize = WinGetClientSize($D)
		;Set Discord to always be "on top"
		WinSetOnTop($D, "", $WINDOWS_ONTOP)
		
	Else ;Discord app hotkey
		Send("^!d")
		;Wait for Discord process to exist
		WinWait("Friends - Discord")
		;Set prority level to high
		ProcessSetPriority("Discord.exe", 4)
		
		;Check if browser discord window is open and titled "Discord"
		if WinExists("• Discord") Then 
			;Set title to "XYV"
			WinSetTitle("• Discord", "", "ᘛ⁐̤ᕐᐷ✗")
		EndIf
		
		;Retrieve full title of discord window
		Local $D = WinGetTitle("Friends - Discord")
		;Set load type variable
		local $load = 0
		;Disable user Input
	;BlockInput($BI_DISABLE)
		;Retrieve current mouse position
		Local $MOrigPos = MouseGetPos()
		;Retrieve current Discord client dimensions
		Local $DSize = WinGetClientSize($D)
		;Set Discord to always be "on top"
		WinSetOnTop($D, "", $WINDOWS_ONTOP)
	EndIf
	
	;Retrieve current position of discord window
	Local $DPos = WinGetPos($D)
	;Wait for Discord to be active window
	WinWaitActive($D)
	;Exit anything that may be open in app
	Send("{ESC}")
	;DELAY
	Sleep(300)

Opt("MouseCoordMode", 2) 
			
	;Math operation to find relative mouse click coords
	
	;User profile coords
	Local $UPosW = 177
	Local $UPosH = $DSize[1] - 34
	;Edit Status Message coords
	Local $SPosW = 177
	
	;Depict which ratio to base height click on based on Discord client height
	If $DSize[1] > 1080 Then 
		Local $SPosH = $DSize[1] * .91
	Else
		Local $SPosH = $DSize[1] * .87
	EndIf
	
	;Click user profile
	MouseClick($MOUSE_CLICK_LEFT, $UPosW, $UPosH, 1, 2)
	;DELAY
	Sleep(350)
	;Click "Edit Custom Status"
	MouseClick($MOUSE_CLICK_LEFT, $SPosW, $SPosH, 1, 2)
	
Opt("MouseCoordMode", 1)
			
	;DELAY
	Sleep(100)
	;Clear past Yodle
	Send("^a")
	Send("{BS}")
	;Enter Yodle
	Global $YString = Send("r u okay my love")
	;Commit Yodle
	Send("{ENTER}")
	Send("{ESC}")
	;Move mouse back to original position
	MouseMove($MOrigPos[0], $MOrigPos[1], 0)	
	;Remove "On Top" flag
	WinSetOnTop($D, "", $WINDOWS_NOONTOP)
	;Enable User Input
;BlockInput($BI_ENABLE)
	
EndFunc ;==>Status Message Payload Completed

YodleMakerTool ()

Func YodleMakerTool()

Local $YPath = @UserProfileDir & "\Yodler\Ducs"

	;Make file list array of Yodle.duc scripts
	Local $YFileList = _FileListToArray($YPath, Default, Default, True)
	; Display the results returned by _FileListToArray.
    _ArrayDisplay($YFileList, "$YFileList")
	
EndFunc 
