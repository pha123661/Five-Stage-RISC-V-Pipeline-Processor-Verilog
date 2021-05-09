# This example shows an implementation of the mathematical
# factorial function (! function).

.data
argument: .word 7 # Number to find the factorial value of
str1: .string "Factorial value of "
str2: .string " is "

.text
main:
        lw       a0, argument                   1
        jal      ra, fact                       2

        # Print the result to console
        mv       a1, a0                         102
        lw       a0, argument                   103
        jal      ra, printResult                104

        # Exit program
        li       a0, 10                         120
        ecall                                   121

fact:                                          
        addi     sp, sp, -16                    3       10      17      24      31      38      45      52
        sw       ra, 8(sp)                      4       11      18      25      32      39      46      53
        sw       a0, 0(sp)                      5       12      19      26      33      40      47      54
        addi     t0, a0, -1                     6       13      20      27      34      41      48      55
        bge      t0, zero, nfact                7       14      21      28      35      42      49      56
 
        addi     a0, zero, 1                                                                            57
        addi     sp, sp, 16                                                                             58
        jalr     x0, x1, 0                                                                              59

nfact:                          
        addi     a0, a0, -1                     8       15      22      29      36      43      50
        jal      ra, fact                       9       16      23      30      37      44      51

        addi     t1, a0, 0                      96      90      84      78      72      66      60
        lw       a0, 0(sp)                      97      91      85      79      73      67      61
        lw       ra, 8(sp)                      98      92      86      80      74      68      62
        addi     sp, sp, 16                     99      93      87      81      75      69      63

        mul      a0, a0, t1                     100     94      88      82      76      70      64
        ret                                     101     95      89      83      77      71      65
        #jalr x0, ra, 0

# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv       t0, a0                        105
        mv       t1, a1                        106

        la       a1, str1                      107
        li       a0, 4                         108
        ecall                                  109

        mv       a1, t0                        110
        li       a0, 1                         111
        ecall                                  112

        la       a1, str2                      113
        li       a0, 4                         114
        ecall                                  115

        mv       a1, t1                        116
        li       a0, 1                         117
        ecall                                  118

        ret                                    119
