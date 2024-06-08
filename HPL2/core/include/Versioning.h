
#ifndef VERSIONING_H
#define VERSIONING_H

#define COMMUNITY_VERSION L"0.4.0"

#include "system/SystemTypes.h"  // tString aka std:string

using namespace hpl;

//20101027185544

tString FormatBuildId(const char* date, const char* time);

#endif //VERSIONING_H
