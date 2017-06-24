build: pre compile asm linker

pre:
	cpp sensor.c > sensor.i

compile:
	gcc -S sensor.i

asm:
	as -o sensor.o sensor.s

linker:
	gcc -Wall sensor.c -o sensor -lwiringPi -lpigpio -lrt

run:
	sudo ./sensor

clean:
	rm sensor.i sensor.s sensor.o sensor.exe
