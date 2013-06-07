#include "c.h"
#include <iostream>

using namespace std ; 

int
main(int ac, char **av) 
{

    // Basic printing to stdout
    hello_c() ; 
    hello_f() ; 

    // passing an integer between languages
    print_int_c(30) ; 
    print_int_f(30) ; 

    // passing an integer by reference between languages
    int setme ; 
    set_int_c(setme) ; 
    cout << "C set the value to: " << setme << endl ; 
    set_int_f(setme) ; 
    cout << "Fortran set the value to: " << setme << endl ; 

    return 0 ; 
}
