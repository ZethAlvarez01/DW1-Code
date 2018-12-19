/**
 * Gets MP cost of a move by a given Digimon and move slot.
 * When the move is not useable for various reasons it returns 0.
 */
int getMPCost(entityPtr, combatPtr, moveSlot) {
  moveId = load(entityPtr + 0x44 + moveSlot)
  
  if(moveId == -1) // no move set
    return 0
    
  techId = getTechFromMove(entityPtr, moveId)
  
  if(techId == 0x2D) // is counter
    return 0
    
  if(techId >= 0x3A && techId < 0x71) // is finisher
    return 0
  
  techOffset = techId * 0x10
  range = load(0x126244 + techOffset) // range
  
  if(range == 4 && load(combatPtr + 0x39) == 0) // check self-buff limit
    return 0
  
  if(load(combatPtr + 0x37) == -1 && load(0x126249 + techOffset) & 1 == 1) // not sure, check a move property? aoe?
    return 0
  
  mpCost = load(0x126242 + techOffset) * 3
  
  if(entityPtr == load(0x12F348)) { // is partner
    brains = load(0x1557E6) // brains
    
    if(brains == 999)
      mpCost = mpCost * 0.80
    else if(brains >= 900)
      mpCost = mpCost * 0.85
    else if(brains >= 800)
      mpCost = mpCost * 0.90
    else if(brains >= 700)
      mpCost = mpCost * 0.95
    
    isSickOrInjured = load(0x138460) & 0x0060
    
    if(isSickOrInjured != 0)
      mpCost = mpCost * 1.5
  }
  
  currentMP = load(entityPtr + 0x4E)
  
  return currentMP >= mpCost ? 1 : 0
}

