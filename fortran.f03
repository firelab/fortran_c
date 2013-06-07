module fortran

use iso_c_binding

interface 
    subroutine hello_c() bind (C, name="hello_c")
    end subroutine
end interface

interface
    subroutine print_int_c(pic) bind(C, name="print_int_c")
    use iso_c_binding
    integer (c_int), value, intent(in) :: pic
    end subroutine
end interface

interface
    subroutine set_int_c(sic) bind(C, name="set_int_c")
    use iso_c_binding
    integer (c_int), intent(out) :: sic
    end subroutine
end interface


interface
    function ret_int_c() bind(C, name="ret_int_c")
    use iso_c_binding
    integer (c_int) :: ret_int_c
    end function
end interface

contains

subroutine hello_f() bind (C, name="hello_f")
    print *, "Hello world from fortran!"
end subroutine

subroutine print_int_f(pif) bind (C, name='print_int_f')
    integer (c_int), value, intent(in) :: pif
    print *, "Number in fortran: ", pif
end subroutine

subroutine set_int_f(sif) bind (C, name='set_int_f')
    integer (c_int), intent(out) :: sif
    sif = 42 ; 
end subroutine

function ret_int_f() bind(C, name='ret_int_f')
    integer(c_int) :: ret_int_f
    ret_int_f = 42
end function

end module 
