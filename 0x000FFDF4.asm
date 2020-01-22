// some textbox logic
0x000FFDF4() {
  if(0x00100E40(0) != 0) // is textbox finished
    return 0
  
  if(load(0x134FE5) == 0)
    store(0x134F94, 1)
  
  if(isXPressedAfterDialogue() == 0)
    return 0
  
  switch(load(0x134FE5)) {
    case 0:
      if(isKeyDown(0x40) == 0) // is X key pressed
        return 0
      
      if(load(0x13D3A2) != 1) // dialogue state?
        return 0
      
      if(load(0x1BE827) == 1) {
        0x00100F20(0)
        playSound(0, 3)
      }
      else {
        playSound(0, 3)
        store(0x134FE8, 0)
      }
      
      return 1
    case 2:
      if(load(0x135010) != 0)
        return 0
    case 1:
      if(load(0x1BE827) == 1) {
        0x00100F20(0)
      }
      else {
        store(0x134FE8, 0)
      }
      return 1
    default:
      return 0
  }
}

0x000ffdf4 addiu r29,r29,0xffe8
0x000ffdf8 sw r31,0x0010(r29)
0x000ffdfc jal 0x00100e40
0x000ffe00 addu r4,r0,r0
0x000ffe04 beq r2,r0,0x000ffe14
0x000ffe08 nop
0x000ffe0c beq r0,r0,0x000fff14
0x000ffe10 addu r2,r0,r0
0x000ffe14 lbu r2,-0x6b47(r28)
0x000ffe18 nop
0x000ffe1c bne r2,r0,0x000ffe2c
0x000ffe20 nop
0x000ffe24 addiu r2,r0,0x0001
0x000ffe28 sw r2,-0x6b98(r28)
0x000ffe2c jal 0x000fc098
0x000ffe30 nop
0x000ffe34 bne r2,r0,0x000ffe44
0x000ffe38 nop
0x000ffe3c beq r0,r0,0x000fff14
0x000ffe40 addu r2,r0,r0
0x000ffe44 lbu r2,-0x6b47(r28)
0x000ffe48 addiu r1,r0,0x0001
0x000ffe4c beq r2,r1,0x000ffee0
0x000ffe50 nop
0x000ffe54 addiu r1,r0,0x0002
0x000ffe58 beq r2,r1,0x000ffed0
0x000ffe5c nop
0x000ffe60 bne r2,r0,0x000fff10
0x000ffe64 nop
0x000ffe68 jal 0x000fc054
0x000ffe6c addiu r4,r0,0x0040
0x000ffe70 beq r2,r0,0x000fff10
0x000ffe74 nop
0x000ffe78 lui r1,0x8014
0x000ffe7c lh r2,-0x2c5e(r1)
0x000ffe80 addiu r1,r0,0x0001
0x000ffe84 bne r2,r1,0x000fff10
0x000ffe88 nop
0x000ffe8c lui r1,0x801c
0x000ffe90 lbu r2,-0x17d9(r1)
0x000ffe94 addiu r1,r0,0x0001
0x000ffe98 bne r2,r1,0x000ffebc
0x000ffe9c addu r4,r0,r0
0x000ffea0 jal 0x00100f20
0x000ffea4 addu r4,r0,r0
0x000ffea8 addu r4,r0,r0
0x000ffeac jal 0x000c6374
0x000ffeb0 addiu r5,r0,0x0003
0x000ffeb4 beq r0,r0,0x000fff14
0x000ffeb8 addiu r2,r0,0x0001
0x000ffebc jal 0x000c6374
0x000ffec0 addiu r5,r0,0x0003
0x000ffec4 sb r0,-0x6b44(r28)
0x000ffec8 beq r0,r0,0x000fff14
0x000ffecc addiu r2,r0,0x0001
0x000ffed0 lbu r2,-0x6b1c(r28)
0x000ffed4 nop
0x000ffed8 bne r2,r0,0x000fff10
0x000ffedc nop
0x000ffee0 lui r1,0x801c
0x000ffee4 lbu r2,-0x17d9(r1)
0x000ffee8 addiu r1,r0,0x0001
0x000ffeec bne r2,r1,0x000fff04
0x000ffef0 nop
0x000ffef4 jal 0x00100f20
0x000ffef8 addu r4,r0,r0
0x000ffefc beq r0,r0,0x000fff14
0x000fff00 addiu r2,r0,0x0001
0x000fff04 sb r0,-0x6b44(r28)
0x000fff08 beq r0,r0,0x000fff14
0x000fff0c addiu r2,r0,0x0001
0x000fff10 addu r2,r0,r0
0x000fff14 lw r31,0x0010(r29)
0x000fff18 nop
0x000fff1c jr r31
0x000fff20 addiu r29,r29,0x0018