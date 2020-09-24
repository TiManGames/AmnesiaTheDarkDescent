# Amnesia: The Dark Descent Source Code - HPL Chad Gang Fork

This is a fork of the Amnesia the Dark Descent repository from FrictionalGames. We will mostly play with different parts of the engine and perhaps even fix some bugs :)

## Project Overview
The game is built from two separate solutions: The HPL2 Engine and the game itself.

## Prerequisites

- A copy of Amnesia: the Dark Descent (For playing the game)
- Visual Studio 2010 (For compiling the engine)
- Visual Studio 2017 (For compiling the game)
- CMake

## Project Overview
The game is built from two separate solutions: The engine solution named `HPL2_2010` and the main game solution named `Lux`.
The project also includes all the different editors and additional tools, such as the Level Editor and the Model Editor.

### Engine Overview
Todo: Add some descriptions about what kind of files we have in the engine solution.

### Game Overview
Todo: Add some descriptions about what kind of files we have in the game solution.

## Building & Playing (Windows)
In order to build the game on Windows, you will first need to compile and build the HPL2 Engine.

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

## Building & Playing (Mac)

### Building the Engine

### Building the Game

### Playing the Game

### Building the Editors

## Building & Playing (Linux)

There are quite a few extra steps required to be able to successfully build everything on Linux. This is partially due to incorrect configuration in the default repository.

### Building the Engine, Game & Editors

0. Ensure you have `make` and `cmake` installed.
1. Clone the project and enter the folder
2. Extract `./HPL2/dependencies.zip` to the same folder it's in
3. Edit `./HPL2/core/CMakeLists.txt` and remove the line near the bottom about adding the `../tests` subdirectory.
4. Open a terminal in `./amnesia/src` and run `cmake .`
5. Search for "BuildID" in the file system and you will see 5 sets of .h and .cpp files. The .cpp filenames end with "Win32". Create duplicates of these files and rename from "Win32" to "Linux". For example: `BuildID_HPL2_0_Win32.cpp` > `BuildID_HPL2_0_Linux.cpp`.
6. Add the following CMake line into the files listed below: `set(CMAKE_CXX_FLAGS "-fpermissive -no-pie")`
	- `./amnesia/src/CMakeLists.txt`
	- `./amnesia/src/launcher/CMakeLists.txt`
	- `./amnesia/src/game/CMakeLists.txt`
	- `./HPL2/core/CMakeLists.txt`
	- `./HPL2/tools/CMakeLists.txt`
	- `./HPL2/tools/editors/CMakeLists.txt`
7. Open a terminal in `./HPL2/dependencies/lib/linux/lib64` and run ([credit](https://github.com/FrictionalGames/AmnesiaTheDarkDescent/pull/2#issuecomment-697648592)):

    ```
	for f in `file * | grep ASCII | cut -d: -f1`; do ln -fs `cut -d' ' -f2 $f` $f; done
	```

8. With a terminal in `./amnesia/src` do `make` (or use `make -jX` where X is the number of jobs you want to run to speed things up, based on your CPU threads)
9. The build will compile and the resulting binaries will be found in `./amnesia/src`

### Playing the Game

To run the compiled binary, copy it to your Amnesia installation folder. For example copy the `Amnesia.bin.x86_64` to your game folder. Run it, and the game should start directly.

## Toubleshooting
* **"When I compile `Lux`, I get an error message "fatal error RC1015: cannot open include file 'afxres.h'".**"
* You need to install the `Microsoft Foundation Classes for C++`. If it still doesn't work, change `afxres.h` to `windows.h`. It should compile then.

* **"When I compile the level editor, I get error message about vc70 not found.**"
* Try turning the Pre-Link Event off. Go to `Project Properties -> Build Events -> Pre-Link Event`, set `Use In Build` to `No` and build again.

## License Information
All code is under the GPL Version 3 license. Read the LICENSE file for terms of use of the license.
