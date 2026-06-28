#pragma once
#include <string>
#include <fstream>

inline bool IsPortableModeEnabled(const std::string& directory) {
    std::string marker_path = directory + "/.portable";
    std::ifstream file(marker_path);
    return file.good();
}
