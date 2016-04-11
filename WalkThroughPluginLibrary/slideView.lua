-- slideView.lua
--
-- Version 1.0
--
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in the
-- Software without restriction, including without limitation the rights to use, copy,
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
-- and to permit persons to whom the Software is furnished to do so, subject to the
-- following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies
-- or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.

module(..., package.seeall)

local WalkThroughUtilities = require("WalkThroughPluginLibrary.WalkThroughUtilities")
local YOUTUBE_URL = "https://www.youtube.com/embed/HWGtGdePGaw"
--local ThirdPartyCallLua = require "ThirdPartyCallLua"

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
local popupHeight = 0
local imgNum = nil
local images = nil
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local imageNumberText, imageNumberTextShadow
local g , dot1 , dot2 , dot3 , webView , showPerkPointsIcon  , login_text_authentication , facebook_authentication , buttontext
local dot_size_fix = 0.04

local dots_y_coordinate = display.contentHeight * 0.72
if (WalkThroughUtilities.detectDeviceType() == "iPad") then
  dots_y_coordinate = display.contentHeight * 0.68
end
if (WalkThroughUtilities.getOrientation() == "landscape")  then
  print( "This Section Called -- > iPhone rest" )
  if (system.getInfo( "platformName" ) == "Android") then
    dots_y_coordinate = display.contentHeight * 0.67
    dot_size_fix = 0.03
  else
    if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
      dots_y_coordinate = display.contentHeight * 0.67
      dot_size_fix = 0.026
    else
      dots_y_coordinate = display.contentHeight * 0.63
      dot_size_fix = 0.03
    end
  end


end

function goToAppsaholicPortal(event)
    if ( event.phase == "began" ) then
    elseif ( event.phase == "ended" ) then
        print( "Will Redirect to Appsaholic Portal" )
       -- ThirdPartyCallLua.testFunction()
				display.remove( g )
    end
    return true
end


