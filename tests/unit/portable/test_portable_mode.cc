#include <cassert>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include "../../../portable_mode.h"

int main() {
    std::string test_dir = "test_env";
    std::system(("mkdir -p " + test_dir).c_str());

    // Test 1: No marker file
    assert(IsPortableModeEnabled(test_dir) == false);

    // Test 2: Marker file exists
    std::ofstream file(test_dir + "/.portable");
    file.close();
    assert(IsPortableModeEnabled(test_dir) == true);

    std::cout << "All tests passed!" << std::endl;
    std::system(("rm -rf " + test_dir).c_str());
    return 0;
}
