#ifndef PORTABLE_MODE_H
#define PORTABLE_MODE_H

#include <string>
#include <fstream>
#include <iostream>

#include <unistd.h>
#include <limits.h>

namespace bobium {

class PortableMode {
public:
    // Resolves the .portable flag relative to the executable, not the PWD.
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

private:
    static std::string GetExecutablePath() {
        char result[PATH_MAX];
        ssize_t count = readlink("/proc/self/exe", result, PATH_MAX);
        if (count != -1) {
            std::string path(result, count);
            size_t last_slash_idx = path.rfind('/');
            if (std::string::npos != last_slash_idx) {
                return path.substr(0, last_slash_idx);
            }
        }
        return ""; // Fallback will use relative if proc/self fails
    }
};

} // namespace bobium

#endif // PORTABLE_MODE_H
