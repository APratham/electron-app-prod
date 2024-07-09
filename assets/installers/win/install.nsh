!include "MUI2.nsh"

; store path where script is being run from
!define SCRIPT_PATH "${__FILEDIR__}"

!define LICENSE_FILE "${SCRIPT_PATH}license.txt"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${LICENSE_FILE}"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH