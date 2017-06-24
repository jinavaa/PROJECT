	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"sensor.c"
	.global	data
	.bss
	.align	2
	.type	data, %object
	.size	data, 20
data:
	.space	20
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Humedad = %.1f %% Temperatura = %.1f *C (%.1f *F)\012"
	.ascii	"\000"
	.align	2
.LC1:
	.ascii	"Lectura inv\303\241lida\000"
	.text
	.align	2
	.global	read_dht_data
	.type	read_dht_data, %function
read_dht_data:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	mov	r3, #1
	strb	r3, [fp, #-5]
	mov	r3, #0
	strb	r3, [fp, #-6]
	mov	r3, #0
	strb	r3, [fp, #-7]
	ldr	r3, .L20+20
	mov	r2, #0
	str	r2, [r3, #16]
	ldr	r3, .L20+20
	ldr	r3, [r3, #16]
	ldr	r2, .L20+20
	str	r3, [r2, #12]
	ldr	r3, .L20+20
	ldr	r3, [r3, #12]
	ldr	r2, .L20+20
	str	r3, [r2, #8]
	ldr	r3, .L20+20
	ldr	r3, [r3, #8]
	ldr	r2, .L20+20
	str	r3, [r2, #4]
	ldr	r3, .L20+20
	ldr	r3, [r3, #4]
	ldr	r2, .L20+20
	str	r3, [r2]
	mov	r0, #3
	mov	r1, #1
	bl	gpioSetMode
	mov	r0, #3
	mov	r1, #0
	bl	gpioWrite
	mov	r0, #18
	bl	delay
	mov	r0, #3
	mov	r1, #0
	bl	gpioSetMode
	mov	r3, #0
	strb	r3, [fp, #-8]
	b	.L2
.L10:
	mov	r3, #0
	strb	r3, [fp, #-6]
	b	.L3
.L5:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	add	r3, r3, #1
	strb	r3, [fp, #-6]
	mov	r0, #1
	bl	delayMicroseconds
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #255
	bne	.L3
	b	.L4
.L3:
	mov	r0, #3
	bl	gpioRead
	mov	r2, r0
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L5
.L4:
	mov	r0, #3
	bl	gpioRead
	mov	r3, r0
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #255
	bne	.L6
	b	.L7
.L6:
	ldrb	r3, [fp, #-8]	@ zero_extendqisi2
	cmp	r3, #3
	bls	.L8
	ldrb	r3, [fp, #-8]
	and	r3, r3, #1
	uxtb	r3, r3
	cmp	r3, #0
	bne	.L8
	ldrb	r3, [fp, #-7]	@ zero_extendqisi2
	mov	r3, r3, lsr #3
	uxtb	r3, r3
	mov	r1, r3
	mov	r2, r3
	ldr	r3, .L20+20
	ldr	r3, [r3, r2, asl #2]
	mov	r3, r3, asl #1
	ldr	r2, .L20+20
	str	r3, [r2, r1, asl #2]
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #16
	bls	.L9
	ldrb	r3, [fp, #-7]	@ zero_extendqisi2
	mov	r3, r3, lsr #3
	uxtb	r3, r3
	mov	r1, r3
	mov	r2, r3
	ldr	r3, .L20+20
	ldr	r3, [r3, r2, asl #2]
	orr	r3, r3, #1
	ldr	r2, .L20+20
	str	r3, [r2, r1, asl #2]
.L9:
	ldrb	r3, [fp, #-7]	@ zero_extendqisi2
	add	r3, r3, #1
	strb	r3, [fp, #-7]
.L8:
	ldrb	r3, [fp, #-8]	@ zero_extendqisi2
	add	r3, r3, #1
	strb	r3, [fp, #-8]
.L2:
	ldrb	r3, [fp, #-8]	@ zero_extendqisi2
	cmp	r3, #84
	bls	.L10
.L7:
	ldrb	r3, [fp, #-7]	@ zero_extendqisi2
	cmp	r3, #39
	bls	.L11
	ldr	r3, .L20+20
	ldr	r2, [r3, #16]
	ldr	r3, .L20+20
	ldr	r1, [r3]
	ldr	r3, .L20+20
	ldr	r3, [r3, #4]
	add	r1, r1, r3
	ldr	r3, .L20+20
	ldr	r3, [r3, #8]
	add	r1, r1, r3
	ldr	r3, .L20+20
	ldr	r3, [r3, #12]
	add	r3, r1, r3
	uxtb	r3, r3
	cmp	r2, r3
	bne	.L11
	ldr	r3, .L20+20
	ldr	r3, [r3]
	mov	r2, r3, asl #8
	ldr	r3, .L20+20
	ldr	r3, [r3, #4]
	add	r3, r2, r3
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	flds	s14, .L20
	fdivs	s15, s15, s14
	fsts	s15, [fp, #-12]
	flds	s15, [fp, #-12]
	flds	s14, .L20+4
	fcmpes	s15, s14
	fmstat
	ble	.L12
	ldr	r3, .L20+20
	ldr	r3, [r3]
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	fsts	s15, [fp, #-12]
.L12:
	ldr	r3, .L20+20
	ldr	r3, [r3, #8]
	and	r3, r3, #127
	mov	r2, r3, asl #8
	ldr	r3, .L20+20
	ldr	r3, [r3, #12]
	add	r3, r2, r3
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	flds	s14, .L20
	fdivs	s15, s15, s14
	fsts	s15, [fp, #-16]
	flds	s15, [fp, #-16]
	flds	s14, .L20+8
	fcmpes	s15, s14
	fmstat
	ble	.L14
	ldr	r3, .L20+20
	ldr	r3, [r3, #8]
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	fsts	s15, [fp, #-16]
.L14:
	ldr	r3, .L20+20
	ldr	r3, [r3, #8]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L16
	flds	s15, [fp, #-16]
	fnegs	s15, s15
	fsts	s15, [fp, #-16]
.L16:
	flds	s15, [fp, #-16]
	flds	s14, .L20+12
	fmuls	s15, s15, s14
	flds	s14, .L20+16
	fadds	s15, s15, s14
	fsts	s15, [fp, #-20]
	flds	s15, [fp, #-12]
	fcvtds	d5, s15
	flds	s15, [fp, #-16]
	fcvtds	d6, s15
	flds	s15, [fp, #-20]
	fcvtds	d7, s15
	fstd	d6, [sp]
	fstd	d7, [sp, #8]
	ldr	r0, .L20+24
	fmrrd	r2, r3, d5
	bl	printf
	b	.L1
.L11:
	ldr	r0, .L20+28
	bl	puts
.L1:
	sub	sp, fp, #4
	@ sp needed
	ldmfd	sp!, {fp, pc}
.L21:
	.align	2
.L20:
	.word	1092616192
	.word	1120403456
	.word	1123680256
	.word	1072064102
	.word	1107296256
	.word	data
	.word	.LC0
	.word	.LC1
	.size	read_dht_data, .-read_dht_data
	.section	.rodata
	.align	2
.LC2:
	.ascii	"Raspberry Pi 3 Lector de temperatura y humedad\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	bl	gpioInitialise
	mov	r3, r0
	cmp	r3, #0
	bge	.L23
	mvn	r3, #0
	b	.L26
.L23:
	ldr	r0, .L27
	bl	puts
	bl	wiringPiSetup
	mov	r3, r0
	cmn	r3, #1
	bne	.L25
	mov	r0, #1
	bl	exit
.L25:
	bl	read_dht_data
	mov	r0, #2000
	bl	delay
	b	.L25
.L26:
	mov	r0, r3
	ldmfd	sp!, {fp, pc}
.L28:
	.align	2
.L27:
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
