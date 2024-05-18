#include <MsgBoxConstants.au3>
#include <File.au3>
#include <StringConstants.au3>
#include <WinAPIFiles.au3>


;$YStrPth[$YFlCnt]   $Ytxt $YStrPthIso

YodleMakerTool()

Func YodleMakerTool()

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

		;Set $Y var to current yodle sent
		Local $Y = "maybe"
		;Create "yodle".txt to use while doing StringCompare
		Local $Ytxt = $Y & ".txt"

			;Loop through the array returned by StringSplit to determine if new duc file is required to be made
			For $YFlCnt = 1 to $YAryLst[0]
				MsgBox($MB_SYSTEMMODAL, $YAryLst[0], $YFlCnt)

				;Search $YStrPthChk for $Y
				Local $YStrPthChk = StringInStr($YStrPth[$YFlCnt], $Y)
				MsgBox($MB_SYSTEMMODAL, "Duc", $YStrPthChk)

					;If $YStrPthChk returns no relation between strings
					If $YStrPthChk = 32 Then ;Split $YStrPth to individual directories
						Local $YStrPthIso = StringSplit($YStrPth[$YFlCnt], "\")
						MsgBox($MB_SYSTEMMODAL, "Duc", $YStrPthIso[7])
						;Compare $Y.txt to $YStrPthIso[duc file name]
						Local $YStrCmp = StringCompare($Ytxt, $YStrPthIso[7], $STR_CASESENSE)
						MsgBox($MB_SYSTEMMODAL, "", _
                				"Comparing '" & $Ytxt & "' To '" & $YStrPthIso[7] & "'" & @CRLF & _
                				"StringCompare Result: " & $YStrCmp)

						;If StringCompare returns equal value
						If $YStrCmp = 0 Then ;Set $YStrFnd var to found
						Local $YStrFnd = 1
						MsgBox($MB_SYSTEMMODAL, "String Search", "string found " & $YStrFnd)
						ExitLoop
							
						EndIf

					EndIf

					If $YFlCnt = $YAryLst[0] Then ;Set Duc search variable to complete And Yodle string var to needed
						Local $DucSrch = 1
						MsgBox($MB_SYSTEMMODAL, "Duc", "Search finished")
						Local $YStrFnd = 2
						MsgBox($MB_SYSTEMMODAL, "New", "New Duc file needed")

					EndIf

			Next

	WEnd

	;If no Duc file is found with Yodle creat new Duc file
	If $YStrFnd = 2 Then ;Create new Duc file
		Local $YPth = FileOpen(@ScriptDir & "\Ducs\" & $Y &  ".txt", 1)
		MsgBox($MB_SYSTEMMODAL, "Yodle Path:", @ScriptDir & "\Ducs\" & $Y &  ".txt")

		FileWrite($YPth, "REM DOCUMENTATION" & @CRLF & _
		"REM Yodler" & @CRLF & _
		"REM Version 1.0" & @CRLF & _
		"REM OS: Windows" & @CRLF & _
		"REM Author: Batsu" & @CRLF & _
		"REM Description: Payload that will run AutoIt Yodle script")

	EndIf

EndFunc 
