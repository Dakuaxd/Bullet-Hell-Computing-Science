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
menuselect = 1
movementtype = 1

do
	gosub menuselect
	gosub movement
    Sync()
loop


menuselect:// dillon's
	if menuselect = 1
		print("Mouse Pointer Control Type")
	else
		ClearScreen()
	endif
	if menuselect = 2
		print("WASD Control Type")
	else
		ClearScreen()
	endif
	if GetRawKeyPressed(40) = 1
		menuselect = menuselect + 1
	endif
	if GetRawKeyPressed(38) = 1
		menuselect = menuselect - 1
	endif
	if menuselect < 1
		menuselect = 2
	endif
	if menuselect > 2
		menuselect = 1
	endif
	
return

movement:// Dillon's
	if menuselect = 1
		SetSpritePosition(1, GetPointerX() - GetSpriteWidth(1)/2 , GetPointerY() - GetSpriteHeight(1)/2)
	endif
	if menuselect = 2
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
