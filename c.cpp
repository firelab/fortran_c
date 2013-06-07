#include <iostream>
#include <cstring>
#include <cstdlib>

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

    void print_chararray_c(char *str, int strlen) {
        char *local ; 

        // allocate a local copy (leave space for the null)
        local = (char *)malloc(strlen+1) ; 
        if (!local) { 
            cout << "Cannot allocate space for local copy of string.\n" ;
            return ; 
        }

        // copy the string so we can make sure it's null terminated
        // failure to do so will likely result in overflow because 
        // fortran does not null terminate strings (it pads them with
        // spaces till the end of the buffer.)
        strncpy(local, str, strlen) ; 
        local[strlen] = (char)0 ; 

        cout << "C Prints: " << local << endl ; 

        free(local) ; 
    }
}
