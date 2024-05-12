#include <MsgBoxConstants.au3>
#include <File.au3>
#include <StringConstants.au3>


;$YStrPth[$YFlCnt]   $Ytxt $YStrPthIso

YodleMakerTool ()

Func YodleMakerTool()

	;Set $YPath to Ducs folder directory path
	Local $YPth = @UserProfileDir & "\Yodler\Ducs"
	;Set $YStrFnd var to not found
	Local $YStrFnd = 0
	;Set Duc folder check cycle to "in progress"
	Local $DucSrch = 0
	;Make file list array of Yodle.duc scripts
	Local $YAryLst = _FileListToArray($YPth, Default, Default, True)
	;Convert Array $YFileList to String $YStringList
	Local $YStrLst = _ArrayToString($YAryLst,"|")
	;Split $YStringList to individual strings based on how many files were found in the $YPth
	Local $YStrPth = StringSplit($YStrLst,"|")

	;While Yodle String not located in YodleDuc Folder
	While $YStrFnd = 0

		;Set $Y var to current yodle sent
		Local $Y = "Tes"
		;Create "yodle".txt to use while doing StringCompare
		Local $Ytxt = $Y & ".txt"

			;Loop through the array returned by StringSplit to determine if new duc file is required to be made
			For $YFlCnt = 1 to $YAryLst[0]

				;Search $YStrPthChk for $Ytxt
				Local $YStrPthChk = StringInStr($YStrPth[$YFlCnt],$Y, $STR_CASESENSE, -1)

					;If $YStrPthChk returns no relation between strings
					If $YStrPthChk = 28 Then ;Split $YStrPth to individual directories
						Local $YStrPthIso = StringSplit($YStrPth[$YFlCnt],"\")
						;Compare $Y.txt to $YStrPthIso[duc file name]
						Local $YStrCmp = StringCompare($Ytxt,$YStrPthIso[6],$STR_CASESENSE)
						
							;If StringCompare returns equal value
							If $YStrCmp = 0 Then ;Set $YStrFnd var to found
								Local $YStrFnd = 1
							EndIf
					EndIf

					;If counter is on last duc check
					If $YFlCnt = $YAryLst[0] Then ;Set Duc search variable to complete And Yodle string var to needed
						Local $DucSrch = 1
						Local $YStrFnd = 2
					EndIf

			Next

	WEnd

	;If no Duc file is found with Yodle creat new Duc file
	If $YStrFnd = 2 Then ;Create new Duc file
		Local $YPth = _PathMake("C:","Users\oveng\Yodler\Ducs",$Y,"txt")
		MsgBox($MB_SYSTEMMODAL, "Yodle Path:", $YStrPthIso)
	EndIf

EndFunc 