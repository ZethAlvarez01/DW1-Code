struct {
  int unk1            +0x0
  int unk2            +0x4
  short posX          +0x8
  short posY          +0xA
  short fadeoutSpdX   +0xC
  short fadeoutSpdY   +0xE
  byte speedX         +0x10
  byte someId         +0x11
  byte someCtr        +0x12
  byte pixType        +0x13
}
// 1240 RNG calls?
void initializeBattleText() {
  store(0x1350BC, 0)
  store(0x1350C0, 0)
  
  for(i = 0; i < 155; i++) {
    store(0x742A0 + i * 0x14 + 0x11, i)
    store(0x742A0 + i * 0x14 + 0x12, 24) // distortion counter?
    store(0x742A0 + i * 0x14 + 0x13, random(3)) // pixelType
  }
  
  0x000630F8() // done, name missing, scrambles (+0x11) randomly
  
  for(i = 0; i < 155; i++) {
    entranceDirection = random(2) == 1 ? 1 : -1
    
    posY = load(0x73016 + i * 4)
    store(0x742A0 + i * 0x14 + 0x0A, posY)
    entranceSpeed = -entranceDirection * (random(3) + 1) * 32
    store(0x742A0 + i * 0x14 + 0x10, entranceSpeed)
    
    if(i >= 0 && i < 0x33)
      posX = entranceDirection * 500 + random(100) - 50
    else if(i >= 0x33 && i < 101)
      posX = entranceDirection * 600 + random(100) - 50
    else
      posX = entranceDirection * 700 + random(100) - 50
    
    store(0x742A0 + i * 0x14 + 0x08, posX)
    
    fadeoutSpeed = random(5) + 8
    fadeoutDirX = load(0x73014 + i * 4)
    fadeoutDirY = load(0x73016 + i * 4)
    
    store(0x742A0 + i * 0x14 + 0x0C, fadeoutSpeed * fadeoutDirX / 8)
    store(0x742A0 + i * 0x14 + 0x0E, fadeoutSpeed * fadeoutDirY / 8)
    
    store(0x742A0 + i * 0x14, 0)
    store(0x742A0 + i * 0x14 + 0x02, 0)
    store(0x742A0 + i * 0x14 + 0x04, 0)
  }
  
  setObject(0x1A6, 0, 0, 0x633A4)
}

