!include MUI2.nsh

Var LicenseText

Page custom LicensePage

Function LicensePage

  GetDlgItem $LicenseText $HWNDPARENT 1000 ; Get handle of the text box
  FileOpen $0 "license.txt" "r"   ; Open the license file

  ; Read and display the license text
  loop:
    FileRead $0 $1
    StrCmp $1 "" done
    SendMessage $LicenseText ${EM_REPLACESEL} 1 0 STR:$1 ; Append text to the text box
    Goto loop
  done:
    FileClose $0
    
FunctionEnd