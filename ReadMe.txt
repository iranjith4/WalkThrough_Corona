
How To Integrate :
1. Copy the WalkThroughPluginLibrary Folder from corona directory.

2. Declare the header file :
    local slideView = require("WalkThroughPluginLibrary.slideView")
    local WalkThroughUtilities = require "WalkThroughPluginLibrary.WalkThroughUtilities"

3. Call the bellow when ever you want :
    -- Calling the Show WalkThrough Screens
    slideView.new( WalkThroughUtilities.fetchLocalImages ())

4. This much will redirect you to walkthrough view.