0x00063170 addiu r29,r29,0xffd8
0x00063174 sw r31,0x0020(r29)
0x00063178 sw r19,0x001c(r29)
0x0006317c sw r18,0x0018(r29)
0x00063180 sw r17,0x0014(r29)
0x00063184 sw r16,0x0010(r29)
0x00063188 lui r16,0x8007
0x0006318c sb r0,-0x6a70(r28)
0x00063190 sw r0,-0x6a6c(r28)
0x00063194 addiu r16,r16,0x42a0
0x00063198 beq r0,r0,0x000631c0
0x0006319c addu r18,r0,r0
0x000631a0 sb r18,0x0011(r16)
0x000631a4 addiu r2,r0,0x0018
0x000631a8 sb r2,0x0012(r16)
0x000631ac jal 0x000a36d4
0x000631b0 addiu r4,r0,0x0003
0x000631b4 sb r2,0x0013(r16)
0x000631b8 addi r18,r18,0x0001
0x000631bc addiu r16,r16,0x0014
0x000631c0 slti r1,r18,0x009b
0x000631c4 bne r1,r0,0x000631a0
0x000631c8 nop
0x000631cc jal 0x000630f8
0x000631d0 nop
0x000631d4 lui r16,0x8007
0x000631d8 addiu r16,r16,0x42a0
0x000631dc addu r18,r0,r0
0x000631e0 beq r0,r0,0x00063364
0x000631e4 addu r19,r0,r0
0x000631e8 jal 0x000a36d4
0x000631ec addiu r4,r0,0x0002
0x000631f0 addiu r1,r0,0x0001
0x000631f4 bne r2,r1,0x00063204
0x000631f8 addiu r17,r0,0xffff
0x000631fc beq r0,r0,0x00063204
0x00063200 addiu r17,r0,0x0001
0x00063204 lui r2,0x8007
0x00063208 addiu r2,r2,0x3016
0x0006320c addu r2,r2,r19
0x00063210 lh r2,0x0000(r2)
0x00063214 nop
0x00063218 sh r2,0x000a(r16)
0x0006321c jal 0x000a36d4
0x00063220 addiu r4,r0,0x0003
0x00063224 addi r2,r2,0x0001
0x00063228 sll r3,r2,0x05
0x0006322c sub r2,r0,r17
0x00063230 mult r2,r3
0x00063234 slt r1,r18,r0
0x00063238 mflo r2
0x0006323c bne r1,r0,0x0006327c
0x00063240 sb r2,0x0010(r16)
0x00063244 slti r1,r18,0x0033
0x00063248 beq r1,r0,0x0006327c
0x0006324c nop
0x00063250 jal 0x000a36d4
0x00063254 addiu r4,r0,0x0064
0x00063258 sll r3,r17,0x05
0x0006325c sub r3,r3,r17
0x00063260 sll r3,r3,0x02
0x00063264 add r3,r3,r17
0x00063268 sll r3,r3,0x02
0x0006326c add r2,r3,r2
0x00063270 addi r2,r2,-0x0032
0x00063274 beq r0,r0,0x000632e0
0x00063278 sh r2,0x0008(r16)
0x0006327c slti r1,r18,0x0033
0x00063280 bne r1,r0,0x000632c0
0x00063284 nop
0x00063288 slti r1,r18,0x0065
0x0006328c beq r1,r0,0x000632c0
0x00063290 nop
0x00063294 jal 0x000a36d4
0x00063298 addiu r4,r0,0x0064
0x0006329c sll r3,r17,0x04
0x000632a0 sub r4,r3,r17
0x000632a4 sll r3,r4,0x02
0x000632a8 add r3,r4,r3
0x000632ac sll r3,r3,0x03
0x000632b0 add r2,r3,r2
0x000632b4 addi r2,r2,-0x0032
0x000632b8 beq r0,r0,0x000632e0
0x000632bc sh r2,0x0008(r16)
0x000632c0 jal 0x000a36d4
0x000632c4 addiu r4,r0,0x0064
0x000632c8 addiu r3,r0,0x02bc
0x000632cc mult r17,r3
0x000632d0 mflo r3
0x000632d4 add r2,r3,r2
0x000632d8 addi r2,r2,-0x0032
0x000632dc sh r2,0x0008(r16)
0x000632e0 jal 0x000a36d4
0x000632e4 addiu r4,r0,0x0005
0x000632e8 lui r3,0x8007
0x000632ec addiu r3,r3,0x3014
0x000632f0 addu r3,r3,r19
0x000632f4 addi r2,r2,0x0008
0x000632f8 lh r3,0x0000(r3)
0x000632fc addu r4,r2,r0
0x00063300 mult r2,r3
0x00063304 mflo r2
0x00063308 bgez r2,0x00063318
0x0006330c sra r25,r2,0x03
0x00063310 addiu r2,r2,0x0007
0x00063314 sra r25,r2,0x03
0x00063318 lui r2,0x8007
0x0006331c addiu r2,r2,0x3016
0x00063320 sh r25,0x000c(r16)
0x00063324 addu r2,r2,r19
0x00063328 lh r2,0x0000(r2)
0x0006332c nop
0x00063330 mult r4,r2
0x00063334 mflo r2
0x00063338 bgez r2,0x00063348
0x0006333c sra r25,r2,0x03
0x00063340 addiu r2,r2,0x0007
0x00063344 sra r25,r2,0x03
0x00063348 sh r25,0x000e(r16)
0x0006334c sh r0,0x0000(r16)
0x00063350 sh r0,0x0002(r16)
0x00063354 sh r0,0x0004(r16)
0x00063358 addi r18,r18,0x0001
0x0006335c addi r19,r19,0x0004
0x00063360 addiu r16,r16,0x0014
0x00063364 slti r1,r18,0x009b
0x00063368 bne r1,r0,0x000631e8
0x0006336c nop
0x00063370 lui r7,0x8006
0x00063374 addiu r4,r0,0x01a6
0x00063378 addu r5,r0,r0
0x0006337c addu r6,r0,r0
0x00063380 jal 0x000a2f64
0x00063384 addiu r7,r7,0x33a4
0x00063388 lw r31,0x0020(r29)
0x0006338c lw r19,0x001c(r29)
0x00063390 lw r18,0x0018(r29)
0x00063394 lw r17,0x0014(r29)
0x00063398 lw r16,0x0010(r29)
0x0006339c jr r31
0x000633a0 addiu r29,r29,0x0028