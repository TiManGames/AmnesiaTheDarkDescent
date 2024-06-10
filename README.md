# Amnesia: The Dark Descent (Community Editors Fork)

This is a fork of the Amnesia the Dark Descent repository from Frictional Games.
Currently mainly working on improving the engine tools.

## New editor features

* Use system mouse instead of a simulated one - significantly improves comfort because the system mouse is more precise
* A much more comfortable color picker (it is included in the official 1.5 editors, but was not in 1.3)
* New keyboard shortcuts - including standard ones which were missing.
Check button hover tips to see if a button has a shortcut, or the release changelog for a full list.
* Dark theme
* Bigger GUI - the original one was developed for screens which were twice smaller and became uncomfortable.
We are bringing the GUI sizing closer to HPL3 editors.
* Semi-compability with Machine For Pigs - maps can be opened without crashing, but lights are inaccurate because of rendering differences between MFP and TDD

## Building (Linux)

1. Ensure you have `make` and `cmake` installed
1. Clone the project and enter the folder
1. Extract `./HPL2/dependencies.zip` to the same folder it's in. **DO NOT** overwrite anything
1. Run the script file at `./HPL2/dependencies/lib/linux/lib64/fix_symlinks.sh` to fix broken symlinks from the .zip file
1. Create a `build` folder and open a terminal in it
1. Run `cmake -S ../amnesia/src/` - this is called an out-of-source build, which basically means that CMake won't pollute the source code with its files. When there's an issue caused by CMake, you can empty this directory and rerun CMake.
1. With a terminal still in `./build` run `make` (or use `make -jX` where X is the number of jobs you want to run to speed things up, based on your CPU threads; e.g. `make -j4`).
1. The build should compile and the resulting binaries will be found in `./output`.

To run the compiled binary, copy it to your Amnesia installation folder.
For example copy the `Amnesia.bin.x86_64` to your game folder.
A faster way to test stuff is to copy the game directory to `./output` and run the binaries from there.

Other notes:
- The game, all tools and the launcher are all compiled at the same time.
- The build configuration is set to Release in the main CMakeLists file.
Other options are also described there.

### Crosscompiling for Windows

You will need to delete `CMakeCache.txt` (or all `./build` contents) and add `--toolchain XCompileToWindows.toolchain` to
the CMake command, e.g. `cmake -S ../amnesia/src/ --toolchain XCompileToWindows.toolchain`.
Then use `make` as usual.

## Building (Windows, Visual Studio)

Note: VS `.sln` files are not actively maintained, you should try compiling on Windows with CMake.

The game is built from two separate solutions: The engine solution named `HPL2_2010` and the main game solution named `Lux`.
The project also includes all the different editors and additional tools, such as the Level Editor and the Model Editor.
In order to build the game, you will first need to compile and build the HPL2 Engine.

Requirements:

- [Visual Studio C++ 2010](https://visualstudio.microsoft.com/vs/older-downloads/)
(express edition for example) (for compiling the engine)
- Visual Studio 2017 (for compiling the game, although I'm not sure this is mandatory)
[VS 2010 Service pack 1](https://www.microsoft.com/en-us/download/details.aspx?id=34677)
(the main game probably won't compile without this)

### Building the Engine
1. Clone the project
2. Go to the `HPL2/` folder and extract `dependencies.zip`.
3. Open `_HPL2_2010.sln` with Visual Studio 2010.
4. Set the build configuration from `Debug` to `Release`.
5. `Build -> Build _HPL2_2010`. There won't be any errors, but some warning messages will appear.
6. The build result will be created in `HPL2/lib`

### Building the Game
1. Go to `amnesia/src/game` and open `Lux.sln`.
2. Click cancel on retag project message.
3. Set the build configuration from `Debug` to `Release`.
4. `Build -> Build Lux`.  There won't be any errors, but some warning messages will appear.
5. The game executable should be created in `amnesia/redist`.

### Playing the Game
Copy `Amnesia.exe` into your Amnesia game folder and launch it. The main menu should appear normally with no errors.

### Building the Editors
TODO

### Troubleshooting
* **"When I compile `Lux`, I get an error message "fatal error RC1015: cannot open include file 'afxres.h'".**"
* You need to install the `Microsoft Foundation Classes for C++`. If it still doesn't work, change `afxres.h` to `windows.h`. It should compile then.

* **"When I compile the level editor, I get error message about vc70 not found.**"
* Try turning the Pre-Link Event off. Go to `Project Properties -> Build Events -> Pre-Link Event`, set `Use In Build` to `No` and build again.
