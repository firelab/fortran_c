
extern "C" {
    void hello_c(void) ; 
    void hello_f(void) ; 

    void print_int_c(int pic); 
    void print_int_f(int pif);

    // the parameters here may be either: 
    //    int &sic 
    // or int *sic
    // both work with the same fortran interface.
    void set_int_c(int *sic) ; 
    void set_int_f(int *sif) ;

    int ret_int_c(void) ; 
    int ret_int_f(void) ; 
} ; 
