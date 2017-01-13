;; IME Switch
^Space::
	getIME := IME_GetConvMode("A")	
	if (getIME = 0)
	{
		IME_SetConvMode(1,A)
	} else {
		IME_SetConvMode(0,A)
	}
Return

IME_SetConvMode(ConvMode,myWinTitle)   {
    ControlGet,hwnd,HWND,,,%myWinTitle%
;    if  (WinActive(myWinTitle))   {
;       ptrSize := !A_PtrSize ? 4 : A_PtrSize
;        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
;        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
;        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
;                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
;    }
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283     ;Message : WM_IME_CONTROL
          ,  Int, 0x002      ;wParam  : IMC_SETCONVERSIONMODE
          ,  Int, ConvMode)  ;lParam  : CONVERSIONMODE
}

IME_GetConvMode(WinToCheck)   {
    ControlGet,hwnd,HWND,,,%WinToCheck%
    if  (WinActive(WinToCheck))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x001  ;wParam  : IMC_GETCONVERSIONMODE
          ,  Int, 0)     ;lParam  : 0
}
