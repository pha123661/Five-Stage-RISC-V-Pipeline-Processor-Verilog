.data
argument: .word 10
data: .word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1
str1: .string "Array: "
str2: .string "Sorted: "
str3: .string " "
str4: .string "\n"

.text
main:
	addi t1, zero, 5
	# stores array to x22
	la   x22, data

 	# N = 10
	lw   s0, argument  

	# print "Array: \n"
	la   a1, str1		
	li   a0, 4
	ecall
	la   a1, str4		
	li   a0, 4
	ecall

	# print actual array
	jal  ra, printArray
	# sort
	jal  ra, bubblesort

	#print "Sorted: \n"
	la   a1, str2   
	li 	 a0, 4
	ecall
	la   a1, str4		
	li   a0, 4
	ecall
	
	# print actual array
	jal  ra, printArray

	# exit
	li   a0, 10
	ecall

bubblesort:
	addi sp, sp, -48
	sw   x23, 0(sp)
	sw   x24, 8(sp)	
	sw   t1, 16(sp)
	sw   t2, 24(sp)
	sw   x20, 32(sp)
	sw   ra, 40(sp)
	li   x23, 0   #i = x23
	for1loop:
	bge  x23, s0, for1exit
	addi x24, x23, -1   #j = x24
	for2loop:
	blt  x24, zero, for2exit
	slli x10, x24, 2
	add  x10, x10, x22
	lw   t1, 0(x10)  #v[j]
	lw   t2, 4(x10)	 #v[j+1]
	bge  t2, t1, for2exit
	mv   x20, x24
	jal  ra, swap
	addi x24, x24, -1
	j    for2loop
	for2exit:
	addi x23, x23, 1
	j    for1loop
	for1exit:
	lw   x23, 0(sp)
	lw   x24, 8(sp)
	lw   t1, 16(sp)
	lw   t2, 24(sp)
	lw   x20, 32(sp)
	lw   ra, 40(sp)
	addi sp, sp, 48
	ret
	
swap:
	slli x10, x20, 2    #k = x20
	add  x10, x10, x22
	lw   t3, 0(x10)
	lw   t4, 4(x10)
	sw   t3, 4(x10)
	sw   t4, 0(x10)
	ret

printArray:
	li   x19, 0     # i = x19 N = s0
	loop:
	bge  x19, s0, exit
	slli x10, x19, 2
	add  x10, x10, x22
	lw   t0, 0(x10) # print Array[i]
	mv   a1, t0
	li   a0, 1
	ecall
	la   a1, str3
	li   a0, 4
	ecall
	addi x19, x19, 1
	j    loop
	exit:
	la   a1, str4
	li   a0, 4
	ecall
	ret	