playSound(val1, val2) {
  if(val1 == 0 || val1 == 1 || val1 == 8) {
    r2 = 0x3C + (val2 % 16)
    0x000C61D4(val1, val2 / 16, r2) // second, third param as byte
  }
  else if(val1 >= 3 && val1 < 8) {
    0x000C61D4(val1, val2, val2) // third param as byte
  }
}

0x000c6374 addiu r29,r29,0xffe8
0x000c6378 addu r7,r4,r0
0x000c637c beq r7,r0,0x000c639c
0x000c6380 sw r31,0x0010(r29)
0x000c6384 addiu r1,r0,0x0001
0x000c6388 beq r7,r1,0x000c639c
0x000c638c nop
0x000c6390 addiu r1,r0,0x0008
0x000c6394 bne r7,r1,0x000c63e8
0x000c6398 nop
0x000c639c bgez r5,0x000c63ac
0x000c63a0 sra r25,r5,0x04
0x000c63a4 addiu r2,r5,0x000f
0x000c63a8 sra r25,r2,0x04
0x000c63ac sll r3,r25,0x18
0x000c63b0 sra r3,r3,0x18
0x000c63b4 bgez r5,0x000c63c8
0x000c63b8 andi r2,r5,0x000f
0x000c63bc beq r2,r0,0x000c63c8
0x000c63c0 nop
0x000c63c4 addiu r2,r2,0xfff0
0x000c63c8 addi r2,r2,0x003c
0x000c63cc sll r6,r2,0x18
0x000c63d0 sra r6,r6,0x18
0x000c63d4 addu r4,r7,r0
0x000c63d8 jal 0x000c61d4
0x000c63dc addu r5,r3,r0
0x000c63e0 beq r0,r0,0x000c6414
0x000c63e4 lw r31,0x0010(r29)
0x000c63e8 slti r1,r7,0x0003
0x000c63ec bne r1,r0,0x000c6410
0x000c63f0 nop
0x000c63f4 slti r1,r7,0x0008
0x000c63f8 beq r1,r0,0x000c6410
0x000c63fc nop
0x000c6400 sll r6,r5,0x18
0x000c6404 sra r6,r6,0x18
0x000c6408 jal 0x000c61d4
0x000c640c addu r5,r0,r0
0x000c6410 lw r31,0x0010(r29)
0x000c6414 nop
0x000c6418 jr r31
0x000c641c addiu r29,r29,0x0018