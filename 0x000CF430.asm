void 0x000CF430() {
  val1 = load(0x14EDE7)
  val2 = load(0x14EDEC)
  val3 = load(0x14EDFA)
  
  store(0x14EDFC, val3 * 8)
  store(0x14EDFE, val2 + val1 * 0x10)
  store(0x14E6FE + val3 * 0x36, 0x7FFF)
  
  for(i = 0; i < 0x10; i++) {
    r3 = load(0x14E6B8 + i * 4)
    store(0x14E6B8 + i * 4, r3 & ~(1 << val3))
  }
  
  val4 = load(0x14EF48)
  val5 = load(0x14EDF8)
  
  r2 = (val5 - 1) / 2
  
  if(val5 % 2 == 1)
    r2 = load(val4 + r2 * 0x10 + 0x0C)
  else
    r2 = load(val4 + r2 * 0x10 + 0x0E)
    
  val7 = load(0x14EDFC) * 2
  store(0x14EC36 + val7, r2)
  
  r2 = load(0x14EC18 + val3) | 0x0008
  store(0x14EC18 + val3, r2)
  
  val6 = load(0x14EF4C)
  r2 = load(val6 + val1 * 0x0200 + val2 * 0x0020 + 0x10)
  store(0x14EC38 + val7, r2)
  
  r2 = load(val6 + val1 * 0x0200 + val2 * 0x0020 + 0x12)
  r5 = load(0x14EE00)
  store(0x14EC3A + val7, r2 + r5)
  
  r2 = load(0x14EC18 + val3) | 0x0030
  store(0x14EC18 + val3, r2)
}

0x000cf430 addu r8,r0,r0
0x000cf434 lui r5,0x8015
0x000cf438 addiu r5,r5,0xedfc
0x000cf43c addiu r10,r5,0xfffe
0x000cf440 addiu r9,r0,0x0001
0x000cf444 lui r7,0x8015
0x000cf448 addiu r7,r7,0xe6b8
0x000cf44c lbu r3,-0x0010(r5)
0x000cf450 lh r6,-0x0002(r5)
0x000cf454 lb r4,-0x0015(r5)
0x000cf458 sll r3,r3,0x18
0x000cf45c sra r3,r3,0x18
0x000cf460 sll r2,r6,0x03
0x000cf464 sll r4,r4,0x04
0x000cf468 addu r3,r3,r4
0x000cf46c sh r2,0x0000(r5)
0x000cf470 subu r2,r2,r6
0x000cf474 sll r2,r2,0x02
0x000cf478 subu r2,r2,r6
0x000cf47c sll r2,r2,0x01
0x000cf480 sh r3,0x0002(r5)
0x000cf484 addiu r3,r0,0x7fff
0x000cf488 lui r1,0x8015
0x000cf48c addu r1,r1,r2
0x000cf490 sh r3,-0x1902(r1)
0x000cf494 addiu r8,r8,0x0001
0x000cf498 lh r2,0x0000(r10)
0x000cf49c lw r3,0x0000(r7)
0x000cf4a0 sllv r2,r9,r2
0x000cf4a4 nor r2,r0,r2
0x000cf4a8 and r3,r3,r2
0x000cf4ac sw r3,0x0000(r7)
0x000cf4b0 slti r2,r8,0x0010
0x000cf4b4 bne r2,r0,0x000cf494
0x000cf4b8 addiu r7,r7,0x0004
0x000cf4bc lui r4,0x8015
0x000cf4c0 addiu r4,r4,0xedf8
0x000cf4c4 lhu r3,0x0000(r4)
0x000cf4c8 nop
0x000cf4cc andi r2,r3,0x0001
0x000cf4d0 blez r2,0x000cf50c
0x000cf4d4 sll r2,r3,0x10
0x000cf4d8 sra r2,r2,0x10
0x000cf4dc addiu r2,r2,0xffff
0x000cf4e0 srl r3,r2,0x1f
0x000cf4e4 addu r2,r2,r3
0x000cf4e8 sra r2,r2,0x01
0x000cf4ec lui r3,0x8015
0x000cf4f0 lw r3,-0x10b8(r3)
0x000cf4f4 sll r2,r2,0x04
0x000cf4f8 addu r2,r2,r3
0x000cf4fc lh r3,0x0004(r4)
0x000cf500 lhu r2,0x000c(r2)
0x000cf504 j 0x000cf53c
0x000cf508 sll r3,r3,0x01
0x000cf50c sra r2,r2,0x10
0x000cf510 addiu r2,r2,0xffff
0x000cf514 srl r3,r2,0x1f
0x000cf518 addu r2,r2,r3
0x000cf51c sra r2,r2,0x01
0x000cf520 lui r3,0x8015
0x000cf524 lw r3,-0x10b8(r3)
0x000cf528 sll r2,r2,0x04
0x000cf52c addu r2,r2,r3
0x000cf530 lh r3,0x0004(r4)
0x000cf534 lhu r2,0x000e(r2)
0x000cf538 sll r3,r3,0x01
0x000cf53c lui r1,0x8015
0x000cf540 addu r1,r1,r3
0x000cf544 sh r2,-0x13ca(r1)
0x000cf548 lh r3,0x0002(r4)
0x000cf54c lui r2,0x8015
0x000cf550 addu r2,r2,r3
0x000cf554 lbu r2,-0x13e8(r2)
0x000cf558 nop
0x000cf55c ori r2,r2,0x0008
0x000cf560 lui r1,0x8015
0x000cf564 addu r1,r1,r3
0x000cf568 sb r2,-0x13e8(r1)
0x000cf56c lui r4,0x8015
0x000cf570 addiu r4,r4,0xedfc
0x000cf574 lb r2,-0x0015(r4)
0x000cf578 lb r3,-0x0010(r4)
0x000cf57c lui r5,0x8015
0x000cf580 lw r5,-0x10b4(r5)
0x000cf584 sll r2,r2,0x04
0x000cf588 addu r2,r2,r3
0x000cf58c sll r2,r2,0x05
0x000cf590 addu r2,r2,r5
0x000cf594 lh r3,0x0000(r4)
0x000cf598 lhu r2,0x0010(r2)
0x000cf59c sll r3,r3,0x01
0x000cf5a0 lui r1,0x8015
0x000cf5a4 addu r1,r1,r3
0x000cf5a8 sh r2,-0x13c8(r1)
0x000cf5ac lb r2,-0x0015(r4)
0x000cf5b0 lb r3,-0x0010(r4)
0x000cf5b4 sll r2,r2,0x04
0x000cf5b8 addu r2,r2,r3
0x000cf5bc sll r2,r2,0x05
0x000cf5c0 addu r2,r2,r5
0x000cf5c4 lh r3,0x0000(r4)
0x000cf5c8 lhu r2,0x0012(r2)
0x000cf5cc lui r5,0x8015
0x000cf5d0 lhu r5,-0x1200(r5)
0x000cf5d4 sll r3,r3,0x01
0x000cf5d8 addu r2,r2,r5
0x000cf5dc lui r1,0x8015
0x000cf5e0 addu r1,r1,r3
0x000cf5e4 sh r2,-0x13c6(r1)
0x000cf5e8 lh r3,-0x0002(r4)
0x000cf5ec lui r2,0x8015
0x000cf5f0 addu r2,r2,r3
0x000cf5f4 lbu r2,-0x13e8(r2)
0x000cf5f8 nop
0x000cf5fc ori r2,r2,0x0030
0x000cf600 lui r1,0x8015
0x000cf604 addu r1,r1,r3
0x000cf608 jr r31
0x000cf60c sb r2,-0x13e8(r1)