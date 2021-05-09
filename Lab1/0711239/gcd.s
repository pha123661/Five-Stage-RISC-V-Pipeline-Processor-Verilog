.data
N1: .word 4
N2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw       s0, N1 
				lw       s1, N2  
        jal      ra, gcd       

        jal      ra, printResult

        li       a0, 10
        ecall

gcd:
        addi     sp, sp, -32    # 1 12 23
        sw       ra, 24(sp)     # 2 13 24
				sw       s2, 16(sp)     # 3 14 25
				sw       s1, 8(sp)      # 4 15 26
        sw       s0, 0(sp)      # 5 16 27
        mv       t0, s1         # 6 17 28
        blt      zero, t0, ngcd # 7 18 29
				mv       a0, s0         # 30 39
        addi     sp, sp, 32     # 31 40
        jalr     x0, x1, 0      # 32 41

ngcd:
				rem			 s2, s0, s1     # 8 19 
        mv       s0, s1         # 9 20 
				mv       s1, s2         # 10 21 
        jal      ra, gcd        # 11 22 

        lw       s0, 0(sp)      # 33
				lw       s1, 8(sp)      # 34
				lw       s2, 16(sp)     # 35
        lw       ra, 24(sp)     # 36
        addi     sp, sp, 32     # 37
        ret                     # 38

printResult:
        mv       t0, a0
        mv       t1, a1

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, s0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, s1
        li       a0, 1
        ecall

				la       a1, str3
        li       a0, 4
        ecall

				mv       a1, t0
        li       a0, 1
        ecall
        ret