function new( imageSet, slideBackground, top, bottom )
	local pad = 20
	local top = top or 0
	local bottom = bottom or 0
	popupHeight = 0
	g = display.newGroup()

	if slideBackground then
		background = display.newImage(slideBackground, 0, 0, true)
	else
		background = display.newRect( 0, 0, screenW, screenH-(top+bottom) )

		-- set anchors on the background
		background.anchorX = 0
		background.anchorY = 0

		background:setFillColor(0.1,0.1,0.1)
	end
	g:insert(background)

	images = {}
	for i = 1,#imageSet do
		local p = display.newImage(imageSet[i])
		local h = viewableScreenH
		if p.width > viewableScreenW or p.height > h then
			if p.width/viewableScreenW > p.height/h then

        if (system.getInfo( "platformName" ) == "Android") then
          print( "This Section Called - > Android" )

          if WalkThroughUtilities.getOrientation() == "portrait" then
            p.xScale = viewableScreenW/(p.width * 0.9)
            p.yScale = viewableScreenW/ (p.width * 0.9)
          else
            p.xScale = viewableScreenW/(p.width * 0.93  )
            p.yScale = viewableScreenW/ (p.width * 0.93 )
          end
        else
          if WalkThroughUtilities.getOrientation() == "portrait" then
            print( "This Section Called -- > iPhone rest" )
            if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
              print( "This Section Called -- > iPad and iPhone 4s" )
              p.xScale = viewableScreenW/(p.width  )
              p.yScale = viewableScreenW/ (p.width )
            else
              p.xScale = viewableScreenW/(p.width * 0.84)
              p.yScale = viewableScreenW/ (p.width * 0.84)
            end
          else
            print( "This Section Called -- > iPhone rest LansScape" )
            if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
              print( "This Section Called -- > iPad and iPhone 4s LansScape Width and height Scaling" )
              p.xScale = h/(p.height * 1.42)
              p.yScale = h/(p.height * 1.42)
            else
              p.xScale = h/(p.height * 1.25)
              p.yScale = h/(p.height * 1.25)
            end
          end
        end
			else
          print( "This Section Called Rest -> lanscape" )
					p.xScale = h/p.height
					p.yScale = h/p.height
			end
		end
		g:insert(p)

		if (i > 1) then
      p.x = screenW*1.6 + pad -- all images offscreen except the first one
		else
			p.x = screenW*.5
		end
    if WalkThroughUtilities.getOrientation() == "portrait" then
      print( "This Section Called -- > iPhone rest" )
      p.y = h*.38
    else
      print( "This Section Called -- > iPhone rest LansScape" )
      if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
        print( "This Section Called -- > iPad and iPhone 4s LansScape Width and height Scaling" )
        p.y = h*.35
      else
        p.y = h*.39
      end
    end
		images[i] = p
	end

	local defaultString = "1 of " .. #images

    if WalkThroughUtilities.getOrientation() == "portrait" then
      buttontext = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_signup_text.png")
      buttontext.height = WalkThroughUtilities.getNewHeight(buttontext,display.contentWidth * 0.8)
      buttontext.width = display.contentWidth * 0.8
      buttontext.x = display.contentWidth / 2
      buttontext.y = display.contentHeight * 0.8
      if (WalkThroughUtilities.detectDeviceType() == "iPad") then
        buttontext.height = WalkThroughUtilities.getNewHeight(buttontext,display.contentWidth * 0.7)
        buttontext.width = display.contentWidth * 0.7
        buttontext.y = display.contentHeight * 0.745
      end
    else
			buttontext = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_signup_text.png")
      buttontext.height = WalkThroughUtilities.getNewHeight(buttontext,display.contentWidth * 0.53)
      buttontext.width = display.contentWidth * 0.53
      buttontext.x = display.screenOriginX + buttontext.width * 0.55

      if (system.getInfo( "platformName" ) == "Android") then
        buttontext.y = display.contentHeight * 0.76
      else
        buttontext.y = display.contentHeight * 0.72
        if ( WalkThroughUtilities.getScreenHeight() == 960) then
          buttontext.height = WalkThroughUtilities.getNewHeight(buttontext,display.contentWidth * 0.53)
          buttontext.width = display.contentWidth * 0.53
          buttontext.y = display.contentHeight * 0.8
        end
        if (WalkThroughUtilities.detectDeviceType() == "iPad") then
          buttontext.height = WalkThroughUtilities.getNewHeight(buttontext,display.contentWidth * 0.47)
          buttontext.width = display.contentWidth * 0.47
          buttontext.x = display.screenOriginX + buttontext.width * 0.54
          buttontext.y = display.contentHeight * 0.83
        end
      end
    end

    g:insert(buttontext)
		popupHeight = popupHeight + buttontext.y +  buttontext.height


    if WalkThroughUtilities.getOrientation() == "portrait" then
      facebook_authentication = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_button_facebook.png")

      facebook_authentication.height = WalkThroughUtilities.getNewHeight(facebook_authentication,display.contentWidth * 0.7)
      facebook_authentication.width = display.contentWidth * 0.7
      facebook_authentication.x = display.contentWidth / 2
      if (system.getInfo( "platformName" ) == "Android") then
        facebook_authentication.y = popupHeight + facebook_authentication.height * 0.18
      else
        facebook_authentication.y = popupHeight + facebook_authentication.height * 0.2
        if (WalkThroughUtilities.detectDeviceType() == "iPad") then
          facebook_authentication.height = WalkThroughUtilities.getNewHeight(facebook_authentication,display.contentWidth * 0.55)
          facebook_authentication.width = display.contentWidth * 0.55
          facebook_authentication.y = popupHeight + facebook_authentication.height * 0.08
        end
      end
    else
			facebook_authentication = display.newImage("WalkThroughPluginLibrary/LandScape/landscape-button-facebook@3x.png")
      facebook_authentication.height = WalkThroughUtilities.getNewHeight(facebook_authentication,display.contentWidth * 0.4)
      facebook_authentication.width = display.contentWidth * 0.4
      if (system.getInfo( "platformName" ) == "Android") then
        facebook_authentication.x = display.contentWidth / 2 + facebook_authentication.width * 0.7
        facebook_authentication.y = display.contentHeight -  facebook_authentication.height * 1.5
      else
        if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then

          facebook_authentication.x = display.contentWidth / 2 + facebook_authentication.width * 0.7
          facebook_authentication.y = display.contentHeight -  facebook_authentication.height * 1.1

          if (WalkThroughUtilities.detectDeviceType() == "iPad") then

            facebook_authentication.height = WalkThroughUtilities.getNewHeight(facebook_authentication,display.contentWidth * 0.37)
            facebook_authentication.width = display.contentWidth * 0.37
            facebook_authentication.x = display.contentWidth / 2 + facebook_authentication.width * 0.67
            facebook_authentication.y = display.contentHeight -  facebook_authentication.height * 1.1
          end
        else
          facebook_authentication.x = display.contentWidth / 2 + facebook_authentication.width * 0.7
          facebook_authentication.y = display.contentHeight -  facebook_authentication.height * 1.82
        end
      end
    end
    g:insert(facebook_authentication)



    if WalkThroughUtilities.getOrientation() == "portrait" then
      login_text_authentication = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_text_login.png")

      login_text_authentication.height = WalkThroughUtilities.getNewHeight(login_text_authentication,display.contentWidth * 0.5)
      login_text_authentication.width = display.contentWidth * 0.5
      login_text_authentication.x = display.contentWidth / 2
      if (system.getInfo( "platformName" ) == "Android") then
        login_text_authentication.y = popupHeight + login_text_authentication.height * 4.5
      else
        login_text_authentication.y = popupHeight + login_text_authentication.height * 4.7
        if (WalkThroughUtilities.detectDeviceType() == "iPad") then
          login_text_authentication.y = popupHeight + login_text_authentication.height * 3
        end
      end
    else
			login_text_authentication = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_text_login.png")
      login_text_authentication.height = WalkThroughUtilities.getNewHeight(login_text_authentication,display.contentWidth * 0.35)
      login_text_authentication.width = display.contentWidth * 0.35
      login_text_authentication.x = buttontext.x + login_text_authentication.height

      if (system.getInfo( "platformName" ) == "Android") then
        login_text_authentication.y = display.contentHeight - login_text_authentication.width * 0.31
      else
        if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
          login_text_authentication.y = display.contentHeight - login_text_authentication.width * 0.18
        else
          login_text_authentication.y = display.contentHeight - login_text_authentication.width * 0.38
        end
      end
    end
    g:insert(login_text_authentication)

		--Event Listeners
    login_text_authentication:addEventListener( "touch", goToAppsaholicPortal )
    facebook_authentication:addEventListener( "touch", goToAppsaholicPortal )

		--Dots Image Presentation
	    if WalkThroughUtilities.getOrientation() == "portrait" then
	      dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
	    else
				dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
	    end
	    dot1.height = WalkThroughUtilities.getNewHeight(dot1,display.contentWidth * dot_size_fix)
	    dot1.width = display.contentWidth * dot_size_fix
	    dot1.x = display.contentWidth / 2 - dot1.width * 2.7
	    dot1.y = dots_y_coordinate
	    g:insert(dot1)

	    if WalkThroughUtilities.getOrientation() == "portrait" then
	      dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
	    else
				dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
	    end
	    dot2.height = WalkThroughUtilities.getNewHeight(dot2,display.contentWidth * dot_size_fix)
	    dot2.width = display.contentWidth * dot_size_fix
	    dot2.x = display.contentWidth / 2
	    dot2.y = dot1.y
	    g:insert(dot2)

	    if WalkThroughUtilities.getOrientation() == "portrait" then
	      dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
	    else
				dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
	    end
	    dot3.height = WalkThroughUtilities.getNewHeight(dot3,display.contentWidth * dot_size_fix)
	    dot3.width = display.contentWidth * dot_size_fix
	    dot3.x = display.contentWidth / 2 + dot1.width * 2.7
	    dot3.y = dot1.y
	    g:insert(dot3)


	imgNum = 1

	g.x = 0
	g.y = top + display.screenOriginY

	function touchListener (self, touch)
		local phase = touch.phase
		print("slides", phase)

		if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the contentBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

			startPos = touch.x
			prevPos = touch.x

        elseif( self.isFocus ) then

			if ( phase == "moved" ) then

				if tween then transition.cancel(tween) end

				print(imgNum)

				local delta = touch.x - prevPos
				prevPos = touch.x

				images[imgNum].x = images[imgNum].x + delta

				if (images[imgNum-1]) then
					images[imgNum-1].x = images[imgNum-1].x + delta

				end

				if (images[imgNum+1]) then
					images[imgNum+1].x = images[imgNum+1].x + delta
				end

			elseif ( phase == "ended" or phase == "cancelled" ) then

				dragDistance = touch.x - startPos
				print("dragDistance: " .. dragDistance)

				if (dragDistance < -40 and imgNum < #images) then
					nextImage()
				elseif (dragDistance > 40 and imgNum > 1) then
					prevImage()
				else
					cancelMove()
				end

				if ( phase == "cancelled" ) then
					cancelMove()
				end

                -- Allow touch events to be sent normally to the objects they "hit"
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false

			end
		end

		return true

	end

	function setSlideNumber()
		print("setSlideNumber", imgNum .. " of " .. #images)

		dot1:removeSelf( )
		dot2:removeSelf( )
		dot3:removeSelf( )
		display.remove( webView )
  --  display.remove( showPerkPointsIcon )
		if (imgNum == 1) then

			--Dots Image Presentation
				if WalkThroughUtilities.getOrientation() == "portrait" then
					dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
				else
          dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
				end
				dot1.height = WalkThroughUtilities.getNewHeight(dot1,display.contentWidth * dot_size_fix)
				dot1.width = display.contentWidth * dot_size_fix
				dot1.x = display.contentWidth / 2 - dot1.width * 2.7
				dot1.y = dots_y_coordinate
				g:insert(dot1)

				if WalkThroughUtilities.getOrientation() == "portrait" then
					dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
				else
          dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
				end
				dot2.height = WalkThroughUtilities.getNewHeight(dot2,display.contentWidth * dot_size_fix)
				dot2.width = display.contentWidth * dot_size_fix
				dot2.x = display.contentWidth / 2
				dot2.y = dot1.y
				g:insert(dot2)

				if WalkThroughUtilities.getOrientation() == "portrait" then
					dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
				else
          dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
				end
				dot3.height = WalkThroughUtilities.getNewHeight(dot3,display.contentWidth * dot_size_fix)
				dot3.width = display.contentWidth * dot_size_fix
				dot3.x = display.contentWidth / 2 + dot1.width * 2.7
				dot3.y = dot1.y
				g:insert(dot3)

		end

		if (imgNum == 2) then

      local function webListener( event )
          if event.url then
              print( "You are visiting: " .. event.url )
          end
          if event.type then
              print( "The event.type is " .. event.type ) -- print the type of request
          end
          if event.errorCode then
              native.showAlert( "Please check your internet connection", { "OK" } )
          end
        end

        if WalkThroughUtilities.getOrientation() == "portrait" then
		      webView = native.newWebView( display.contentCenterX, display.contentCenterY - 100, display.contentWidth * 0.83, display.contentHeight * 0.36 )
		    else
          if (system.getInfo( "platformName" ) == "Android") then
            webView = native.newWebView( display.contentWidth - 137, display.contentCenterY - 42.2, display.contentWidth * 0.58, display.contentHeight * 0.519)
          else
            if ( WalkThroughUtilities.getScreenHeight() == 960 or (WalkThroughUtilities.detectDeviceType() == "iPad")) then
              webView = native.newWebView( display.contentWidth - 138, display.contentCenterY - 43, display.contentWidth * 0.59, display.contentHeight * 0.52)
            else
              webView = native.newWebView( display.contentWidth - 138, display.contentCenterY - 50.2, display.contentWidth * 0.57, display.contentHeight * 0.495)
            end
          end
		    end
				webView:request(YOUTUBE_URL )
				g:insert(webView)
        webView:addEventListener( "urlRequest", webListener )

        -- if WalkThroughUtilities.getOrientation() == "portrait" then
        --   showPerkPointsIcon = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_icon_point.png")
        -- else
        --   showPerkPointsIcon = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
        -- end
        -- showPerkPointsIcon.height = WalkThroughUtilities.getNewHeight(showPerkPointsIcon,display.contentWidth * 0.2)
        -- showPerkPointsIcon.width = display.contentWidth * 0.2
        -- showPerkPointsIcon.x = display.contentWidth - showPerkPointsIcon.width
        -- showPerkPointsIcon.y = display.contentWidth / 2 + showPerkPointsIcon.height
        -- g:insert(showPerkPointsIcon)
        -- showPerkPointsIcon:toFront()

			--Dots Image Presentation
		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    else
          dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    end
		    dot1.height = WalkThroughUtilities.getNewHeight(dot1,display.contentWidth * dot_size_fix)
		    dot1.width = display.contentWidth * dot_size_fix
		    dot1.x = display.contentWidth / 2 - dot1.width * 2.7
		    dot1.y = dots_y_coordinate
		    g:insert(dot1)



		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
		    else
          dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
		    end
		    dot2.height = WalkThroughUtilities.getNewHeight(dot2,display.contentWidth * dot_size_fix)
		    dot2.width = display.contentWidth * dot_size_fix
		    dot2.x = display.contentWidth / 2
		    dot2.y = dot1.y
		    g:insert(dot2)

		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    else
          dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    end
		    dot3.height = WalkThroughUtilities.getNewHeight(dot3,display.contentWidth * dot_size_fix)
		    dot3.width = display.contentWidth * dot_size_fix
		    dot3.x = display.contentWidth / 2 + dot1.width * 2.7
		    dot3.y = dot1.y
		    g:insert(dot3)

		end

		if (imgNum == 3) then
			--Dots Image Presentation
		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    else
          dot1 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    end
		    dot1.height = WalkThroughUtilities.getNewHeight(dot1,display.contentWidth * dot_size_fix)
		    dot1.width = display.contentWidth * dot_size_fix
		    dot1.x = display.contentWidth / 2 - dot1.width * 2.7
		    dot1.y = dots_y_coordinate
		    g:insert(dot1)

		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    else
          dot2 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_inactive.png")
		    end
		    dot2.height = WalkThroughUtilities.getNewHeight(dot2,display.contentWidth * dot_size_fix)
		    dot2.width = display.contentWidth * dot_size_fix
		    dot2.x = display.contentWidth / 2
		    dot2.y = dot1.y
		    g:insert(dot2)

		    if WalkThroughUtilities.getOrientation() == "portrait" then
		      dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
		    else
          dot3 = display.newImage("WalkThroughPluginLibrary/Portrait/portrait_slider_button_active.png")
		    end
		    dot3.height = WalkThroughUtilities.getNewHeight(dot3,display.contentWidth * dot_size_fix)
		    dot3.width = display.contentWidth * dot_size_fix
		    dot3.x = display.contentWidth / 2 + dot1.width * 2.7
		    dot3.y = dot1.y
		    g:insert(dot3)
		end
	end

	function cancelTween()
		if prevTween then
			transition.cancel(prevTween)
		end
		prevTween = tween
	end

	function nextImage()
		tween = transition.to( images[imgNum], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
		tween = transition.to( images[imgNum+1], {time=400, x=screenW*.5, transition=easing.outExpo } )
		imgNum = imgNum + 1
		initImage(imgNum)
	end

	function prevImage()
		tween = transition.to( images[imgNum], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
		tween = transition.to( images[imgNum-1], {time=400, x=screenW*.5, transition=easing.outExpo } )
		imgNum = imgNum - 1
		initImage(imgNum)
	end

	function cancelMove()
		tween = transition.to( images[imgNum], {time=400, x=screenW*.5, transition=easing.outExpo } )
		tween = transition.to( images[imgNum-1], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
		tween = transition.to( images[imgNum+1], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
	end

	function initImage(num)
		if (num < #images) then
			images[num+1].x = screenW*1.5 + pad
		end
		if (num > 1) then
			images[num-1].x = (screenW*.5 + pad)*-1
		end
		setSlideNumber()
	end

	background.touch = touchListener
	background:addEventListener( "touch", background )

	------------------------
	-- Define public methods

	function g:jumpToImage(num)
		local i
		print("jumpToImage")
		print("#images", #images)
		for i = 1, #images do
			if i < num then
				images[i].x = -screenW*.5;
			elseif i > num then
				images[i].x = screenW*1.5 + pad
			else
				images[i].x = screenW*.5 - pad
			end
		end
		imgNum = num
		initImage(imgNum)
	end

	function g:cleanUp()
		print("slides cleanUp")
		background:removeEventListener("touch", touchListener)
	end

	return g
end
