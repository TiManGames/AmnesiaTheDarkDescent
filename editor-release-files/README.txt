# Installation

Extract the CommunityTools archive into the main directory of Amnesia.
Merge and overwrite all when asked.
No information will be lost by replacing these files, so no need to create a backup.

The package contains modded config files.
They add new area and entity types, so that the editors can be used with MFP.
They don't clash with TDD, but don't expect these features to work in-game if you put them in a map:
- Colorgrading area
- Infection area
- New entities with custom types, such as PhoneBox

The editors come with the dark theme by default now.
If you prefer the original light theme, unpack the gui-original-light-theme.rar file and overwrite the existing gui folder.

# Known Issues

Changing the grid settings in the Model Editor causes a crash. 
It's a bug which was present in the source code and is being currently examined.

# Changelog

v0.3.0
- Made the editors use the system mouse instead of a simulated one
- Fix a few source code issues

v0.2.3
- Added exit shortcuts to the Material Editor

v0.2.2
- Fixed a color picker/display issue when not using a white frame background = Dark theme is viable
- Included the dark theme in the download
- Includes compability config files for MFP usage

v0.2.0
- Grid snapping shortcuts
- Lock grid tracking shortcut
- About section added

v0.1.0
- New, improved color picker (from MFP)
- Grid snapping presets
- Community labels in the editor and on top of the window

# New Keyboard Shortcuts

Each new shortcut is also shown on the hover hint to the corresponding GUI button.

Level and Model Editors:
- Grid preset 1:     Shift+Q
- Grid preset 2:     Shift+W
- Grid preset 3:     Shift+E
- Toggle grid snapping: R
- Lock grid tracking:   T
- Exit: Ctrl+Q instead of Alt+F4 (Escape also works but only in some editors)

Previously unknown shortcuts:
- Move clip planes with O and L