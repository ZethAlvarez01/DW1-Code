void renderString(stringPtr, xPos, yPos) {
  while(load(stringPtr) != 0) {
    if(isAsciiEncoded(stringPtr) != 0) {
      asciiChar = load(stringPtr++)
      
      if(asciiChar == 0x2E)
        charValue = 0x8142
      else if(asciiChar == 0x27)
        charValue = 0x8175
      else
        charValue = convertAsciiToGameChar(r4)
      
      charValue = swapBytes(charValue)
    }
    else {
      charValue = load(stringPtr++) << 8 | load(stringPtr++)
      charValue = swapBytes(charValue)
    }
    
    xPos += renderCharacter(charValue, xPos, yPos)
  }
}

0x0010cf24 addiu r29,r29,0xffe0
0x0010cf28 sw r31,0x001c(r29)
0x0010cf2c sw r18,0x0018(r29)
0x0010cf30 sw r17,0x0014(r29)
0x0010cf34 sw r16,0x0010(r29)
0x0010cf38 addu r16,r4,r0
0x0010cf3c addu r17,r5,r0
0x0010cf40 beq r0,r0,0x0010d00c
0x0010cf44 addu r18,r6,r0
0x0010cf48 jal 0x000f18a4
0x0010cf4c addu r4,r16,r0
0x0010cf50 beq r2,r0,0x0010cfac
0x0010cf54 nop
0x0010cf58 lb r2,0x0000(r16)
0x0010cf5c addiu r1,r0,0x002e
0x0010cf60 bne r2,r1,0x0010cf74
0x0010cf64 addu r4,r2,r0
0x0010cf68 ori r2,r0,0x8142
0x0010cf6c beq r0,r0,0x0010cf98
0x0010cf70 andi r4,r2,0xffff
0x0010cf74 addiu r1,r0,0x0027
0x0010cf78 bne r4,r1,0x0010cf8c
0x0010cf7c nop
0x0010cf80 ori r2,r0,0x8175
0x0010cf84 beq r0,r0,0x0010cf98
0x0010cf88 andi r4,r2,0xffff
0x0010cf8c jal 0x000f18c8
0x0010cf90 nop
0x0010cf94 andi r4,r2,0xffff
0x0010cf98 jal 0x000f1ab0
0x0010cf9c nop
0x0010cfa0 andi r4,r2,0xffff
0x0010cfa4 beq r0,r0,0x0010cff4
0x0010cfa8 addiu r16,r16,0x0001
0x0010cfac lb r2,0x0000(r16)
0x0010cfb0 nop
0x0010cfb4 andi r4,r2,0xffff
0x0010cfb8 addiu r16,r16,0x0001
0x0010cfbc lb r2,0x0000(r16)
0x0010cfc0 nop
0x0010cfc4 andi r3,r2,0xffff
0x0010cfc8 andi r2,r4,0x00ff
0x0010cfcc andi r4,r2,0xffff
0x0010cfd0 andi r2,r3,0x00ff
0x0010cfd4 andi r3,r2,0xffff
0x0010cfd8 sll r2,r4,0x08
0x0010cfdc andi r4,r2,0xffff
0x0010cfe0 or r2,r4,r3
0x0010cfe4 addiu r16,r16,0x0001
0x0010cfe8 jal 0x000f1ab0
0x0010cfec andi r4,r2,0xffff
0x0010cff0 andi r4,r2,0xffff
0x0010cff4 addu r5,r17,r0
0x0010cff8 jal 0x0010cc28
0x0010cffc addu r6,r18,r0
0x0010d000 andi r2,r2,0xffff
0x0010d004 addu r2,r17,r2
0x0010d008 andi r17,r2,0xffff
0x0010d00c lb r2,0x0000(r16)
0x0010d010 nop
0x0010d014 bne r2,r0,0x0010cf48
0x0010d018 nop
0x0010d01c lw r31,0x001c(r29)
0x0010d020 lw r18,0x0018(r29)
0x0010d024 lw r17,0x0014(r29)
0x0010d028 lw r16,0x0010(r29)
0x0010d02c jr r31
0x0010d030 addiu r29,r29,0x0020