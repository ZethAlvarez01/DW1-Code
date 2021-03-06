void loadFileSection(filePath, target, start, size) {
  if(load(0x134FA8) == 0) {
    store(sp + 0x3C, 0x5C) // '\'
    strcpy(sp + 0x3D, filePath)
    strcat(sp + 0x3C, 0x1325F0) // empty string??
    // -> "\" + filePath + "" (0x1325F0)
    
    if(CdSearchFile(sp + 0x24, sp + 0x3C) == 0)
      return
    
    while(CdControl(14, { 0x80 }, 0) == 0); // CdlSetmode, double speed mode
    
    store(0x134FA8, CdPosToInt(sp + 0x24))
  }
  else
    while(CdControl(14, { 0x80 }, 0) == 0); // CdlSetmode, double speed mode
  
  cdPos = CdIntToPos(load(0x134FA8) + start / 2048, sp + 0x24)
  
  store(sp + 0x24, load(posPtr + 0x00))
  store(sp + 0x25, load(posPtr + 0x01))
  store(sp + 0x26, load(posPtr + 0x02))
  store(sp + 0x27, load(posPtr + 0x03))
  
  while(CdControl(2, sp + 0x24, 0) == 0); // CdlSetLoc
  while(CdRead(size / 2048, target, load(sp + 0x7F)) == 0);
  while(CdReadSync(0, 0) > 0);
}

0x001026e8 addiu r29,r29,0xff80
0x001026ec sw r31,0x001c(r29)
0x001026f0 sw r18,0x0018(r29)
0x001026f4 sw r17,0x0014(r29)
0x001026f8 addiu r2,r0,0x0080
0x001026fc sb r2,0x007f(r29)
0x00102700 sw r16,0x0010(r29)
0x00102704 lw r2,-0x6b84(r28)
0x00102708 addu r3,r4,r0
0x0010270c addu r18,r5,r0
0x00102710 addu r16,r6,r0
0x00102714 bne r2,r0,0x00102778
0x00102718 addu r17,r7,r0
0x0010271c addiu r2,r0,0x005c
0x00102720 sb r2,0x003c(r29)
0x00102724 addiu r4,r29,0x003d
0x00102728 jal 0x000911fc
0x0010272c addu r5,r3,r0
0x00102730 addiu r4,r29,0x003c
0x00102734 jal 0x000911cc
0x00102738 addiu r5,r28,0x8ac4
0x0010273c addiu r4,r29,0x0024
0x00102740 jal 0x000b23c0
0x00102744 addiu r5,r29,0x003c
0x00102748 beq r2,r0,0x0010280c
0x0010274c nop
0x00102750 addiu r4,r0,0x000e
0x00102754 addiu r5,r29,0x007f
0x00102758 jal 0x000b0010
0x0010275c addu r6,r0,r0
0x00102760 beq r2,r0,0x00102750
0x00102764 nop
0x00102768 jal 0x000b0554
0x0010276c addiu r4,r29,0x0024
0x00102770 beq r0,r0,0x00102790
0x00102774 sw r2,-0x6b84(r28)
0x00102778 addiu r4,r0,0x000e
0x0010277c addiu r5,r29,0x007f
0x00102780 jal 0x000b0010
0x00102784 addu r6,r0,r0
0x00102788 beq r2,r0,0x00102778
0x0010278c nop
0x00102790 lw r2,-0x6b84(r28)
0x00102794 srl r3,r16,0x0b
0x00102798 addu r4,r2,r3
0x0010279c jal 0x000b0450
0x001027a0 addiu r5,r29,0x0024
0x001027a4 lbu r5,0x0000(r2)
0x001027a8 lbu r4,0x0001(r2)
0x001027ac lbu r3,0x0002(r2)
0x001027b0 lbu r2,0x0003(r2)
0x001027b4 sb r5,0x0024(r29)
0x001027b8 sb r4,0x0025(r29)
0x001027bc sb r3,0x0026(r29)
0x001027c0 sb r2,0x0027(r29)
0x001027c4 addiu r4,r0,0x0002
0x001027c8 addiu r5,r29,0x0024
0x001027cc jal 0x000b0010
0x001027d0 addu r6,r0,r0
0x001027d4 beq r2,r0,0x001027c4
0x001027d8 nop
0x001027dc srl r16,r17,0x0b
0x001027e0 lbu r6,0x007f(r29)
0x001027e4 addu r4,r16,r0
0x001027e8 jal 0x000b2bb4
0x001027ec addu r5,r18,r0
0x001027f0 beq r2,r0,0x001027e0
0x001027f4 nop
0x001027f8 addu r4,r0,r0
0x001027fc jal 0x000b2cb4
0x00102800 addu r5,r0,r0
0x00102804 bgtz r2,0x001027f8
0x00102808 nop
0x0010280c lw r31,0x001c(r29)
0x00102810 lw r18,0x0018(r29)
0x00102814 lw r17,0x0014(r29)
0x00102818 lw r16,0x0010(r29)
0x0010281c jr r31
0x00102820 addiu r29,r29,0x0080