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
local WalkThrough = require "WalkThroughPluginLibrary.WalkThroughUtilities"
display.setStatusBar( display.HiddenStatusBar )

WalkThrough.appLaunch()
composer.gotoScene("menu")
