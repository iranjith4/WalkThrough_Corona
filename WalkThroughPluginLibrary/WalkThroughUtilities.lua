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

local firstAlertAfter = 4
local laterAlertAfter = 4
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
local json = require "json"
local M = {}
local myImages  = {}

function M.firstAlertAfter()
  return getFirstAlertAfter
end

function M.laterAlertAfter()
  return laterAlertAfter
end

function M.getScreenWidth()
  return display.pixelWidth
end
function M.getScreenHeight()
  return display.pixelHeight
end

function M.detectDeviceType()
  local device = system.getInfo( "model" )
  if (device == "iPad") then
    return "iPad"
  elseif (device == "iPhone") then
    return "iPhone"
  end
end

function loadTable(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
         -- read all contents of file into a string
         local contents = file:read( "*a" )
         myTable = json.decode(contents);
         io.close( file )
         return myTable
    end
    return nil
end

function saveTable(t, filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

function checkForRateMeData()
	local rateMeFile = loadTable("walkthrough.json")
	if rateMeFile == nil then
		rateMeFile = {}
		rateMeFile.showAlert = true
    rateMeFile.appLaunchCount = 0
    rateMeFile.nextAlertIn = firstAlertAfter
    rateMeFile.status = "NONE"
    rateMeFile.automatic = true
		saveTable(rateMeFile,"walkthrough.json")
	end
end

function M.getAppLaunchCount()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  return data.appLaunchCount
end

function M.getStatus()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  return data.status
end

function changeNextAlertIn(value)
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  data.nextAlertIn = value
  saveTable(data,"walkthrough.json")
end

function M.checkForAlert()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  if data.showAlert == true then
    if data.nextAlertIn == data.appLaunchCount then
      return true
    else
      if data.nextAlertIn < data.appLaunchCount then
        changeNextAlertIn(data.appLaunchCount + 4)
      end
      return false
    end
  else
    return false
  end
end

function M.appLaunch()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  local appLaunchCount = data.appLaunchCount
  data.appLaunchCount = appLaunchCount + 1
  saveTable(data,"walkthrough.json")
end

function M.neverAskAgain()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  data.showAlert = false
  data.status = "NEVER"
  saveTable(data,"walkthrough.json")
end

function M.rated ()
  -- body...
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  data.showAlert = false
  data.status = "RATED"
  saveTable(data,"walkthrough.json")
end


function M.remindMeLater()
  checkForRateMeData()
  local data = loadTable("walkthrough.json")
  local nextAlert = data.nextAlertIn
  data.nextAlertIn = nextAlert + laterAlertAfter
  data.status = "LATER"
  saveTable(data,"walkthrough.json")
end

function M.getNewHeight(image , newWidth)
    local r = image.width / image.height
    local newHeight = newWidth / r
    return newHeight
end

function M.getNewWidth(image , newHeight)
  local r = image.width / image.height
  local newWidth = newHeight * r
  return newWidth
end

function M.osType()
    local os = system.getInfo("platformName")
    if ( os == "iPhone OS") then
        return "ios"
    elseif ( os == "Android" ) then
        return "android"
    end
end

function M.getOrientation()
  if system.orientation == "portrait" or system.orientation == "portraitUpsideDown" then
    return "portrait"
  elseif system.orientation == "landscapeLeft" or system.orientation == "landscapeRight" then
    return "landscape"
  else
    return "portrait"
  end
end


--fetch Images
function M.fetchLocalImages ()
  -- Calling the Show WalkThrough Screens
  if M.getOrientation() == "portrait" then
       return  {
        "WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough1_bg.png",
        "WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough2_bg.png",
        "WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough3_bg.png"
      }
  else
     return  {
      "WalkThroughPluginLibrary/LandScape/landscape-wakthrough1-bg.png",
      "WalkThroughPluginLibrary/LandScape/landscape-wakthrough2-bg.png",
      "WalkThroughPluginLibrary/LandScape/landscape-wakthrough3-bg.png"
    }
  end
end


return M
