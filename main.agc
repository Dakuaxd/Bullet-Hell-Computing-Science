// Name: Shaishav Shah, Dillon Ren
// Project: BULLET HELL 
// Created: 2018-04-27
// Last Edit: N/A

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "BULLET HELL" )
SetWindowSize( 720, 1280, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 720, 1280 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////// CODE STARTS HERE ////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LoadImage(1,"Plane.png")
CreateSprite(1,1)
SetSpriteScale(1,3,3)
px = GetVirtualWidth()/2 - GetSpriteWidth(1)/2
py = GetVirtualHeight() - GetSpriteHeight(1) - 40
SetSpriteVisible(1, 0)
SetSpritePosition(1,px,py)


// Variables
controlselect = 1 // for picking wasd or mouse (1 is mouse, 2 is wasd)
intro = 1
menu = 1
game = 0
controls = 0
shoot = 0
bulletcreate = 0
bulletshot = 0
bulletshot1 = 0
bulletshot2 = 0
bulletshot3 = 0
bulletshot4 = 0
bulletshot5 = 0
bulletshot6 = 0
x as integer[200]
y as integer [200]
bullet as integer[200]

gosub makebullets
gosub text
gosub Makedots
gosub bulletpositions
do
	gosub intro
	gosub menuselect
	gosub controls
	gosub movement
	if game = 1
		SetTextVisible(3,0)
		SetTextVisible(4,0)
		SetSpriteVisible(1,1)
		gosub Movedots
		gosub movebullets
	endif

    Sync()
loop

intro:
	if intro = 1
		
			if GetRawKeyPressed(13) // Enter key
				SetTextVisible(0,0) // added the word "OPERATION" in front for edge effect
				SetTextVisible(1,0)
				SetTextVisible(2,0)
				SetTextVisible(3,1)
				SetTextVisible(4,1)
				SetSpriteVisible(1, 0)
				menu = 1
			endif
		endif
return

menuselect:// clicking on the menu
	if GetPointerReleased()
		if GetTextHitTest(3, GetPointerX(), getpointery())
			game = 1
		else
			if GetTextHitTest(4, GetPointerX(), GetPointerY())
				Print("controls")// moving to controls subroutine
				controls = 1
			endif
		endif
	endif
return

controls:
	if controls = 1
		SetTextVisible(4, 0)
		SetTextVisible(3, 0)
		SetTextVisible(5, 1)
		SetTextVisible(6, 1)
		SetSpriteVisible(1, 1) // Make it so the sprite is visible in the control screen to test the controls
		if GetPointerReleased()
			if GetTextHitTest(5, GetPointerX(), GetpointerY())
				controlselect = 2 // clicking wasd
			endif
			if GetTextHitTest(6, GetPointerx(), GetPointery())
				controlselect = 1 // clicking mouse
			endif
		endif
		if GetRawKeyPressed(27) = 1 // hitting escape to go back
			SetTextVisible(4, 1)
			SetTextVisible(3, 1)
			SetTextVisible(5, 0)
			SetTextVisible(6, 0)
			SetSpriteVisible(1, 0)
			controls = 0
		endif
	endif
			
return

movement:
	if controlselect = 1 // mouse pointer control script
		SetSpritePosition(1, GetPointerX() - GetSpriteWidth(1)/2 , GetPointerY() - GetSpriteHeight(1)/2)
	endif
	if controlselect = 2 // wasd control script
		if GetRawKeyState(87) = 1
			py = py - 20
		endif
		if GetRawKeyState(83) = 1
			py = py + 20
		endif
		if GetRawKeyState(65) = 1
			px = px - 20
		endif
		if GetRawKeyState(68) = 1
			px = px + 20
		endif
// boundaries
		if px < 0
			px = 0
		endif
		if px > GetVirtualWidth() - GetSpriteWidth(1)
			px = GetVirtualWidth() - GetSpriteWidth(1)
		endif
		if py < 0
			py = 0
		endif
		if py > GetVirtualHeight() - GetSpriteHeight(1)
			py = GetVirtualHeight() - GetSpriteHeight(1)
		endif
		SetSpritePosition(1, px, py)
	endif
return

Text:
// for intro
	CreateText(0, "OPERATION")
	SetTextSize(0, 160)
	SetTextPosition(0, GetVirtualWidth()/2 - GetTextTotalWidth(0)/2, GetVirtualHeight()/2 - GetTextTotalHeight(0)/2 - 100)
	SetTextColor(0, 205,19,10,255)
	
	CreateText(1, "IRONCLAD")
	SetTextSize(1, 160)
	SetTextPosition(1, GetVirtualWidth()/2 - GetTextTotalWidth(1)/2, GetVirtualHeight()/2 - GetTextTotalHeight(1)/2)
	SetTextColor(1, 205,19,10,255)
	
	CreateText(2,"Click anywhere to begin")
	SetTextSize(2,30)
	SetTextPosition(2,GetVirtualWidth()/2 - GetTextTotalWidth(2)/2, GetVirtualHeight()/2 - GetTextTotalHeight(2)/2 + 100)
// For menu
	CreateText(3,"Play?")
	SetTextSize(3,170)
	SettextPosition(3,GetVirtualWidth()/2 - GetTextTotalWidth(3)/2,(GetVirtualHeight() - GetTextTotalHeight(3))/3 - 300)
	SettextVisible(3,0)
	
	CreateText(4, "Controls")
	SettextSize(4,170)
	SettextPosition(4,GetVirtualWidth()/2 - GetTextTotalWidth(4)/2, ((GetVirtualHeight() - GetTextTotalHeight(4))/3)*2 -300 )
	SetTextVisible(4,0)
// For Controls
	CreateText(5, "WASD")
	SetTextSize(5, 130)
	SetTextPosition(5, GetVirtualWidth()/2 - GetTextTotalWidth(5)/2, GetVirtualHeight()/2 - GetTExtTotalHeight(5)/2 - 200)
	SetTextVisible(5, 0)
	
	CreateText(6, "Mouse")
	SetTextSize(6, 130)
	SetTextPosition(6, GetVirtualWidth()/2 - GetTextTotalWidth(6)/2, GetVirtualHeight()/2 - GetTExtTotalHeight(6)/2 + 200)
	SetTextVisible(6, 0)
	
	
return

Makedots:
	CreateImageColor(5,255,255,255,255)
	for s=1 to 100
		CreateSprite(s+200,5)
		SetSpriteSize(s+200,2,2)
		SetSpritePosition(s+200,random(1,720),random(1,1280))
	next s
return

Movedots:
for s=1 to 100
	StarY=GetSpriteY(200+s) + 10
	If StarY>1280
		StarY=0
	EndIf
	SetSpritePosition(s+200,GetSpritex(s+200),StarY)
next s
Return

makebullets:
	LoadImage(99,"MediumBullet.png")
	for pb = 100 to 113
		CreateSprite(pb, 99)
		SetSpriteSize(pb, 20, 20)
		SetSpritePosition(pb, 1000, 2000)
	next pb
return

movebullets:
/*if GetPointerPressed() = 1 
	bulletshot = bulletshot + 1
	x[100] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100)/2
	y[100] = GetSpriteY(1)
endif

for i = 100 to 110
	if bulletshot = 100
		y[i] = y[i] - 30
		x[i] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100)/2
		SetSpritePosition(i, x[100], y[100])
		if y[i] < -20
			bulletshot = 99
		endif
		SetSpriteY(i, 2000)
	endif
next i*/
print(GetSeconds())
print(y[100])
print(y[102])
print(y[104])
print(y[106])
print(y[108])
print(y[110])
print(y[112])
	if GetPointerPressed() = 1 and bulletshot = 0 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0
		x[100] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[101] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[100] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[101] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot = 1
	endif
	if bulletshot = 1
		y[100] = y[100] - 100
		y[101] = y[101] - 100
		SetSpritePosition(100, x[100], y[100])
		SetSpritePosition(101, x[101], y[101])
	endif
	
	if y[112] < -100
		bulletshot6 = 0
	endif

	if GetPointerPressed() = 1 and bulletshot = 1 and y[100] < GetSpriteY(1) - 600 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0
		x[102] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[103] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[102] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[103] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot1 = 1
	endif
	if bulletshot1 = 1
		y[102] = y[102] - 100
		y[103] = y[103] - 100
		SetSpritePosition(102, x[102], y[102])
		SetSpritePosition(103, x[103], y[103])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif

		
	if GetPointerPressed() = 1 and bulletshot1 = 1 and y[102] < GetSpriteY(1) - 600 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0
		x[104] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[105] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[104] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[105] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot2 = 1
	endif
	if bulletshot2 = 1
		y[104] = y[104] - 100
		y[105] = y[105] - 100
		SetSpritePosition(104, x[104], y[104])
		SetSpritePosition(105, x[105], y[105])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif
	
	if y[102] < -100
		bulletshot1 = 0
	endif

	if GetPointerPressed() = 1 and bulletshot2 = 1 and y[104] < GetSpriteY(1) - 600 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0 and bulletshot1 = 0
		x[106] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[107] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[106] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[107] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot3 = 1
	endif
	if bulletshot3 = 1
		y[106] = y[106] - 100
		y[107] = y[107] - 100
		SetSpritePosition(106, x[106], y[106])
		SetSpritePosition(107, x[107], y[107])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif
	
	if y[102] < -100
		bulletshot1 = 0
	endif

	if y[104] < -100
		bulletshot2 = 0
	endif
	
	if GetPointerPressed() = 1 and bulletshot3 = 1 and y[106] < GetSpriteY(1) - 600 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0 and bulletshot1 = 0 and bulletshot2 = 0
		x[108] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[109] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[108] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[109] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot4 = 1
	endif
	if bulletshot4 = 1
		y[108] = y[108] - 100
		y[109] = y[109] - 100
		SetSpritePosition(108, x[108], y[108])
		SetSpritePosition(109, x[109], y[109])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif
	
	if y[102] < -100
		bulletshot1 = 0
	endif

	if y[104] < -100
		bulletshot2 = 0
	endif
	
	if y[106] < -100
		bulletshot3 = 0
	endif

	if GetPointerPressed() = 1 and bulletshot4 = 1 and y[108] < GetSpriteY(1) - 600 and bulletshot5 = 0 and bulletshot = 0 and bulletshot6 = 0 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0
		x[110] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[111] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[110] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[111] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot5 = 1
	endif
	if bulletshot5 = 1
		y[110] = y[110] - 100
		y[111] = y[111] - 100
		SetSpritePosition(110, x[110], y[110])
		SetSpritePosition(111, x[111], y[111])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif
	
	if y[102] < -100
		bulletshot1 = 0
	endif

	if y[104] < -100
		bulletshot2 = 0
	endif
	
	if y[106] < -100
		bulletshot3 = 0
	endif
	
	if y[108] < -100
		bulletshot4 = 0
	endif
	
	if GetPointerPressed() = 1 and bulletshot5 = 1 and y[110] < GetSpriteY(1) - 600 and bulletshot = 0  and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot6 = 0
		x[112] = GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(100) - GetSpriteWidth(100)/2
		x[113] = GetSpriteX(1) + GetSpriteWidth(1)/2 + GetSpriteWidth(100) - GetSpriteWidth(100)/2
		y[112] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		y[113] = GetSpriteY(1) + GetSpriteHeight(1)/2 - GetSpriteHeight(100)
		bulletshot6 = 1
	endif
	if bulletshot6 = 1
		y[112] = y[112] - 100
		y[113] = y[113] - 100
		SetSpritePosition(112, x[112], y[112])
		SetSpritePosition(113, x[113], y[113])
	endif
	
	if y[100] < -100
		bulletshot = 0
	endif
	if y[102] < -100
		bulletshot1 = 0
	endif
	if y[104] < -100
		bulletshot2 = 0
	endif
	if y[106] < -100
		bulletshot3 = 0
	endif
	if y[108] < -100
		bulletshot4 = 0
	endif
	if y[110] < -100
		bulletshot5 = 0
	endif
return

bulletpositions:
	for i = 100 to 113
		x[i] = 2000
		y[i]  = 1000
		SetSpritePosition(i, x[ i], y[i] )
	next i
return
