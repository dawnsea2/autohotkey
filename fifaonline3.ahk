;--------------------------------------------------
; ��Ƽ�� �������� ũ�⸦ ���ؿ´�
;--------------------------------------------------
getWindowRect(ByRef width, ByRef height)
{
  WinGet,activeWinID,ID,A
  WinGetPos,,,width,height,ahk_id %activeWinID%
}

;--------------------------------------------------
; �̹��� ���� �˻�, ����� ��ü ������ ũ��
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
; Ư�� �������� ��� �̹����� ��ȯ�ϸ鼭 ������ �ش� ��ġ�� Ŭ��
; png �� ������. �ϴ�
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
  ;[1] �Ʒ� �̹��� ���� ��θ� �����ϼ���
  runPath = C:\Users\dawnsea2\Desktop\fifaon
  
  ;�̹��� ���� ã�� ����
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
