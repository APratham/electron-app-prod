!include "MUI2.nsh"

Page custom CustomLicensePage
!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

Section "MainSection" SEC01
    SetOutPath "$INSTDIR"
    ; Include all files and subdirectories in the dist directory
    File /r "/Users/apratham/Documents/GitHub/electron-oauth-app/*.*"
SectionEnd

Function CustomLicensePage
    nsDialogs::Create 1018
    Pop $Dialog

    ${If} $Dialog == error
        Abort
    ${EndIf}

    ; Create a label for the license title
    ${NSD_CreateLabel} 0 0 100% 12u "License Agreement"
    Pop $0

    ; Create a scrollable text box for the license text
    ${NSD_CreateText} 0 12u 100% 60% "MULTILINE|READONLY|VSCROLL"
    Pop $LicenseTextBox

    ; Read the license file
    FileOpen $LicenseFile "/Users/apratham/Documents/GitHub/electron-oauth-app/license.txt" r
    StrCpy $LicenseText ""
    FileRead $LicenseFile $0
    ${DoWhile} $0 != ""
        StrCpy $LicenseText "$LicenseText$0"
        FileRead $LicenseFile $0
    ${Loop}
    FileClose $LicenseFile

    ${NSD_SetText} $LicenseTextBox "$LicenseText"

    ; Create an "I Agree" checkbox
    ${NSD_CreateCheckbox} 0 75% 100% 10u "I agree to the terms above"
    Pop $AgreeCheckbox
    ${NSD_OnClick} $AgreeCheckbox OnAgreeClick

    ; Create a Next button
    ${NSD_CreateButton} 50% 85% 50% 12u "Next"
    Pop $NextButton
    ${NSD_OnClick} $NextButton OnNextButton

    ; Initially disable the Next button
    EnableWindow $NextButton 0

    nsDialogs::Show
FunctionEnd

Function OnAgreeClick
    ${NSD_GetState} $AgreeCheckbox $0
    ${IfThen} $0 == ${BST_CHECKED} ${|} EnableWindow $NextButton 1 ${|}
    ${Else} EnableWindow $NextButton 0
FunctionEnd

Function OnNextButton
    Abort
FunctionEnd

InstallDir "$PROGRAMFILES\Electron OAuth App"