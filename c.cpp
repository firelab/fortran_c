#include <iostream>

using namespace std ; 

extern "C" {
    void hello_c(void) { 
        cout << "Hello, world from C++!" << endl ; 
    }

    void print_int_c(int pic) { 
        cout << "Value in C: " << pic << endl ; 
    }

    void set_int_c(int *sic) { 
        *sic = 10 ; 
    }

    int ret_int_c(void) { 
        return 10 ; 
    }

    void set_intarray_c(int *sac, int npts) { 
        for (int i=0; i<npts; i++) {
            sac[i] = i; 
        }
    }
}
