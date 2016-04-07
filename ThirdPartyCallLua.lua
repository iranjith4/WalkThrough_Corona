-- Created by Arun Kumar Sahoo on 30 Mar 2016
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

local composer = require "composer"
local perk = require "plugin.perk"
local widget = require( "widget" )
local M = {}


local PERK_APP_KEY = "daee393f1b55f99f410c17259172fef9db7b2480"
local PERK_EVENT_ID = "102baba4474a87b8075b65e8aae2473ca510b3b4"
local PERK_AD_EVENT_ID = "dad4e9b6c976ce85c959f9b1d08f459049461b5a"

local PERK_ANDROID_APP_KEY = "81000a9d5407667548eb3ceec9dc699823a02ba9"
local PERK_TAP_ONCE_ANDROID_EVENT_ID = "1037c884e25ac9faa84986c38bca8e99ccc07340"
local PERK_ANDROID_DISPLAY_EVENT_ID = "f0c902bd33a74e7d6504696dffedc66e5dbdb47c"
local PERK_ANDROID_AD_EVENT_ID = "05536119cdbdf1c7baff4c0427a467c5a1745ff7"


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

 function perkListener( event )

    if (event.phase == 'init') then
        displayText.text = "init status : "..tostring(event.data)
    elseif (event.phase == 'sdk_event_callbacks') then
    --native.showAlert( event.phase,event.data, { "OK" } )
    displayText.text = tostring(event.data)

    elseif (event.phase == 'sdk_adserver_callbacks') then
    --native.showAlert( event.phase,event.data, { "OK" } )
    displayText.text = tostring(event.data)

    elseif (event.phase == 'sdk_user_info') then
        for k, v in pairs( event.data ) do
            print(k, v)
        end
    displayText.text = "Points:"..event.data.available_points..":".. event.data.first_name..":".. event.data.last_name

    elseif (event.phase == 'sdk_supported_country_list') then
        native.showAlert( event.phase, table.concat(event.data,","), { "OK" } )

    elseif (event.phase == 'sdk_toggle_status') then
    native.showAlert( event.phase,tostring(event.data), { "OK" } )

    elseif (event.phase == 'sdk_user_status') then
    native.showAlert( event.phase,tostring(event.data), { "OK" } )

    elseif (event.phase == 'sdk_publisher_points') then
    native.showAlert( event.phase,tostring(event.data), { "OK" } )

    elseif (event.phase == 'sdk_fetch_unclaimed_notification') then
    native.showAlert( event.phase,tostring(event.data), { "OK" } )

    elseif (event.phase == 'sdk_track_event') then
    displayText.text = "Points Earned:"..event.data.point_earned..":".. event.data.notification_text

    elseif (event.phase == 'sdk_event_callbacks') then
    displayText.text = tostring(event.data)

    end
end

--J: Added these functions for getting callbacks. A must call if user wants call back.
-- Call Back setting for normal SDK related callbacks.
--perk.receivePerkPointCallBacks( )

-- callbacks for Adserver advance call backs. IF required please uncomment.
--perk.receiveAdServerCallBacks( )

local function onPortalButton()
    perk.showPortal( )
end

----------

-- perk.init("daee393f1b55f99f410c17259172fef9db7b2480")
perk.init(PERK_ANDROID_APP_KEY,perkListener)

-- Runtime:addEventListener( "perk", perkListener )
---------

local function onUnclaimedPage()
    perk.launchUnclaimedPage( )
end

local function onTrackEvent()
    perk.trackEvent(PERK_TAP_ONCE_ANDROID_EVENT_ID, false)
-- "false" is if user does not want custom notification and want to use SDK notification.
-- "true" for hide SDK notification and design App specific notification.
-- PJ: Created a SUB ID section param in track event, I can change this as per planning or what ever you recommend.
end


-- PJ: New functions for Ad server calls

local function onLaunchDatapoints()
    perk.showSurveyAds(PERK_ANDROID_AD_EVENT_ID)
end

local function onLaunchAdbutton()
    perk.showAds(PERK_ANDROID_AD_EVENT_ID,1,true,true)
end

local function onLaunchDisplay()
    perk.showDisplayAds(PERK_ANDROID_DISPLAY_EVENT_ID)
end

local function onLaunchVideo()
    perk.showVideoAds(PERK_ANDROID_AD_EVENT_ID,3,true,true)
end


local function supportedCountryList()
    perk.fetchSupportedCountries()
end

local function onLoginButton()
    local ret = perk.launchLoginPage()
    if(ret == 1) then
        native.showAlert("Plugin Eevent","User is Already Loggedin.", { "OK" } )
    end
end

local function onLogoutButton()
    local ret = perk.isUserLoggedIn()
    if(ret == 1) then
        perk.logoutUser()
        native.showAlert("Plugin Eevent","User is logged out.", { "OK" } )
    else
        native.showAlert("Plugin Eevent","User not logged in.", { "OK" } )
    end
end


local function isUserLoggedIn()
   local ret = perk.isUserLoggedIn()
    print("CORONA isUserLoggedIn:",ret)
    displayText.text = tostring(ret)
end


local function onUnclaimedCountButton()
    perk.fetchNotifications()
end

local function onToggleSDKStatus()
    perk.toggleStatus( )
end


local function fetchUserPointsNumber()
    local ret = perk.isUserLoggedIn()
    if(ret == 1) then
        perk.fetchUserInfo()
    else
        native.showAlert("Plugin Eevent","User not logged in.", { "OK" } )
    end
end

------

local function onRedeemCall()
    print("i am here")
    perk.showPrizePage( )
end

local function onLaunchPrepaidPoints()
    perk.fetchPublisherPrepaidPoints()
end
----
local function onRetrieveSDKStatus()
    perk.getUserSDKStatus()
end


--CallBacks for Test functions
local function testFunction()

  local ret = perk.isUserLoggedIn()
  if(ret == 1) then
      native.showAlert("Plugin Eevent","User is Already Loggedin.", { "OK" } )
  else
    local ret = perk.launchLoginPage()
    if(ret == 1) then
        native.showAlert("Plugin Eevent","User is Already Loggedin.", { "OK" } )
    end
  end

end
M.testFunction = testFunction

return M
