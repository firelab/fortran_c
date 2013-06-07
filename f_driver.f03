program f_driver

use fortran
implicit none

integer :: setme
integer, parameter :: npts = 5 
integer, dimension(npts) :: array

! basic print statement
call hello_f
call hello_c

! pass an integer
call print_int_f(27)
call print_int_c(27)

! set an integer value cross-language
call set_int_f(setme)
print *, "Fortran set the value to: ", setme
call set_int_c(setme)
print *, "C set the value to: ", setme

! return an integer value cross-language
setme = ret_int_f()
print *, "Fortran set the value to: ", setme
setme = ret_int_c()
print *, "C set the value to: ", setme

! set all the values in an array cross-language
call set_intarray_f(array, npts)
print *, "From FORTRAN:"
call print_array(array)
call set_intarray_c(array, npts)
print *, "From C:"
call print_array(array)


contains

subroutine print_array(a)
    integer, dimension(:) :: a
    integer :: i

    do, i=1,size(a)
        print *, '(', i, ')=', a(i)
    end do 
end subroutine

end program