0x0005d374 addiu r29,r29,0xffe0
0x0005d378 sw r31,0x0018(r29)
0x0005d37c sw r17,0x0014(r29)
0x0005d380 sw r16,0x0010(r29)
0x0005d384 addu r16,r4,r0
0x0005d388 addu r17,r5,r0
0x0005d38c addu r2,r6,r16
0x0005d390 lbu r5,0x0044(r2)
0x0005d394 addiu r1,r0,0x00ff
0x0005d398 bne r5,r1,0x0005d3a8
0x0005d39c nop
0x0005d3a0 beq r0,r0,0x0005d5f4
0x0005d3a4 addu r2,r0,r0
0x0005d3a8 jal 0x000e6000
0x0005d3ac nop
0x0005d3b0 sll r2,r2,0x10
0x0005d3b4 sra r2,r2,0x10
0x0005d3b8 addiu r1,r0,0x002d
0x0005d3bc bne r2,r1,0x0005d3cc
0x0005d3c0 nop
0x0005d3c4 beq r0,r0,0x0005d5f4
0x0005d3c8 addu r2,r0,r0
0x0005d3cc slti r1,r2,0x003a
0x0005d3d0 bne r1,r0,0x0005d3ec
0x0005d3d4 nop
0x0005d3d8 slti r1,r2,0x0071
0x0005d3dc beq r1,r0,0x0005d3ec
0x0005d3e0 nop
0x0005d3e4 beq r0,r0,0x0005d5f4
0x0005d3e8 addu r2,r0,r0
0x0005d3ec sll r3,r2,0x04
0x0005d3f0 lui r2,0x8012
0x0005d3f4 addiu r2,r2,0x6244
0x0005d3f8 addu r2,r2,r3
0x0005d3fc lbu r2,0x0000(r2)
0x0005d400 addiu r1,r0,0x0004
0x0005d404 bne r2,r1,0x0005d424
0x0005d408 addu r4,r3,r0
0x0005d40c lbu r2,0x0039(r17)
0x0005d410 nop
0x0005d414 bne r2,r0,0x0005d424
0x0005d418 nop
0x0005d41c beq r0,r0,0x0005d5f4
0x0005d420 addu r2,r0,r0
0x0005d424 lbu r2,0x0037(r17)
0x0005d428 addiu r1,r0,0x00ff
0x0005d42c bne r2,r1,0x0005d45c
0x0005d430 nop
0x0005d434 lui r2,0x8012
0x0005d438 addiu r2,r2,0x6249
0x0005d43c addu r2,r2,r4
0x0005d440 lbu r2,0x0000(r2)
0x0005d444 addiu r1,r0,0x0001
0x0005d448 andi r2,r2,0x0001
0x0005d44c bne r2,r1,0x0005d45c
0x0005d450 nop
0x0005d454 beq r0,r0,0x0005d5f4
0x0005d458 addu r2,r0,r0
0x0005d45c lui r2,0x8012
0x0005d460 addiu r2,r2,0x6242
0x0005d464 addu r2,r2,r4
0x0005d468 lbu r3,0x0000(r2)
0x0005d46c lui r1,0x8013
0x0005d470 sll r2,r3,0x01
0x0005d474 add r2,r2,r3
0x0005d478 sll r2,r2,0x10
0x0005d47c lw r3,-0x0cb8(r1)
0x0005d480 nop
0x0005d484 bne r16,r3,0x0005d5d8
0x0005d488 sra r2,r2,0x10
0x0005d48c lui r1,0x8015
0x0005d490 lh r3,0x57e6(r1)
0x0005d494 nop
0x0005d498 slti r1,r3,0x02bc
0x0005d49c bne r1,r0,0x0005d59c
0x0005d4a0 addu r4,r3,r0
0x0005d4a4 addiu r1,r0,0x03e7
0x0005d4a8 bne r4,r1,0x0005d4e4
0x0005d4ac nop
0x0005d4b0 lui r3,0x6666
0x0005d4b4 ori r3,r3,0x6667
0x0005d4b8 mult r3,r2
0x0005d4bc srl r4,r2,0x1f
0x0005d4c0 mfhi r3
0x0005d4c4 sra r3,r3,0x01
0x0005d4c8 addu r3,r3,r4
0x0005d4cc sll r3,r3,0x10
0x0005d4d0 sra r3,r3,0x10
0x0005d4d4 sub r2,r2,r3
0x0005d4d8 sll r2,r2,0x10
0x0005d4dc beq r0,r0,0x0005d59c
0x0005d4e0 sra r2,r2,0x10
0x0005d4e4 slti r1,r4,0x0384
0x0005d4e8 bne r1,r0,0x0005d52c
0x0005d4ec nop
0x0005d4f0 sll r3,r2,0x04
0x0005d4f4 sub r4,r3,r2
0x0005d4f8 lui r3,0x51eb
0x0005d4fc ori r3,r3,0x851f
0x0005d500 mult r3,r4
0x0005d504 mfhi r3
0x0005d508 srl r4,r4,0x1f
0x0005d50c sra r3,r3,0x05
0x0005d510 addu r3,r3,r4
0x0005d514 sll r3,r3,0x10
0x0005d518 sra r3,r3,0x10
0x0005d51c sub r2,r2,r3
0x0005d520 sll r2,r2,0x10
0x0005d524 beq r0,r0,0x0005d59c
0x0005d528 sra r2,r2,0x10
0x0005d52c slti r1,r4,0x0320
0x0005d530 bne r1,r0,0x0005d56c
0x0005d534 nop
0x0005d538 lui r3,0x6666
0x0005d53c ori r3,r3,0x6667
0x0005d540 mult r3,r2
0x0005d544 srl r4,r2,0x1f
0x0005d548 mfhi r3
0x0005d54c sra r3,r3,0x02
0x0005d550 addu r3,r3,r4
0x0005d554 sll r3,r3,0x10
0x0005d558 sra r3,r3,0x10
0x0005d55c sub r2,r2,r3
0x0005d560 sll r2,r2,0x10
0x0005d564 beq r0,r0,0x0005d59c
0x0005d568 sra r2,r2,0x10
0x0005d56c lui r3,0x6666
0x0005d570 ori r3,r3,0x6667
0x0005d574 mult r3,r2
0x0005d578 srl r4,r2,0x1f
0x0005d57c mfhi r3
0x0005d580 sra r3,r3,0x03
0x0005d584 addu r3,r3,r4
0x0005d588 sll r3,r3,0x10
0x0005d58c sra r3,r3,0x10
0x0005d590 sub r2,r2,r3
0x0005d594 sll r2,r2,0x10
0x0005d598 sra r2,r2,0x10
0x0005d59c lui r1,0x8014
0x0005d5a0 lw r3,-0x7ba0(r1)
0x0005d5a4 nop
0x0005d5a8 andi r3,r3,0x0060
0x0005d5ac beq r3,r0,0x0005d5d8
0x0005d5b0 nop
0x0005d5b4 bgez r2,0x0005d5c4
0x0005d5b8 sra r25,r2,0x01
0x0005d5bc addiu r3,r2,0x0001
0x0005d5c0 sra r25,r3,0x01
0x0005d5c4 sll r3,r25,0x10
0x0005d5c8 sra r3,r3,0x10
0x0005d5cc add r2,r2,r3
0x0005d5d0 sll r2,r2,0x10
0x0005d5d4 sra r2,r2,0x10
0x0005d5d8 lh r3,0x004e(r16)
0x0005d5dc nop
0x0005d5e0 slt r1,r3,r2
0x0005d5e4 bne r1,r0,0x0005d5f4
0x0005d5e8 addu r2,r0,r0
0x0005d5ec beq r0,r0,0x0005d5f4
0x0005d5f0 addiu r2,r0,0x0001
0x0005d5f4 lw r31,0x0018(r29)
0x0005d5f8 lw r17,0x0014(r29)
0x0005d5fc lw r16,0x0010(r29)
0x0005d600 jr r31
0x0005d604 addiu r29,r29,0x0020