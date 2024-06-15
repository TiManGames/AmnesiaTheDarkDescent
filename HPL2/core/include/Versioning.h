
#ifndef VERSIONING_H
#define VERSIONING_H

// main game version
#define MAIN_VERSION_MAJOR 1
#define MAIN_VERSION_MINOR 4

// community edition versioning
#define CE_VERSION_MAJOR 0
#define CE_VERSION_MINOR 4
#define CE_VERSION_PATCH 3

#include "system/String.h"

using namespace hpl;

tString FormatBuildId(const char* date, const char* time);
tWString GetCommunityWString();
tString GetCommunityString();

#endif //VERSIONING_H
