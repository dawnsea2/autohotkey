;--------------------------------------------------
; ���� üũ ��� APP �� ACTIVE ���� Ȯ���Ѵ�.
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
; Ư�� �������� ��� �̹����� ��ȯ�ϸ鼭 ������ �ش� ��ġ�� Ŭ��
; png �� ������. �ϴ�
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
; ���콺 �̵��Ͽ� Ŭ��
;--------------------------------------------------
moveClick(x,y)
{
  ;MsgBox %x%,%y%
  MouseMove,x,y
  Click,x,y
}

;--------------------------------------------------
; ��Ʈ�� ����Ʈ
;--------------------------------------------------
MsgBox,8192,,�ݺ� Ŭ�� ���������� CTRL+A�� ��������


;--------------------------------------------------
; ���� ����Ű ó��
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
  
  Gui, Add, Text,,�� ��ġ %startX%,%startY%�� �ݺ� Ŭ�� �õ� �մϴ�.`n���� ã�� Ŭ���� �̹����� �ִ� ������ �Է����ּ���
  Gui, Add, Edit, vImagePath w300, %imagePath%
  Gui, Add, Checkbox, vLockWindow yp+25, ���� �ߴܽ� ������ ���
  Gui, Add, Button, w100 xp+200 yp+25, ����
  GuiControl, +default, ����
  Gui, Show
return

Button����:
  Gui,Submit
  OutputDebug,%imagePath% %startX%,%startY%,%LockWindow%
  Gui,Destroy
  
  SetMouseDelay,100
  CoordMode,mouse,Relative
  
  loop 
  {
    sleep,500
      
    ;[*] ��Ŀ�� ��� ��� ��Ż
    if (checkApp()=false)
    {
      if (LockWindow=1)
      {
        DllCall("LockWorkStation")
        ExitApp
      }
      continue
    }
    
    ;[1] ������ ��ġ Ŭ�� �õ�
    moveClick(startX,startY)
    
    ;[2] ĸó�� �̹����� �ִ��� Ŭ�� �õ�
    findandClickImages(imagePath)
    
    ;[3] ����Ű�� �ϴ� �õ�
    Send {Enter}
    
    ;[4] ���� ��ư�� �뷫�� ��ġ *0.93, *0.95
    ;getWindowRect(width, height)
    ;moveClick(width*0.93, height*0.95)
    
    ;[*] ��Ŀ�� ��� ��� ��Ż
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
