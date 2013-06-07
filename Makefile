

%.o : %.f03
	gfortran -c -o $@ $<

%.o : %.cpp
	g++ -c -o $@ $<

OBJS=c.o fortran.o

all: f_driver_ldc c_driver_ldc f_driver_ldf c_driver_ldf
clean:
	rm -f *.o *.mod

f_driver_ldc: f_driver.o $(OBJS)
	g++ -o f_driver_ldc f_driver.o $(OBJS) -lgfortran
c_driver_ldc: c_driver.o $(OBJS)
	g++ -o c_driver_ldc c_driver.o $(OBJS) -lgfortran
f_driver_ldf: f_driver.o $(OBJS)
	gfortran -o f_driver_ldf f_driver.o $(OBJS) -lstdc++
c_driver_ldf: c_driver.o $(OBJS)
	gfortran -o c_driver_ldf c_driver.o $(OBJS) -lstdc++


f_driver.o : fortran.o
