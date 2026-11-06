#ifndef PORTABLE_MODE_H
#define PORTABLE_MODE_H

#include <string>
#include <fstream>
#include <iostream>

#if defined(_WIN32)
#include <windows.h>
#elif defined(__APPLE__)
#include <mach-o/dyld.h>
#include <limits.h>
#else
#include <unistd.h>
#include <limits.h>
#endif

namespace bobium {

class PortableMode {
public:
    // Resolves the .portable flag relative to the executable directory, not the working directory.
    static bool IsPortable() {
        std::string exe_path = GetExecutablePath();
        if (exe_path.empty()) return false;

        std::string flag_path = exe_path + "/.portable";
        std::ifstream file(flag_path.c_str());
        return file.good();
    }

    static std::string GetProfilePath() {
        std::string exe_path = GetExecutablePath();
        if (exe_path.empty()) return "bobium_profile";
        return exe_path + "/bobium_profile";
    }

    static std::string GetExecutablePath() {
#if defined(_WIN32)
        char result[MAX_PATH];
        DWORD count = GetModuleFileNameA(NULL, result, MAX_PATH);
        if (count > 0 && count < MAX_PATH) {
            std::string path(result, count);
            size_t last_slash_idx = path.find_last_of("\\/");
            if (std::string::npos != last_slash_idx) {
                return path.substr(0, last_slash_idx);
            }
        }
        return "";
#elif defined(__APPLE__)
        char result[PATH_MAX];
        uint32_t size = sizeof(result);
        if (_NSGetExecutablePath(result, &size) == 0) {
            std::string path(result);
            size_t last_slash_idx = path.rfind('/');
            if (std::string::npos != last_slash_idx) {
                return path.substr(0, last_slash_idx);
            }
        }
        return "";
#else
        char result[PATH_MAX];
        // Pass sizeof(result) - 1 to guarantee buffer boundary safety for string conversion
        ssize_t count = readlink("/proc/self/exe", result, sizeof(result) - 1);
        if (count != -1) {
            std::string path(result, count);
            size_t last_slash_idx = path.rfind('/');
            if (std::string::npos != last_slash_idx) {
                return path.substr(0, last_slash_idx);
            }
        }
        return ""; // Fallback will use relative if proc/self fails
#endif
    }
};

} // namespace bobium

#endif // PORTABLE_MODE_H
