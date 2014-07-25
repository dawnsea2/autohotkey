checkApp()
{
  ;지니모션일때만
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

;혼탑 좌표를 얻어오기
towerDestX = 0
towerDestY = 0

Gui, Add, Text,, 입창할 층의 위치를 적습니다 (CTRL+G 참고)
Gui, Add, Edit, vtowerDestX w50, %towerDestX%
Gui, Add, Edit, vtowerDestY w50 xp+60, %towerDestY%
Gui, Add, Button, w100 xp+60, 시작
GuiControl, +default, 시작

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
    MsgBox 지니모션에서만 실행됩니다
    return
  }
  
  Gui,Show
  return

Button시작:
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
    
    ;어플 바뀌면 검사 안함
    if (checkApp() = false)
    {
      MsgBox 포커스가 벗어나서 매크로를 중지합니다
      return
    }

    ;혼탑화면인지 검사
    PixelGetColor,color,650,127
    if (color & 0xF0F0F0 = 0XF0F0F0)
    {
      moveClick(towerDestX,towerDestY)
      continue
    }
     
    ;혼탑층입장/나가기 버튼옆 도전하기 찾기
    if (colorMatch(1264,737,0x0B0B3A,false))
    {
      ;도전하기 클릭
      moveClick(913,713)
      continue
    }

    ;영웅 배치화면
    if (colorMatch(22,41,0x262B2D,false))
    { 
      ;전투시작 클릭
      moveClick(913,713)
      sleep 1000
      
      ;전투경고
      if (imageMatch(500,150,"a",false))
      {
        if (imageMatch(602,386,"b",false) = false)
        {
          MsgBox 영웅 수가 맞지 않습니다. 설정을 마친 후 CTRL+A부터 다시..
          return
        }
      }
      
      ;무시하고 도전하기
      moveClick(534,607)
      sleep 1000
    }
       
    ;보너스선택
    if (colorMatch(584,459,0x486077,true))
    { 
      Sleep 2000
      moveClick(584,459)
      continue
    }
    
    ;결과확인
    if (colorMatch(255,213,0x2B180B,false))
    { 
      moveClick(312,752)
      continue
    }

	sleep,1000
  	
  }
  return
  

