checkApp()
{
  ;���ϸ���϶���
  WinGetActiveTitle,title
  if InStr(title,"Genymotion") = 0
  {
    return false
  }
  return true
}

moveClick(x,y)
{
  MouseMove,x,y
  Click,x,y
}

imageMatch(x,y,fileName,bClick=true)
{
	CoordMode,pixel,relative
  Imagesearch,FoundX, FoundY, x,y,x+500,y+500,./%fileName%.png
  
  ;MsgBox ./%fileName%.png
	if ErrorLevel = 0
	{
	  if (bClick=true)
	  {
	    moveClick(FoundX,FoundY)
	  }
		return true
	}
  return false
}

colorMatch(x,y,color,bClick=true)
{
  CoordMode,pixel,relative
  PixelGetColor, gColor, x, y
  ;MsgBox %gColor%,%color%,%x%,%y%
  if (color = gColor)
  {
    if (bClick=true)
	  {
	    moveClick(x,y)
	  }
		return true
  }
  return false
}

loopCheck = 0

;ȥž ��ǥ�� ������
towerDestX = 0
towerDestY = 0

Gui, Add, Text,, ��â�� ���� ��ġ�� �����ϴ� (CTRL+G ����)
Gui, Add, Edit, vtowerDestX w50, %towerDestX%
Gui, Add, Edit, vtowerDestY w50 xp+60, %towerDestY%
Gui, Add, Button, w100 xp+60, ����
GuiControl, +default, ����

return

^g::
  MouseGetPos, MouseX, MouseY
  PixelGetColor, color, %MouseX%, %MouseY%
  MsgBox The color at the current cursor position is %color%. %MouseX%, %MouseY%
  reload
  return

^r::
  reload
  return

^q::
  pause
  return

^a::
  loopCheck = 1

  if (checkApp() = false)
  {
    MsgBox ���ϸ�ǿ����� ����˴ϴ�
    return
  }
  
  Gui,Show
  return

Button����:
  Gui,Submit
  loopCheck = 0
  ;;;;;;;;;;;;;;;;;;;;;;;;;;
  SetMouseDelay,100
  CoordMode,pixel,relative
  
  loop 
  {
   ; if (loopCheck = 1)
    ;{
   ;   return
   ; }
    
    ;���� �ٲ�� �˻� ����
    if (checkApp() = false)
    {
      MsgBox ��Ŀ���� ����� ��ũ�θ� �����մϴ�
      return
    }

    ;ȥžȭ������ �˻�
    PixelGetColor,color,650,127
    if (color & 0xF0F0F0 = 0XF0F0F0)
    {
      moveClick(towerDestX,towerDestY)
      continue
    }
     
    ;ȥž������/������ ��ư�� �����ϱ� ã��
    if (colorMatch(1264,737,0x0B0B3A,false))
    {
      ;�����ϱ� Ŭ��
      moveClick(913,713)
      continue
    }

    ;���� ��ġȭ��
    if (colorMatch(22,41,0x262B2D,false))
    { 
      ;�������� Ŭ��
      moveClick(913,713)
      sleep 1000
      
      ;�������
      if (imageMatch(500,150,"a",false))
      {
        if (imageMatch(602,386,"b",false) = false)
        {
          MsgBox ���� ���� ���� �ʽ��ϴ�. ������ ��ģ �� CTRL+A���� �ٽ�..
          return
        }
      }
      
      ;�����ϰ� �����ϱ�
      moveClick(534,607)
      sleep 1000
    }
       
    ;���ʽ�����
    if (colorMatch(584,459,0x486077,true))
    { 
      Sleep 2000
      moveClick(584,459)
      continue
    }
    
    ;���Ȯ��
    if (colorMatch(255,213,0x2B180B,false))
    { 
      moveClick(312,752)
      continue
    }

	sleep,1000
  	
  }
  return
  

