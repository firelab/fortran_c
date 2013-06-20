module fortran

use iso_c_binding
implicit none

type :: f_class
    private
    character(c_char), allocatable, dimension(:) :: f_string
contains
    procedure :: getString => getString_f_class
end type
type(f_class),pointer :: temporary
type(c_ptr) :: temp_ptr

interface f_class
    procedure construct_f_class
end interface

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

interface
    subroutine ret_chararray_c(str, strlen) bind(C, name="ret_chararray_c")
    use iso_c_binding
    implicit none
    character(c_char), dimension(strlen), intent(out) :: str
    integer(c_int), intent(inout)                     :: strlen
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

!
! Returning a character array (or presumably any array) may not be doable 
! in the "normal" intra-language way (using a function). This is because
! we need to separately pass the array pointer and the array length. More
! generally, the shape of the array if it's multidimensional.
!
! For this strategy, the caller supplies the buffer into which the
! string is copied and also supplies the length of the buffer. On return
! "strlen" is set to the length of the actual content.
!
subroutine ret_chararray_f(str, strlen) bind(C, name='ret_chararray_f')
    character(c_char), intent(out), dimension(strlen)  :: str
    integer(c_int), intent(inout)                  :: strlen
    character(len=*), parameter :: message = "Hello, world!"
    integer :: i
    integer :: break 

    break  = min(strlen, len(message))
    do i=1,break
        str(i) = message(i:i)
    end do
    if (break < strlen) then 
        do i=break+1, strlen
            str(i) = ' '
        end do 
    end if
    strlen = len(message)
end subroutine

!
! Constructor for a simple fortran class that remembers a string.
! You provide the string.
!
function construct_f_class(str, strlen)
    character, dimension(strlen) :: str
    integer                      :: strlen
    TYPE(f_class), pointer       :: construct_f_class

    ALLOCATE(construct_f_class)
    ALLOCATE(construct_f_class%f_string(strlen))
    construct_f_class%f_string(:) = str(:)
end function

function getString_f_class(self)
    CLASS(f_class) :: self
    character, dimension(:), pointer :: getString_f_class

    integer :: f_strlen
    f_strlen = size(self%f_string)

    ALLOCATE(getString_f_class(f_strlen))
    if (associated(getString_f_class)) then 
        getString_f_class(:) = self%f_string(:)
    end if
end function

!
! Provide a C interface to the creation of a fortran object.
! Return the object as a C_PTR.
!
function create_f_class(str, strlen) bind(C, name='create_f_class')
    character(c_char), dimension(strlen) :: str
    integer(c_int), value                :: strlen
    type(c_ptr)                          :: create_f_class

    type(f_class), pointer       :: check

    temporary => f_class(str, strlen)
    create_f_class = c_loc(temporary)
    temp_ptr = create_f_class

    if (c_associated(temp_ptr, create_f_class)) then 
        print *, "Good pointer comparison" 
    end if

    call c_f_pointer(create_f_class, check)
    if (associated(check, temporary)) then
        print *, "Good round trip pointer conversion"
    else
        print *, "Bad round-trip conversion"
    end if
end function

!
! Provide C bindings to the accessor method of a fortran object.
!
subroutine getString_f_class_c(obj, str, strlen) bind(C, name='getString_f_class_c')
    type(c_ptr) :: obj
    character(c_char), dimension(strlen) :: str
    integer(c_int), intent(inout)       :: strlen
    type(f_class), pointer :: obj_f

    integer                      :: copychars
    character, dimension(:), pointer :: f_string

    if (.not. c_associated(obj, temp_ptr)) then 
        print *, "C passed us a bum pointer"
    end if 

    call c_f_pointer(obj, obj_f)
    if (.not. associated(obj_f)) then 
        print *, "GACK! Fortran pointer not associated!"
    end if 
    if (.not. associated(obj_f, temporary)) then 
        print *, "Wrong pointer!"
    end if 
!    f_string => temporary%getString()
    f_string => obj_f%getString()
    
    copychars = min(strlen, size(f_string))
    
    str(:copychars) = f_string(:copychars)
    strlen = copychars
    deallocate(f_string)
end subroutine

end module 
