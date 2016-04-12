## About
Explains the Perk SDK usages. WalkThrough for all WOMI games.

### Note  
On `config.lua` , set `scale = "zoomeven"`


## How To Integrate

1. Copy the WalkThroughPluginLibrary folder to your corona folder.

2. #### Declare the header file
    ```lua
  local slideView = require("WalkThroughPluginLibrary.slideView")
  local WalkThroughUtilities = require "WalkThroughPluginLibrary.WalkThroughUtilities"```

3. #### Call the bellow where ever you want
    Calling the Show WalkThrough Screens

    ```lua
    slideView.new( WalkThroughUtilities.fetchLocalImages())```

4. This much will redirect you to walkthrough view.

5. Call perk-login method with in bellow function which is inside slideView.lua
```lua
  function goToAppsaholicPortal(event)```
