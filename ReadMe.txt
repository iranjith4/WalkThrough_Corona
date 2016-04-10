How To Integrate :

1. Copy the WalkThroughPluginLibrary folder to your corona folder.

2. Declare the header file :
    local slideView = require("WalkThroughPluginLibrary.slideView")
    local WalkThroughUtilities = require "WalkThroughPluginLibrary.WalkThroughUtilities"

3. Call the bellow where ever you want :
    -- Calling the Show WalkThrough Screens
    slideView.new( WalkThroughUtilities.fetchLocalImages ())

4. Call perk-login method with in bellow function which is inside slideView.lua
  
	function goToAppsaholicPortal(event)
  
5. This much will redirect you to walkthrough view.
