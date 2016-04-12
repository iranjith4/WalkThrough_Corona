## About
Explains the Perk SDK usages. WalkThrough for all WOMI games.

## How To Integrate

1. Copy the WalkThroughPluginLibrary folder to your corona folder.

- #### Declare the header file
    ```lua
  local slideView = require("WalkThroughPluginLibrary.slideView")
  local WalkThroughUtilities = require "WalkThroughPluginLibrary.WalkThroughUtilities"```

- #### Call the bellow where ever you want
    -- Calling the Show WalkThrough Screens

    ```lua
    slideView.new( WalkThroughUtilities.fetchLocalImages ())```

- This much will redirect you to walkthrough view.

- Call perk-login method with in bellow function which is inside slideView.lua

	```lua
  function goToAppsaholicPortal(event)```

### Note:
    On config.lua , set scale = "zoomeven"
