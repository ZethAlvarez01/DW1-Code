void resetFlatten(combatId) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + combatId + 0x066C)
  entityPtr = load(0x12F344 + entityId * 4)
  combatPtr = combatHead + combatId * 0x168
  
  flags = load(combatPtr + 0x34) & 0xFFF7
  
  store(combatPtr + 0x22, 0)
  store(combatPtr + 0x34, flags)
  store(entityPtr + 0x36, -1)
  
  digimonType = load(entityPtr)
  nodePtr = load(entityPtr + 0x04)
  
  if(digimonType != 0x71) {
    store(nodePtr + 0x60, 0x1000)
    store(nodePtr + 0x64, 0x1000)
    store(nodePtr + 0x68, 0x1000)
  }
  else { // Meteormon??
    store(nodePtr + 0x60, 0x1800)
    store(nodePtr + 0x64, 0x1800)
    store(nodePtr + 0x68, 0x1800)
  }
}

0x00059078 lw r2,-0x6de0(r28)
0x0005907c addu r6,r4,r0
0x00059080 addu r7,r2,r0
0x00059084 addu r2,r4,r2
0x00059088 lbu r2,0x066c(r2)
0x0005908c addiu r1,r0,0x0071
0x00059090 sll r3,r2,0x02
0x00059094 lui r2,0x8013
0x00059098 addiu r2,r2,0xf344
0x0005909c addu r2,r2,r3
0x000590a0 lw r5,0x0000(r2)
0x000590a4 sll r2,r6,0x04
0x000590a8 sub r3,r2,r6
0x000590ac sll r2,r3,0x02
0x000590b0 sub r2,r2,r3
0x000590b4 sll r2,r2,0x03
0x000590b8 addu r3,r7,r2
0x000590bc addiu r2,r0,0xffff
0x000590c0 sb r2,0x0036(r5)
0x000590c4 lhu r2,0x0034(r3)
0x000590c8 nop
0x000590cc andi r2,r2,0xfff7
0x000590d0 sh r2,0x0034(r3)
0x000590d4 sh r0,0x0022(r3)
0x000590d8 lw r2,0x0000(r5)
0x000590dc nop
0x000590e0 beq r2,r1,0x00059110
0x000590e4 nop
0x000590e8 addiu r4,r0,0x1000
0x000590ec lw r2,0x0004(r5)
0x000590f0 addu r3,r4,r0
0x000590f4 sw r4,0x0060(r2)
0x000590f8 lw r2,0x0004(r5)
0x000590fc nop
0x00059100 sw r3,0x0064(r2)
0x00059104 lw r2,0x0004(r5)
0x00059108 beq r0,r0,0x00059138
0x0005910c sw r4,0x0068(r2)
0x00059110 addiu r4,r0,0x1800
0x00059114 lw r2,0x0004(r5)
0x00059118 addu r3,r4,r0
0x0005911c sw r4,0x0060(r2)
0x00059120 lw r2,0x0004(r5)
0x00059124 nop
0x00059128 sw r3,0x0064(r2)
0x0005912c lw r2,0x0004(r5)
0x00059130 nop
0x00059134 sw r4,0x0068(r2)
0x00059138 jr r31
0x0005913c nop