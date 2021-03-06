-- Created by Arunkumar Sahoo on 30 Mar 2016
-- For Womi Studios by Perk.com
-- ╦ ╦╔═╗╔╦╗╦  ╔═╗╔╦╗╦ ╦╔╦╗╦╔═╗╔═╗
-- ║║║║ ║║║║║  ╚═╗ ║ ║ ║ ║║║║ ║╚═╗
-- ╚╩╝╚═╝╩ ╩╩  ╚═╝ ╩ ╚═╝═╩╝╩╚═╝╚═╝
--
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--PLEASE EDIT THIS VALUES AS PER APP ||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Your code here

local composer = require( "composer" )
local widget = require( "widget" )
local display = require ("display")
local slideView = require("WalkThroughPluginLibrary.slideView")
local WalkThroughUtilities = require "WalkThroughPluginLibrary.WalkThroughUtilities"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

------------------------------Perk Pages--------------------------------------------------------------------------------------

local function handleButtonEvent(event)
  if ( "ended" == event.phase ) then
      -- Calling the Show WalkThrough Screens
      slideView.new( WalkThroughUtilities.fetchLocalImages ())
  end
end


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    local background = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,display.contentHeight + 200)
    background:setFillColor(0,0,0)
    sceneGroup:insert(background)

    local showWalkThrough= widget.newButton(
    {
        left = display.contentCenterX / 2,
        top = display.contentCenterY / 2,
        id = "showWalkThrough",
        label = "WalkThrough",
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        onEvent = handleButtonEvent
    })

    sceneGroup:insert(showWalkThrough)
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    print( "Screen Width->",display.pixelWidth )
    print( "Screen Height->",display.pixelHeight )
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
