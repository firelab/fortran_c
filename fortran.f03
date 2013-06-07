module fortran

use iso_c_binding
implicit none

interface 
    subroutine hello_c() bind (C, name="hello_c")
    end subroutine
end interface

interface
    subroutine print_int_c(pic) bind(C, name="print_int_c")
    use iso_c_binding
    implicit none
    integer (c_int), value, intent(in) :: pic
    end subroutine
end interface

interface
    subroutine set_int_c(sic) bind(C, name="set_int_c")
    use iso_c_binding
    implicit none
    integer (c_int), intent(out) :: sic
    end subroutine
end interface


interface
    function ret_int_c() bind(C, name="ret_int_c")
    use iso_c_binding
    implicit none
    integer (c_int) :: ret_int_c
    end function
end interface

interface 
    subroutine set_intarray_c(sac, npts) bind(C, name='set_intarray_c')
    use iso_c_binding
    implicit none
    integer(c_int), intent(inout), dimension(npts) :: sac
    integer(c_int), intent(in), value              :: npts
    end subroutine
end interface

interface 
    subroutine print_chararray_c(str, strlen) bind(C, name='print_chararray_c')
    use iso_c_binding
    implicit none
    character(c_char), dimension(strlen), intent(in) :: str
    integer(c_int), intent(in), value                :: strlen
    end subroutine
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

subroutine set_intarray_f(saf,npts) bind(C, name='set_intarray_f')
    integer(c_int), intent(in), value :: npts
    integer(c_int), dimension(npts), intent(inout) :: saf

    integer :: i

    do, i=1,npts
        saf(i) = npts-i
    end do
end subroutine

!
! No special string conversion is needed here, so long as "strlen"
! is the actual length of the string. (i.e., there should be no 
! extra room at the end of the string and no need for it to be 
! padded with spaces.
!
subroutine print_chararray_f(str, strlen) bind(C, name='print_chararray_f')
    character(c_char), dimension(strlen), intent(in) :: str
    integer(c_int), intent(in), value :: strlen
    print *, 'Fortran prints: ', str
end subroutine

end module 
