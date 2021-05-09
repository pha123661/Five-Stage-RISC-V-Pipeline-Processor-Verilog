.data
N: .word 7
str1: .string "th number in the Fibonacci sequence is "
str2: .string "\n"

.text
main:
	lw s0, N
	mv s1, s0
	addi s2, zero, 1

	jal ra, fibonacci

	mv a1, s0
	li a0, 1
	ecall

	la a1, str1
	li a0, 4
	ecall

	mv a1, a2
	li a0, 1
	ecall

	la a1, str2
	li a0, 4
	ecall

	li a0, 10
	ecall

fibonacci:
	addi sp, sp, -32  			#
	sw   ra, 24(sp)				#
	sw   s2, 16(sp)				#
	sw   s1, 8(sp)				#
  	sw   s0, 0(sp)				#
	blt  s2, s1, nfibonacci		#
	beq  s1, s2, ro				#
	addi sp, sp, 32				#
	jalr x0, x1, 0				#
ro:
	addi a2, a2, 1				#
	addi sp, sp, 32				#
	ret							#
nfibonacci:
	addi s1, s1, -1				#
	jal  ra, fibonacci			#
	lw   s0, 0(sp)				#
	lw   s1, 8(sp)				#
	lw   s2, 16(sp)				#
	lw   ra, 24(sp)  			#
	addi sp, sp, 32				#
	addi s1, s1, -2				#
	ble  zero, s1, fibonacci	#
  	ret							#