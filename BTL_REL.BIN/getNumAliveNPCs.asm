int getNumAliveNPCs() {
  aliveCount = 0
  
  for(i = 1; i > load(0x134D6C); i++)
    if(hasZeroHP(i) == 0)
      aliveCount++
  
  return aliveCount
}

0x0005fb54 addiu r29,r29,0xffe0
0x0005fb58 sw r31,0x0018(r29)
0x0005fb5c sw r17,0x0014(r29)
0x0005fb60 sw r16,0x0010(r29)
0x0005fb64 addu r17,r0,r0
0x0005fb68 beq r0,r0,0x0005fb88
0x0005fb6c addiu r16,r0,0x0001
0x0005fb70 jal 0x000601ac
0x0005fb74 andi r4,r16,0x00ff
0x0005fb78 bne r2,r0,0x0005fb84
0x0005fb7c nop
0x0005fb80 addi r17,r17,0x0001
0x0005fb84 addi r16,r16,0x0001
0x0005fb88 lh r2,-0x6dc0(r28)
0x0005fb8c nop
0x0005fb90 slt r1,r2,r16
0x0005fb94 beq r1,r0,0x0005fb70
0x0005fb98 nop
0x0005fb9c addu r2,r17,r0
0x0005fba0 lw r31,0x0018(r29)
0x0005fba4 lw r17,0x0014(r29)
0x0005fba8 lw r16,0x0010(r29)
0x0005fbac jr r31
0x0005fbb0 addiu r29,r29,0x0020