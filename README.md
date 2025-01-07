# Binary Clock
A simple binary clock tile for Tiled Screen.

## Installation
Copy the direcotry to $HOME/.local/share/tiledscreen/tiles/

## Metadata

Following JSON values are required

    1.name: User visible name.
    2.plugin: Unique name used internally.
    3.description: A short description of the tile
    4.icon: Icon to be used
    5.config: Configuration window
    6.main: QML file for the tile
    7.preferredHeight,preferredWidth: The default height nd width ( in grid cells )
    8.defaults: A JSON object with default values for tile configuration. All configuration keys used within the tile should be included here. Only primitive types like String, Float, Boolean , Int etc. can be used.
