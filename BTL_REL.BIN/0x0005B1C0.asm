0x0005B1C0() {
  combatHead = load(0x134D4C)
  for(r5 = 0; r5 < 4; r5++) {
    store(combatHead + 0x05A0 + r5 * 0x28, 0)
    store(combatHead + 0x05A8 + r5 * 0x28, 50)
    store(combatHead + 0x05AA + r5 * 0x28, 3)
    store(combatHead + 0x05AC + r5 * 0x28, 31)
    store(combatHead + 0x05AE + r5 * 0x28, 88)
    store(combatHead + 0x05AF + r5 * 0x28, 236)
    store(combatHead + 0x05B0 + r5 * 0x28, 272)
    store(combatHead + 0x05B2 + r5 * 0x28, 499)
    store(combatHead + 0x05B4 + r5 * 0x28, 128)
    store(combatHead + 0x05B5 + r5 * 0x28, -1)
    store(combatHead + 0x05B6 + r5 * 0x28, 128)
  }
}

0x0005b1c0 lw r2,-0x6de0(r28)
0x0005b1c4 addu r5,r0,r0
0x0005b1c8 beq r0,r0,0x0005b228
0x0005b1cc addiu r4,r2,0x05a0
0x0005b1d0 sw r0,0x0000(r4)
0x0005b1d4 addiu r2,r0,0x0032
0x0005b1d8 sh r2,0x0008(r4)
0x0005b1dc addiu r2,r0,0x0003
0x0005b1e0 sh r2,0x000a(r4)
0x0005b1e4 addiu r2,r0,0x0058
0x0005b1e8 sb r2,0x000e(r4)
0x0005b1ec addiu r2,r0,0x00ec
0x0005b1f0 sb r2,0x000f(r4)
0x0005b1f4 addiu r2,r0,0x0110
0x0005b1f8 sh r2,0x0010(r4)
0x0005b1fc addiu r2,r0,0x01f3
0x0005b200 sh r2,0x0012(r4)
0x0005b204 addiu r2,r0,0x001f
0x0005b208 sh r2,0x000c(r4)
0x0005b20c addiu r3,r0,0x0080
0x0005b210 sb r3,0x0014(r4)
0x0005b214 addiu r2,r0,0x00ff
0x0005b218 sb r2,0x0015(r4)
0x0005b21c sb r3,0x0016(r4)
0x0005b220 addiu r4,r4,0x0028
0x0005b224 addi r5,r5,0x0001
0x0005b228 slti r1,r5,0x0004
0x0005b22c bne r1,r0,0x0005b1d0
0x0005b230 nop
0x0005b234 jr r31
0x0005b238 nop