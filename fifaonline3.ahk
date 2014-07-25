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
  Imagesearch,FoundX, FoundY, 0,0,width,height,fullFileName
  
  ;MsgBox ./%fileName%.png
  if ErrorLevel = 0
  {
    Coordmode,Mouse,window
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
  Loop, %path%.png,,1
  {
    imageMatch(A_LoopFileFullPath)
  }
}



^r::
reload
return

^q::
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
SetMouseDelay,100

loop 
{
  ;[1] 아래 이미지 파일 경로를 수정하세요
  runPath = C:\Users\dawnsea2\Desktop\fifaon
  
  ;이미지 파일 찾는 루프
  founded = 0
  Loop, %runPath%\*.png, ,1  
  {
    WinGetActiveTitle,foundWindow
    if (foundWindow != "FIFA")
    {
      continue
    }
    
    if (imageMatch(A_LoopFileFullPath) == 1)
   {
      founded = 1
    }
  }
  

  WinGetActiveTitle,foundWindow
  if (founded == 0 && foundWindow == "FIFA")
  {
    Send {Enter}
    
    Click,920,760
  }

if (foundWindow != "FIFA")
{
;DllCall("LockWorkStation")
break
}
  
  

  sleep,100
}
