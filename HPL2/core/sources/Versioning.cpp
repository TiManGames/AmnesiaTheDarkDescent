#include "Versioning.h"

tString FormatBuildId(const char* date, const char* time)
{
	return "CE " + GetCommunityString() + " (build date: " + tString(date) + ", " + tString(time) + ")";
}

tWString GetCommunityWString()
{
    return L"v" + cString::ToStringW(CE_VERSION_MAJOR) + L"." + cString::ToStringW(CE_VERSION_MINOR) + L"." + cString::ToStringW(CE_VERSION_PATCH);
}

tString GetCommunityString()
{
    return "v" + cString::ToString(CE_VERSION_MAJOR) + "." + cString::ToString(CE_VERSION_MINOR) + "." + cString::ToString(CE_VERSION_PATCH);
}