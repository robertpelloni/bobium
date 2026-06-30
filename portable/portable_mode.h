#ifndef PORTABLE_MODE_H
#define PORTABLE_MODE_H

#include <string>
#include <fstream>
#include <iostream>

namespace bobium {

class PortableMode {
public:
    static bool IsPortable() {
        std::ifstream file(".portable");
        return file.good();
    }

    static std::string GetProfilePath() {
        return "bobium_profile";
    }
};

} // namespace bobium

#endif // PORTABLE_MODE_H
