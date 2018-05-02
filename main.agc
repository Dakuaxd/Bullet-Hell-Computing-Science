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
SetSpritePosition(1,px,py)


// Variables
controlselect = 1
menuselect = 1
movementtype = 1
intro = 1
menu = 1
wasd = 1
mouse = 0
game = 0
controls = 0

gosub text
do
	if intro = 1
		gosub intro
	endif
	if menu = 1
		gosub menuselect
	endif
	gosub controls
	gosub movement

    Sync()
loop

intro:
	if GetPointerReleased() = 1 // Enter key
		SetTextVisible(1,0)
		SetTextVisible(2,0)
		SetTextVisible(3,1)
		SetTextVisible(4,1)
	endif
return

menuselect:// dillon's
	if GetPointerReleased()
		if GetTextHitTest(3, GetPointerX(), getpointery())
			Print("playing game")
			game = 1
		else
			if GetTextHitTest(4, GetPointerX(), GetPointerY())
				Print("controls")
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
		if GetPointerReleased()
			if GetTextHitTest(5, GetPointerX(), GetpointerY())
				controlselect = 2
			endif
			if GetTextHitTest(6, GetPointerx(), GetPointery())
				controlselect = 1
			endif
		endif
		if GetRawKeyPressed(27) = 1
			SetTextVisible(4, 1)
			SetTextVisible(3, 1)
			SetTextVisible(5, 0)
			SetTextVisible(6, 0)
			controls = 0
		endif
	endif
			
return

movement:
	if controlselect = 1
		SetSpritePosition(1, GetPointerX() - GetSpriteWidth(1)/2 , GetPointerY() - GetSpriteHeight(1)/2)
	endif
	if controlselect = 2
		if GetRawKeyState(87) = 1
			py = py - 12
		endif
		if GetRawKeyState(83) = 1
			py = py + 12
		endif
		if GetRawKeyState(65) = 1
			px = px - 12
		endif
		if GetRawKeyState(68) = 1
			px = px + 12
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
