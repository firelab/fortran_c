#include <iostream>
#include <cstring>
#include <string>

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

    void print_chararray_c(const char *str, int strlen) {
        string local = string(str, strlen) ; 

        cout << "C Prints: " << local << endl ; 
    }

    void ret_chararray_c(char *str, int &len) { 
        const char msg[]="Hello, world!" ; 
        strncpy(str, msg, len) ; 
        len = strlen(msg) ; 
    }
}
