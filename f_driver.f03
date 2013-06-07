program f_driver

use fortran
implicit none

integer :: setme

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


end program
