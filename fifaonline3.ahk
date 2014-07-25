;--------------------------------------------------
; 현재 체크 대상 APP 가 ACTIVE 인지 확인한다.
;--------------------------------------------------
checkApp()
{
  WinGetActiveTitle,title
  checkTitle = FIFA
  OutputDebug, %title%, %checkTitle%
  if (title = checkTitle)
  {
    return true
  }
  return false
}

;--------------------------------------------------
; 액티브 윈도우의 크기를 구해온다
;--------------------------------------------------
getWindowRect(ByRef width, ByRef height)
{
  WinGet,activeWinID,ID,A
  WinGetPos,,,width,height,ahk_id %activeWinID%
}

;--------------------------------------------------
; 이미지 파일 검색, 대상은 전체 윈도우 크기
;--------------------------------------------------
imageMatch(fullFileName,bClick=true)
{
  getWindowRect(width,height)

      
	CoordMode,pixel,relative
  Imagesearch,FoundX, FoundY, 0,0,width,height,%fullFileName%
  OutputDebug, %fullFileName%, %width%, %height%, %ErrorLevel%
  if ErrorLevel = 0
  {
    Coordmode,Mouse,Relative
    MouseMove,FoundX,FoundY
    if (bClick=true)
    {
      Click,FoundX,FoundY
    }
    return true
  }
  return false
}

;--------------------------------------------------
; 특정 폴더안의 모든 이미지를 순환하면서 있으면 해당 위치를 클릭
; png 만 지원함. 일단
;--------------------------------------------------
findandClickImages(path)
{
  Loop, %path%\*.png,,1
  {
    if (checkApp()=false)
    {
      break
    }
    imageMatch(A_LoopFileFullPath)
  }
}

;--------------------------------------------------
; 마우스 이동하여 클릭
;--------------------------------------------------
moveClick(x,y)
{
  ;MsgBox %x%,%y%
  MouseMove,x,y
  Click,x,y
}

;--------------------------------------------------
; 엔트리 포인트
;--------------------------------------------------
MsgBox,8192,,반복 클릭 시작점에서 CTRL+A를 누르세요


;--------------------------------------------------
; 이하 단축키 처리
;--------------------------------------------------
^r::
  if (LockWindow=1)
  {
    DllCall("LockWorkStation")
    ExitApp
  }
  reload
return

^q::
  if (LockWindow=1)
  {
    DllCall("LockWorkStation")
    ExitApp
  }
   pause
return

^g::
  getWindowRect(width, height)
  WinGetPos,,,width,height,ahk_id %activeWinID%
  
  MouseGetPos, MouseX, MouseY
  PixelGetColor, color, %MouseX%, %MouseY%
  MsgBox The color at the current cursor position is %color%. %MouseX%, %MouseY% `nYour gui's client area is %width% by %height%
return

^a::
  MouseGetPos, startX, startY
  imagePath = C:\Users\dawnsea2\Desktop\fifaon
  
  Gui, Add, Text,,이 위치 %startX%,%startY%를 반복 클릭 시도 합니다.`n이제 찾아 클릭할 이미지가 있는 폴더를 입력해주세요
  Gui, Add, Edit, vImagePath w300, %imagePath%
  Gui, Add, Checkbox, vLockWindow yp+25, 실행 중단시 윈도우 잠금
  Gui, Add, Button, w100 xp+200 yp+25, 시작
  GuiControl, +default, 시작
  Gui, Show
return

Button시작:
  Gui,Submit
  OutputDebug,%imagePath% %startX%,%startY%,%LockWindow%
  Gui,Destroy
  
  SetMouseDelay,100
  CoordMode,mouse,Relative
  
  loop 
  {
    sleep,500
      
    ;[*] 포커스 벗어난 경우 이탈
    if (checkApp()=false)
    {
      if (LockWindow=1)
      {
        DllCall("LockWorkStation")
        ExitApp
      }
      continue
    }
    
    ;[1] 지정한 위치 클릭 시도
    moveClick(startX,startY)
    
    ;[2] 캡처한 이미지가 있는지 클릭 시도
    findandClickImages(imagePath)
    
    ;[3] 엔터키를 일단 시도
    Send {Enter}
    
    ;[4] 다음 버튼의 대략의 위치 *0.93, *0.95
    ;getWindowRect(width, height)
    ;moveClick(width*0.93, height*0.95)
    
    ;[*] 포커스 벗어난 경우 이탈
    if (checkApp()=false)
    {
      if (LockWindow=1)
      {
        DllCall("LockWorkStation")
        ExitApp
      }
      continue
    }
  }
return
