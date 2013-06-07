#include <iostream>

using namespace std ; 

extern "C" {
    void hello_c(void) { 
        cout << "Hello, world from C++!" << endl ; 
    }

    void print_int_c(int pic) { 
        cout << "Value in C: " << pic << endl ; 
    }

    void set_int_c(int &sic) { 
        sic = 10 ; 
    }
}
