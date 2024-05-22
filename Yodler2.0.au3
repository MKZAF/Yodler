#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Batsu

 Script Function: Sends Discord Status Payload

#ce ----------------------------------------------------------------------------

#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <File.au3>
#include <StringConstants.au3>
#include <WinAPIFiles.au3>

Opt("WinTitleMatchMode", 2)

StatusMessagePayload()

Func StatusMessagePayload()

	;Find line count of YodleTempFile.txt
	Local $LnCnt = _FileCountLines(@ScriptDir & "\Ducs\YodleTempFile.txt")
	;MsgBox($MB_SYSTEMMODAL, "Line Count:", $LnCnt)
	;Read $LnCnt data and set as yodle variable
	Local $Y = FileReadLine(@ScriptDir & "\Ducs\YodleTempFile.txt", $LnCnt)
	;MsgBox($MB_SYSTEMMODAL, "Yodle:", $Y)

	;Check Status of Discord Process
	If ProcessExists("Discord.exe") then 
		;Set prority level to high
		ProcessSetPriority("Discord.exe", 4)
			
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
	Global $YString = Send($Y)
	;Commit Yodle
	Send("{ENTER}")
	Send("{ESC}")
	;Move mouse back to original position
	MouseMove($MOrigPos[0], $MOrigPos[1], 0)	
	;Remove "On Top" flag
	WinSetOnTop($D, "", $WINDOWS_NOONTOP)
	;Enable User Input
;BlockInput($BI_ENABLE)
	;Close PowerShell Window
	WinClose("Windows PowerShell")

;---------------------------------------------------------------------------------------------------------------------------------------------------------

	;Set $YPath to Ducs folder directory path
	Local $YDucDir = @UserProfileDir & "\DEV\Yodler\Ducs"
	;MsgBox($MB_SYSTEMMODAL, "Duc", @UserProfileDir & $YDucDir)
	;Set $YStrFnd var to not found
	Local $YStrFnd = 0
	;Set Duc folder check cycle to "in progress"
	Local $DucSrch = 0
	;Make file list array of Yodle.duc scripts
	Local $YAryLst = _FileListToArray($YDucDir, Default, Default, True)
	;MsgBox($MB_SYSTEMMODAL, "Duc", $YAryLst[1] & "$" & $YAryLst[2] & "$" & $YAryLst[3] & "$" & $YAryLst[4] & "$" & $YAryLst[5] & "$" & $YAryLst[6])
	;Convert Array $YFileList to String $YStringList
	Local $YStrLst = _ArrayToString($YAryLst,"|")
	;MsgBox($MB_SYSTEMMODAL, "Duc", $YStrLst)
	;Split $YStringList to individual strings based on how many files were found in the $YDucDir
	Local $YStrPth = StringSplit($YStrLst,"|")
	;MsgBox($MB_SYSTEMMODAL, "Duc", $YStrPth[0] & "$" & $YStrPth[1] & "$" & $YStrPth[2] & "$" & $YStrPth[3])

	;While Yodle String not located in YodleDuc Folder
	While $YStrFnd = 0

		;Create "yodle".txt to use while doing StringCompare
		Local $Ytxt = $Y & ".txt"

			;Loop through the array returned by StringSplit to determine if new duc file is required to be made
			For $YFlCnt = 1 to $YAryLst[0]
				;MsgBox($MB_SYSTEMMODAL, $YAryLst[0], $YFlCnt)
				;Search $YStrPthChk for $Y
				Local $YStrPthChk = StringInStr($YStrPth[$YFlCnt], $Y)
				;MsgBox($MB_SYSTEMMODAL, "Duc", $YStrPthChk)

					;If $YStrPthChk returns no relation between strings
					If $YStrPthChk = 32 Then ;Split $YStrPth to individual directories
						Local $YStrPthIso = StringSplit($YStrPth[$YFlCnt], "\")
						;MsgBox($MB_SYSTEMMODAL, "Duc", $YStrPthIso[7])
						;Compare $Y.txt to $YStrPthIso[duc file name]
						Local $YStrCmp = StringCompare($Ytxt, $YStrPthIso[7], $STR_CASESENSE)
						;MsgBox($MB_SYSTEMMODAL, "", _
                				;"Comparing '" & $Ytxt & "' To '" & $YStrPthIso[7] & "'" & @CRLF & _
                				;"StringCompare Result: " & $YStrCmp)
						;If StringCompare returns equal value
						If $YStrCmp = 0 Then ;Set $YStrFnd var to found
						Local $YStrFnd = 1
						;MsgBox($MB_SYSTEMMODAL, "String Search", "string found " & $YStrFnd)
						ExitLoop
							
						EndIf

					EndIf

					If $YFlCnt = $YAryLst[0] Then ;Set Duc search variable to complete And Yodle string var to needed
						Local $DucSrch = 1
						;MsgBox($MB_SYSTEMMODAL, "Duc", "Search finished")
						Local $YStrFnd = 2
						;MsgBox($MB_SYSTEMMODAL, "New", "New Duc file needed")

					EndIf

			Next

	WEnd

	;If no Duc file is found with Yodle creat new Duc file
	If $YStrFnd = 2 Then ;Create new Duc file
		Local $YPth = FileOpen(@ScriptDir & "\Ducs\" & $Y &  ".txt", 1)
		;MsgBox($MB_SYSTEMMODAL, "Yodle Path:", @ScriptDir & "\Ducs\" & $Y &  ".txt")
		;Write new Duc file
		FileWrite($YPth, "REM DOCUMENTATION" & @CRLF & _
		"REM Yodler" & @CRLF & _
		"REM Version 1.0" & @CRLF & _
		"REM OS: Windows" & @CRLF & _
		"REM Author: Batsu" & @CRLF & _
		"REM Description: Payload that will run AutoIt Yodle script" & @CRLF & _
		@CRLF & _
		"REM Open CMD" & @CRLF & _
		@CRLF & _
		"GUI r" & @CRLF & _
		"DELAY 250" & @CRLF & _
		"STRING powershell" & @CRLF & _
		"DELAY 100" & @CRLF & _
		"ENTER" & @CRLF & _
		"DELAY 750" & @CRLF & _
		@CRLF & _
		"REM NOTICE: May need to change file path to your browser location" & @CRLF & _
		@CRLF & _
		'STRING start-process "C:\Users\oveng\DEV\Yodler\Yodler2.0.au3"' & @CRLF & _
		"DELAY 100" & @CRLF & _
		"ENTER")

	EndIf

EndFunc 
