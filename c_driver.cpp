#include "c.h"
#include <iostream>
#include <cstring>
#include <string>

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
    const char message[] = "Hello, world!" ; 
    print_chararray_c(message, strlen(message)) ; 
    print_chararray_f(message, strlen(message)) ; 

    // retrieving a character string from foreign languages
    const int strsize = 50 ; 
    char msg[strsize] ; 

    setme = strsize ; 
    ret_chararray_c(msg, setme) ; 
    cout << "C gives: " << msg << "  (" << setme << ")"<< endl ; 
    setme = strsize ; 
    ret_chararray_f(msg, setme) ;
    cout << "Fortran gives " << string(msg,setme) << "  ("<<setme<<")"<< endl ; 

    void *f_struct = opaque_allocate() ; 
    print_opaque(f_struct) ; 

    // create a fortran object which can store a string.
    //F_CLASS *f_obj = create_f_class(message, strlen(message)) ; 
    void *f_obj = create_f_class(message, strlen(message)) ; 
    if (f_obj == (F_CLASS*)0) { 
        cout << "Creating a Fortran object from C failed.\n" ; 
    } else { 
        // retrieve the message and print it
        setme = strsize ; 
        msg[0] = msg[1] = (char)0;
        getString_f_class_c(f_obj, msg, setme) ; 
        cout << "Our stored message is: " << msg << endl ; 
    }
    
    return 0 ; 
}

void
print_array(int *array, int npts) { 
    for (int i=0; i<npts; i++) {
        cout << "(" << i << ")= " << array[i] << endl ; 
    }
}
