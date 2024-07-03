# C++


<details open>
   
<summary> How create and allocate RAM with a single program </summary><br>

Primitive program to allocate physical RAM on Linux

````c++
#include <iostream>
#include <cstdlib>
#include <cstring>
#include <thread> // Include this for using sleep

void encrypt(char *data, size_t size, unsigned int key) {
    for (size_t i = 0; i < size; i++) {
        data[i] = data[i] ^ (key & 0xFF);
    }
}

int main() {
    size_t memory_size = 250 * 1024 * 1024; // 250 MB in bytes
    char *memory_block = new char[memory_size];

    if (memory_block == nullptr) {
        std::cout << "Failed to allocate memory." << std::endl;
        return 1;
    }

    // Fill the memory with something to prevent it from being optimized away
    for (size_t i = 0; i < memory_size; i++) {
        memory_block[i] = 0;
    }

    std::cout << "Allocated and using 250 megabytes of memory." << std::endl;

    unsigned int encryption_key = 5234251;
    encrypt(memory_block, memory_size, encryption_key);

    // Continue running in an infinite loop
    while (true) {
        std::this_thread::sleep_for(std::chrono::seconds(1)); // Pause for 1 second
    }

    // We will never reach here, but in a more realistic situation,
    // you would decrypt the memory and free it before exiting
    encrypt(memory_block, memory_size, encryption_key);
    delete[] memory_block;

    return 0;
}
````
Then run `g++ -o ram ram.cpp` and run the program i terminal with `./ram`.

</details>
