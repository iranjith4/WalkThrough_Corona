 
How To Integrate : 
1. Copy the WalkThrough Folder from corona directory.

2. Declare the header file : 
	local WalkThroughUtilities = require "WalkThrough.WalkThroughUtilities"
	local slideView = require("WalkThrough.slideView")

3. Call the bellow when ever you want : 

    -- Calling the Show WalkThrough Screens
      local myImages = {
      	"WalkThrough/Portrait/Objects/portrait-wakthrough1_bg.png",
      	"WalkThrough/Portrait/Objects/portrait-wakthrough2_bg.png",
      	"WalkThrough/Portrait/Objects/portrait-wakthrough3_bg.png"
      }
    slideView.new( myImages)

4. This much will redirect you to walkthrough view.
