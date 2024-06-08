#include "Versioning.h"

tString FormatBuildId(const char* date, const char* time)
{
	return tString(date) + ", " + tString(time);
}
