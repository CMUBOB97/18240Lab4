         .ORG    $2000
ARRAY    .DW     $ABAB
         .DW     $ABAB
         .DW     $BCBC
         .DW     $BCBC
         .DW     $DEDE
         .DW     $DEDE
         .DW     $F0F0
         .DW     $F0F0
LENGTH   .DW     $0004
         .ORG    $3000
SUM      .DW     $0
         .DW     $0
         .ORG    $0

INIT     MV      r1, r0 ; set r1 = 0 (index i)
         MV      r2, r0 ; set sum low bits to 0
         MV      r3, r0 ; set sum high bits to 0
         LW      r6, r0, LENGTH ; load the length of the array

LOOP     SLLI    r1, r1, $2 ; each number is 32 bits long
         LW      r5, r1, ARRAY ; load 31-16 bits of ARRAY[i] into r5
         LW      r4, r1, ARRAY ; load 15-0 bits of ARRAY[i] into r4
         .DW     $6494   ; use the new ADD32 instruction
         SRAI    r1, r1, $2 ; restore r1
         ADDI    r1, r1, $1 ; increment r1 by 1
         SLT     r0, r1, r6 ; check if r1 < r6 (length)
         BRN     LOOP ; if so, keep finding the sum

DONE     SW      r0, r3, SUM ; store higher bits in SUM
         LI      r7, $2 ; load r7 as 2
         SW      r7, r2, SUM ; store lower bits in SUM
         STOP