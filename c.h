
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

    void set_intarray_c(int *, int) ; 
    void set_intarray_f(int *, int) ;

    void print_chararray_c(const char *, int) ; 
    void print_chararray_f(const char *, int) ;

    void ret_chararray_c(char *, int &) ; 
    void ret_chararray_f(char *, int &) ; 
} ; 
