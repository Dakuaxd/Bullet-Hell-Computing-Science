// Name: Shaishav Shah, Dillon Ren
// Project: BULLET HELL 
// Created: 2018-04-27
// Last Edit: 2018-05-06

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "BULLET HELL" )
SetWindowSize( 768, 1024, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 768, 1024 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////// CODE STARTS HERE ////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LoadImage(1,"Plane.png")
CreateSprite(1,1)
SetSpriteScale(1,0.75,0.75)
px = GetVirtualWidth()/2 - GetSpriteWidth(1)/2
py = GetVirtualHeight() - GetSpriteHeight(1) - 40
SetSpriteVisible(1, 0)
SetSpritePosition(1,px,py)

LoadImage(999, "Bigbullet.png")
CreateSprite(999,999)
SetSpriteScale(999,3,3)
SetSpritePosition(999, 9000,9000) // off the screen
ex as integer[300]
ey as integer[300]

gosub makeenemy
gosub variables
gosub makebullets
gosub text
//gosub Makedots
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
		gosub bigbullet
		//gosub Movedots
		gosub movebullets
		gosub level1
	endif

    Sync()
loop
variables:
// Variables
	controlselect = 1 // for picking wasd or mouse (1 is mouse, 2 is wasd)
	intro = 1
	menu = 0
	game = 0
	controls = 0
	shoot = 0
	bulletcreate = 0
	bulletshot = 0
	bulletshot1 = 0
	bulletshot2 = 0
	bulletshot3 = 0
	powerup = 0
	bigbullety = 0
	bigbulletx = 0
	level1bullet = 0
	plane as integer [50]
	x as integer[200]
	y as integer [200]
	bullet as integer[200]
	setplane as integer[50]
	eby as integer[501]
	ebx as integer[501]

return
intro:
	if intro = 1
		
			if GetPointerReleased() // LEft Click 
				DeleteText(0) // added the word "OPERATION" in front for edge effect
				DeleteText(1)
				DeleteText(2)
				menu = 1
				intro = 0
			endif
		endif
return

menuselect:// clicking on the menu
	if menu = 1
		
		SettextPosition(3,GetVirtualWidth()/2 - GetTextTotalWidth(3)/2,(GetVirtualHeight() - GetTextTotalHeight(3))/3 - 300)
		SettextPosition(4,GetVirtualWidth()/2 - GetTextTotalWidth(4)/2, ((GetVirtualHeight() - GetTextTotalHeight(4))/3)*2 -300 )
		SetSpriteVisible(1, 0)
		if GetPointerPressed()
			if GetTextHitTest(3, GetPointerX(), getpointery())
				game = 1
				menu = 0
				resettimer()
				SettextPosition(3,9000,9000)
				SettextPosition(4,9000,9000)
				SetTextPosition(5,9000,9000)
				SetTextPosition(6,9000,9000)
			else
				if GetTextHitTest(4, GetPointerX(), GetPointerY())
					controls = 1
					menu = 0
					SettextPosition(3,9000,9000)
					SettextPosition(4,9000,9000)
				endif
			endif
		endif
	endif
return

controls:
	if controls = 1
		SettextPosition(3,9000,9000)
		SettextPosition(4,9000,9000)
		SetTextPosition(5, GetVirtualWidth()/2 - GetTextTotalWidth(5)/2, GetVirtualHeight()/2 - GetTExtTotalHeight(5)/2 - 200)
		SetTextPosition(6, GetVirtualWidth()/2 - GetTextTotalWidth(6)/2, GetVirtualHeight()/2 - GetTExtTotalHeight(6)/2 + 200)
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
			SettextPosition(3,GetVirtualWidth()/2 - GetTextTotalWidth(3)/2,(GetVirtualHeight() - GetTextTotalHeight(3))/3 - 300)
			SettextPosition(4,GetVirtualWidth()/2 - GetTextTotalWidth(4)/2, ((GetVirtualHeight() - GetTextTotalHeight(4))/3)*2 -300 )
			SetTextPosition(5,9000,9000)
			SetTextPosition(6,9000,9000)
			SetSpriteVisible(1, 0)
			controls = 0
			menu = 1
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
	SettextPosition(3,9000,9000)

	CreateText(4, "Controls")
	SettextSize(4,170)
	SetTextPosition(4,9000,9000)
	
// For Controls
	CreateText(5, "WASD")
	SetTextSize(5, 130)
	SetTextPosition(5,9000,9000)

	CreateText(6, "Mouse")
	SetTextSize(6, 130)
	SetTextPosition(6,9000,9000)
	

	
return

Makedots:
	CreateImageColor(5,255,255,255,255)
	for s=1 to 100
		CreateSprite(s+1200,5)
		SetSpriteSize(s+1200,2,2)
		SetSpritePosition(s+1200,random(1,720),random(1,1280))
	next s
return

Movedots:
for s=1 to 100
	StarY=GetSpriteY(1200+s) + 10
	If StarY>1280
		StarY=0
	EndIf
	SetSpritePosition(s+1200,GetSpritex(s+1200),StarY)
next s
Return

makebullets: // **Literally all of this is to make sure the bullets smoothly get fired and don't have a huge gap inbetween them (7 sets of bullets)
	LoadImage(99,"Playerbullets.png")
	for pb = 100 to 113
		CreateSprite(pb, 99)
		SetSpriteScale(pb,1.5,2)
		SetSpritePosition(pb, 1000, 2000)
	next pb

 // enemy bullets
	LoadImage(55,"MediumBullet.png")
	for i = 300 to 500
		CreateSprite(i,55)
		SetSpriteSize(i,20,20)
		ebx[i] = 9000
		eby[i] = 9000
		SetSpritePosition(i,ebx[i], eby[i])
	 next i
	 
	for i = 300 to 305
		ebx[i] = 9000
		eby[i] = 9000
		SetSpritePosition(i, ebx[i], eby[i])
	next i 
	
 return
	 
movebullets:
print(Timer())
print(y[100])
print(y[102])
print(y[104])
print(y[106])
print(y[108])
print(y[110])
print(y[112])
print(ey[1])
print(eby[300])
	if GetPointerReleased() = 1 and bulletshot = 0 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0
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

	if GetPointerReleased() = 1 and bulletshot = 1 and y[100] < GetSpriteY(1) - 600 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0
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

		
	if GetPointerReleased() = 1 and bulletshot1 = 1 and y[102] < GetSpriteY(1) - 600 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0
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

	if GetPointerReleased() = 1 and bulletshot2 = 1 and y[104] < GetSpriteY(1) - 600 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0 and bulletshot1 = 0
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
	
	if GetPointerReleased() = 1 and bulletshot3 = 1 and y[106] < GetSpriteY(1) - 600 and bulletshot4 = 0 and bulletshot5 = 0 and bulletshot6 = 0 and bulletshot = 0 and bulletshot1 = 0 and bulletshot2 = 0
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

	if GetPointerReleased() = 1 and bulletshot4 = 1 and y[108] < GetSpriteY(1) - 600 and bulletshot5 = 0 and bulletshot = 0 and bulletshot6 = 0 and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0
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
	
	if GetPointerReleased() = 1 and bulletshot5 = 1 and y[110] < GetSpriteY(1) - 600 and bulletshot = 0  and bulletshot1 = 0 and bulletshot2 = 0 and bulletshot3 = 0 and bulletshot4 = 0 and bulletshot6 = 0
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

bigbullet:
	if GetRawKeyPressed(66) = 1  and powerup = 0// Space key
		bigbullety = GetSpriteY(1)
		bigbulletx = GetSpriteX(1)
		SetSpritePosition(999, GetSpriteX(1) + GetSpriteWidth(1)/2 - GetSpriteWidth(999)/2, GetspriteY(1))
		powerup = 1
	endif

	if powerup = 1
		bigbullety = bigbullety - 40
		SetSpritePosition(999,bigbulletx + GetSpriteWidth(1)/2 - GetSpriteWidth(999)/2, bigbullety)
	endif
		
	
	if bigbullety < GetSpriteY(1) - 1024
		powerup = 0
			SetSpritePosition(999,9000,9000) // hiding it again
	endif
return

makeenemy:

	LoadImage(666, "Planebad.png")
	for i = 200 to 250
		CreateSprite(i, 666)
		SetSpriteFlip(i,0,1)
		SetSpriteScale(i,0.75,0.75)
		ex[i] = 9000
		ey[i] = 9000
		SetSpritePosition(i, ex[i], ey[i])
	next i
	
	for i = 0 to 50
		plane[1] = 1
	next i 
	
return

level1:
	if setplane[1] = 0
		ey[1] = -10
		ex[1] = GetVirtualWidth()/2
		SetSpritePosition(200,ex[1],ey[1])
		setplane[1] = 1
	endif
	if not ey[1] > GetVirtualHeight() and plane[1] = 1
		ey[1] = ey[1] + 2
		SetSpritePosition(200, ex[1],ey[1])
	endif
	if ey[1] > GetVirtualHeight()
		SetSpritePosition(200,9000,9000)
	endif

/*
	If Timer() < 1
		ebx[300] = GetSpriteX(200) + GetSpriteWidth(200)/2 - GetSpriteWidth(300)/2
		eby[300] = GetSpriteY(200) + GetSpriteHeight(200)/2 - GetSpriteheight(300)/2
		SetSpritePosition(300, ebx[300], eby[300])
	endif
	if Timer() > 1
		eby[300] = eby[300] + 20
		SetSpritePosition(300, ebx[300], eby[300])
	endif 
	*/
	
	for i = 300 to 300
		If Timer() < 1
			ebx[i] = GetSpriteX(200) + GetSpriteWidth(200)/2 - GetSpriteWidth(i)/2
			eby[i] = GetSpriteY(200) + GetSpriteHeight(200)/2 - GetSpriteheight(i)/2
			SetSpritePosition(i, ebx[i], eby[i])
		endif
		if Timer() > 1
			eby[i] = eby[i] + 20
			SetSpritePosition(i, ebx[i], eby[i])
		endif 
		if eby[i] > GetVirtualHeight()
			SetSpritePosition(i,9000,9000)
			ResetTimer()
		endif
	next i
	
	
	for i = 100 to 113
		if GetSpriteCollision(i,200)
			ex[1] = GetVirtualWidth()/2
			ey[1] = 0-GetSpriteHeight(200)
			plane[1] = 0
			SetSpritePosition(200,ex[1], ey[1])
		endif
	next i
	
	
return
