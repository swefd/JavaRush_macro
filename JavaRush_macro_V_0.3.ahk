#NoEnv  							; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  		; Ensures a consistent starting directory.
;#IfWinActive ahk_class Qt5QWindowIcon



;---------------------------- Vars ----------------------------------
global nativeScaleX := 1924     ; equals 1920x1080 
global nativeScaleY := 1114

global firsCopy := true

global coefX := 1
global coefY := 1

global Xp := 1
global Xp2 := 1
global Yp := 1
global Yp2 := 1

WinGetPos, TargetWindowX, TargetWindowY, WindowWidth, WindowHeight, ahk_class Qt5QWindowIcon

if(WindowWidth < nativeScaleX){
	coefX := (WindowWidth / nativeScaleX) - ((WindowWidth / nativeScaleX) / 24,0) 
	coefY := (WindowHeight / nativeScaleY) + ((WindowHeight / nativeScaleY) / 10,0)
}else if (WindowWidth > nativeScaleX){
	coefX := (nativeScaleX /WindowWidth) - ((nativeScaleX /WindowWidth) / 10,0 )
	coefY := (nativeScaleY / WindowHeight) + ((nativeScaleY / WindowHeight) /10,0) 
}

;/////////////////////////////////////////////////////////////////////////////



;-------------------------------  Coordinates ---------------------------------

global cClickFirstWord := [100,100] ; X100, Y100
global cClickSelectAll := [1300,140,1100,140]
global cDragDownLine := [35,130,210] ; X,Y1,Y2 Drag Down
global cClickCopy := [1800,1600,140] ; X1 - First Copy, X2 - Next copy, Y 
global cClickPaste := [1800,140] ; X1 - First paste, X2 - Next paste, Y 
global cClickSelectAll2 := [1700,140,325] ; X1 - First Copy, X2 - Next copy, Y 
global cClickCopy2 := [1400,140] ; X, Y
global cClickYes := [1370,700] ; X, Y


;//////////////////////////////////////////////////////////////////////////////


;-------------------------------- Hot Keys -------------------------------------
CopyKey := "^+c"
PasteKey := "^+v"
TestKey := "^+t"



Hotkey %CopyKey%, Copy
Hotkey %PasteKey%, Paste
Hotkey %TestKey%, Test
return

;///////////////////////////////////////////////////////////////////////////////




;------------------------------ Labels -------------------------------------

Copy:

selectTextInJR()




if(firsCopy = true){
	Xp := Round(cClickCopy[1] * coefX)
	global firsCopy := false
}else{
	Xp := Round(cClickCopy[2] * coefX)
}

Yp := Round(cClickCopy[3] * coefY)

MouseClick, Left, Xp, Yp
;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,2

return



Paste:

WinGetPos, TargetWindowX1, TargetWindowY1, WindowWidth1, WindowHeight1, ahk_class Qt5QWindowToolSaveBits

changeWindow()

;Xp := Round(cClickYes[1] * coefX)  					;Click Yes
;Yp := Round(cClickYes[2] * coefY)
;MouseClick, Left, Xp, Yp
;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,1

Send {Tab 2, Enter}
Sleep,50

Xp := Round(cClickSelectAll2[1] * coefX)  					;Select all
Yp := Round(cClickSelectAll2[2] * coefY)
Yp2 := Round(cClickSelectAll2[3] * coefY)
Sleep,50
MouseClick, Left, Xp, Yp, 2
;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,1  ;select all
Sleep,50
MouseClick, Left, Xp, Yp2, 2
;ControlClick, x%Xp% y%Yp2%, ahk_class Qt5QWindowIcon,,Left,1  ;select all
Sleep,100


Xp := Round(cClickCopy2[1] * coefX)  ;Copy
Yp := Round(cClickCopy2[2] * coefY)

;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,1  ;Copy
;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,1  ;Copy
MouseClick, Left, Xp, Yp

Sleep,100

changeWindow()

Sleep,100

selectTextInJR()

Sleep,50

Xp := Round(cClickPaste[1] * coefX)  ;paste
Yp := Round(cClickPaste[2] * coefY)
MouseClick, Left, Xp, Yp

return



Test:

;selectTextInJR()

MsgBox, % firsCopy


return

#^+x::Exit




changeWindow(){
	WinGetPos, TargetWindowX, TargetWindowY, WindowWidth, WindowHeight, ahk_class Qt5QWindowIcon
	WinGetPos, TargetWindowX1, TargetWindowY1, WindowWidth1, WindowHeight1, ahk_class Qt5QWindowToolSaveBits
	
	Yp := WindowHeight1 - 20
	ControlClick, x20 y%Yp%,ahk_class Qt5QWindowToolSaveBits,,Left  ;Multi window
	WinActivate, ahk_class Qt5QWindowIcon 
	;MouseClick, Left, 20, Yp
	
	Xp := Round(WindowWidth / 2)
	Yp := Round(WindowHeight / 2)
	
	Sleep,300
	;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,1	;Change Window
	MouseClick, Left, Xp, Yp
	Sleep,500
}


copyCode(){
	
	
	
}


selectTextInJR(){
	WinGetPos, TargetWindowX, TargetWindowY, WindowWidth, WindowHeight, ahk_class Qt5QWindowIcon
	Sleep, 100
	
	send {PgUp}
	Sleep,100
	
	Xp := Round(cClickFirstWord[1] * coefX)
	Yp := Round(cClickFirstWord[2] * coefY)
	Sleep,5
	
	
	;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left, 
	
	MouseClick, Left, Xp, Yp, 2
	
	Sleep,100
	
	if(firsCopy = true){
		Xp := cClickSelectAll[1] * coefX
		Yp := cClickSelectAll[2] * coefY
	}else{
		Xp := cClickSelectAll[3] * coefX
		Yp := cClickSelectAll[4] * coefY
	}
	
	;ControlClick, x%Xp% y%Yp%, ahk_class Qt5QWindowIcon,,Left,2  ;Next selects all
	MouseClick,Left, Xp, Yp
	
	Xp := Round(WindowWidth / 2 )
	Yp := Round(WindowHeight / 2.3 )
	MouseMove, Xp,Yp
	
	Sleep,20
	
	Loop 30{
		Sleep,7
		send {WheelUp}
	}
	Sleep,100
	
	Xp := Round(cDragDownLine[1] * coefX)
	Yp := Round(cDragDownLine[2] * coefY)
	Yp2 := Round(cDragDownLine[3] * coefY)
	MouseClickDrag, Left, Xp, Yp, Xp, Yp2
	Sleep,50
	
}

























