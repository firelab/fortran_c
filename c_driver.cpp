#include "c.h"
#include <iostream>
#include <cstring>

using namespace std ; 

void print_array(int *, int) ; 

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
    set_int_c(&setme) ; 
    cout << "C set the value to: " << setme << endl ; 
    set_int_f(&setme) ; 
    cout << "Fortran set the value to: " << setme << endl ; 

    // returning an integer between languages
    setme = ret_int_c() ; 
    cout << "C set the value to: " << setme << endl ; 
    setme = ret_int_f() ; 
    cout << "Fortran set the value to: " << setme << endl ; 

    // Setting elements of array in foreign language
    const int npts = 5 ; 
    int array[npts] ; 
    set_intarray_c(array, npts) ; 
    cout << "From C: " << endl ; 
    print_array(array, npts) ; 
    set_intarray_f(array, npts) ; 
    cout << "From FORTRAN: " << endl ; 
    print_array(array, npts) ; 


    // printing a character string from foreign languages
    char message[] = "Hello, world!" ; 
    print_chararray_c(message, strlen(message)) ; 
    print_chararray_f(message, strlen(message)) ; 
    
    return 0 ; 
}

void
print_array(int *array, int npts) { 
    for (int i=0; i<npts; i++) {
        cout << "(" << i << ")= " << array[i] << endl ; 
    }
}
