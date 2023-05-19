LLB R3, 2
LLB R4, 1
nand r5, r3, r4
llb r6, 3
llb r7, 12
or r8, r6, r7
llb r9, 0
not r9, r9
llb r10, 0xff
lhb r10, 0xff
llb r11, 0xff
lhb r11, 0xff
xor r12, r11, r10
xnor r13, r11, r10
llb r14, 0x00
lhb r14, 0x80
llb r15, 0x00
lhb r15, 0x80
umulo r16, r14, r15
llb r17, 0x80
lhb r17, 0X01
llb r18, 0x80
lhb r18, 0X01
UMULC r19, r17, r18
llb r20, 0x80
llb r21, 0x80
smul r22, r20, r21
llb r23, 0x20
addi r24, r23, 1
subi r25, r23, 1
andi r26, r23, 1
nandi r27, r23, 1
ori r28, r23, 0xf
nori r29, r23, 0xf
xori r30, r23, 1
xnori r31, r23, 1
umuli r32, r23, 2
smuli r33, r23, -2
addii r34, 32, 32
subii r35, 33, 33
mulii r36, 5, 40