int getNextSPUVoice(unused) {
  for(i = 0; i < 14; i++) {
    voiceId = 10 + ((load(0x134D90) + i) % 14)
    voiceState = getSPUVoiceState(1 << voiceId)
    
    if(voiceState != 1)
      break
  }
  
  if(i == 14)
    voiceId = load(0x134D90) + 10
  
  store(0x134D90, (voiceId - 9) % 14)
  
  return voiceId
}

0x000c6134 addiu r29,r29,0xffe0
0x000c6138 sw r31,0x0018(r29)
0x000c613c sw r17,0x0014(r29)
0x000c6140 sw r16,0x0010(r29)
0x000c6144 beq r0,r0,0x000c6184
0x000c6148 addu r16,r0,r0
0x000c614c lw r2,-0x6d9c(r28)
0x000c6150 nop
0x000c6154 add r3,r16,r2
0x000c6158 addiu r2,r0,0x000e
0x000c615c div r3,r2
0x000c6160 mfhi r2
0x000c6164 addi r17,r2,0x000a
0x000c6168 addiu r2,r0,0x0001
0x000c616c jal 0x000c8da8
0x000c6170 sllv r4,r2,r17
0x000c6174 addiu r1,r0,0x0001
0x000c6178 bne r2,r1,0x000c6190
0x000c617c nop
0x000c6180 addi r16,r16,0x0001
0x000c6184 slti r1,r16,0x000e
0x000c6188 bne r1,r0,0x000c614c
0x000c618c nop
0x000c6190 addiu r1,r0,0x000e
0x000c6194 bne r16,r1,0x000c61a8
0x000c6198 nop
0x000c619c lw r2,-0x6d9c(r28)
0x000c61a0 nop
0x000c61a4 addi r17,r2,0x000a
0x000c61a8 addi r3,r17,-0x0009
0x000c61ac addiu r2,r0,0x000e
0x000c61b0 div r3,r2
0x000c61b4 mfhi r2
0x000c61b8 sw r2,-0x6d9c(r28)
0x000c61bc addu r2,r17,r0
0x000c61c0 lw r31,0x0018(r29)
0x000c61c4 lw r17,0x0014(r29)
0x000c61c8 lw r16,0x0010(r29)
0x000c61cc jr r31
0x000c61d0 addiu r29,r29,0x0020