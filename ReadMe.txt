 
How To Integrate : 
1. Copy the WalkThroughPluginLibrary Folder from corona directory.

2. Declare the header file : 
	local slideView = require("WalkThroughPluginLibrary.slideView")

3. Call the bellow when ever you want : 

    -- Calling the Show WalkThrough Screens
      if WalkThroughUtilities.getOrientation() == "portrait" then

        local myImages = {
        	"WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough1_bg.png",
        	"WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough2_bg.png",
        	"WalkThroughPluginLibrary/Portrait/Objects/portrait-wakthrough3_bg.png"
        }
      slideView.new( myImages)

      else

        local myImages = {
        	"WalkThroughPluginLibrary/LandScape/landscape-wakthrough1-bg.png",
        	"WalkThroughPluginLibrary/LandScape/landscape-wakthrough2-bg.png",
        	"WalkThroughPluginLibrary/LandScape/landscape-wakthrough3-bg.png"
        }
      slideView.new( myImages)

      end

4. This much will redirect you to walkthrough view.
