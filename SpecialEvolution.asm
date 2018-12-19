// (hopefully) equivalent pseudocode
// returns the Digimon to evolve into or -1
int calculateSpecialEvolution(int input) {
  state = loadState()

  if(state != 0)
    return -1

  rolled = random(100)
  result = -1

  if(input == 2) {
    if(rolled < 30) {
      if(digimonType == 10 || digimonType == 21)
      if(Happiness == 100 && Discipline == 100)
      if(Tiredness == 0)
        result = 7 // Airdramon
        
      if(digimonType == 25)
      if(Battles > 50)
      if(Discipline == 100)
        result = 58 // Ninjamon

      if(digimonType == 38)
      if(Defense >= 500)
      if(Discipline == 100)
        result = 47 // Monochromon
    }
        
    if(rolled < 50) {
      if(digimonType == 2 || digimonType == 30 || digimonType == 16 || digimonType == 44)
      if(currentMap == 1)
        result = 32
    }
  }
  else if(input == 3) {
    if(digimonType == 24 || digimonType == 35)
    if(digimonLevel == 4)
    if(EvolveTimer == 200)
    if(rolled < 30)
      result = 49 // Coelamon
      
    nanimonTrigger = load(0x134C64)
    if(nanimonTrigger != 0) {
      result = 53 // Nanimon
      store(0, 0x134C64) // reset nanimon trigger
    }
      
    if(digimonLevel == 4)
    if(EvolveTimer > 240)
    if(rolled < 50)
      result = 28 // Vademon
  }

  if(result != -1) {
    store(result, 0x134E50)
    setMenuState(6)
    setDigimonState(13) // triggers evolution
  }

  return result
}

// original ASM Code
0x000e3234 addiu r29,r29,0xffc0
0x000e3238 sw r31,0x0034(r29)
0x000e323c sw r30,0x0030(r29)
0x000e3240 sw r23,0x002c(r29)
0x000e3244 sw r22,0x0028(r29)
0x000e3248 sw r21,0x0024(r29)
0x000e324c sw r20,0x0020(r29)
0x000e3250 sw r19,0x001c(r29)
0x000e3254 sw r18,0x0018(r29)
0x000e3258 sw r17,0x0014(r29)
0x000e325c sw r16,0x0010(r29)
0x000e3260 addu r20,r4,r0
0x000e3264 jal 0x000ac050
0x000e3268 addu r16,r5,r0
0x000e326c beq r2,r0,0x000e327c
0x000e3270 nop
0x000e3274 beq r0,r0,0x000e34e0
0x000e3278 addiu r2,r0,0xffff
0x000e327c lw r16,0x0000(r16)
0x000e3280 lui r1,0x8015
0x000e3284 sll r2,r16,0x01
0x000e3288 add r2,r2,r16
0x000e328c sll r2,r2,0x02
0x000e3290 add r2,r2,r16
0x000e3294 sll r3,r2,0x02
0x000e3298 lui r2,0x8013
0x000e329c addiu r2,r2,0xced1
0x000e32a0 addu r2,r2,r3
0x000e32a4 lbu r2,0x0000(r2)
0x000e32a8 addiu r4,r0,0x0064
0x000e32ac sll r18,r2,0x10
0x000e32b0 lh r2,0x57e2(r1)
0x000e32b4 lui r1,0x8014
0x000e32b8 lh r19,-0x7b78(r1)
0x000e32bc sw r2,0x003c(r29)
0x000e32c0 lui r1,0x8014
0x000e32c4 lh r30,-0x7b76(r1)
0x000e32c8 lui r1,0x8014
0x000e32cc lh r21,-0x7b4a(r1)
0x000e32d0 lui r1,0x8014
0x000e32d4 lh r23,-0x7b4c(r1)
0x000e32d8 lui r1,0x8014
0x000e32dc lh r22,-0x7b7e(r1)
0x000e32e0 jal 0x000a36d4
0x000e32e4 sra r18,r18,0x10
0x000e32e8 sll r3,r2,0x10
0x000e32ec addiu r2,r0,0xffff
0x000e32f0 sll r17,r2,0x10
0x000e32f4 sra r3,r3,0x10
0x000e32f8 addiu r1,r0,0x0003
0x000e32fc beq r20,r1,0x000e3424
0x000e3300 sra r17,r17,0x10
0x000e3304 addiu r1,r0,0x0002
0x000e3308 bne r20,r1,0x000e34bc
0x000e330c nop
0x000e3310 slti r1,r3,0x001e
0x000e3314 beq r1,r0,0x000e33c8
0x000e3318 nop
0x000e331c addiu r1,r0,0x0015
0x000e3320 beq r16,r1,0x000e3334
0x000e3324 nop
0x000e3328 addiu r1,r0,0x000a
0x000e332c bne r16,r1,0x000e3360
0x000e3330 nop
0x000e3334 addiu r1,r0,0x0064
0x000e3338 bne r19,r1,0x000e3360
0x000e333c nop
0x000e3340 addiu r1,r0,0x0064
0x000e3344 bne r30,r1,0x000e3360
0x000e3348 nop
0x000e334c bne r22,r0,0x000e3360
0x000e3350 nop
0x000e3354 addiu r2,r0,0x0007
0x000e3358 sll r17,r2,0x10
0x000e335c sra r17,r17,0x10
0x000e3360 addiu r1,r0,0x0019
0x000e3364 bne r16,r1,0x000e3390
0x000e3368 nop
0x000e336c slti r1,r23,0x0032
0x000e3370 bne r1,r0,0x000e3390
0x000e3374 nop
0x000e3378 addiu r1,r0,0x0064
0x000e337c bne r19,r1,0x000e3390
0x000e3380 nop
0x000e3384 addiu r2,r0,0x003a
0x000e3388 sll r17,r2,0x10
0x000e338c sra r17,r17,0x10
0x000e3390 addiu r1,r0,0x0026
0x000e3394 bne r16,r1,0x000e33c8
0x000e3398 nop
0x000e339c lw r2,0x003c(r29)
0x000e33a0 nop
0x000e33a4 slti r1,r2,0x01f4
0x000e33a8 bne r1,r0,0x000e33c8
0x000e33ac nop
0x000e33b0 addiu r1,r0,0x0064
0x000e33b4 bne r19,r1,0x000e33c8
0x000e33b8 nop
0x000e33bc addiu r2,r0,0x002f
0x000e33c0 sll r17,r2,0x10
0x000e33c4 sra r17,r17,0x10
0x000e33c8 slti r1,r3,0x0032
0x000e33cc beq r1,r0,0x000e34bc
0x000e33d0 nop
0x000e33d4 addiu r1,r0,0x0002
0x000e33d8 beq r16,r1,0x000e3404
0x000e33dc nop
0x000e33e0 addiu r1,r0,0x001e
0x000e33e4 beq r16,r1,0x000e3404
0x000e33e8 nop
0x000e33ec addiu r1,r0,0x0010
0x000e33f0 beq r16,r1,0x000e3404
0x000e33f4 nop
0x000e33f8 addiu r1,r0,0x002c
0x000e33fc bne r16,r1,0x000e34bc
0x000e3400 nop
0x000e3404 lbu r2,-0x6d84(r28)
0x000e3408 addiu r1,r0,0x0001
0x000e340c bne r2,r1,0x000e34bc
0x000e3410 nop
0x000e3414 addiu r2,r0,0x0020
0x000e3418 sll r17,r2,0x10
0x000e341c beq r0,r0,0x000e34bc
0x000e3420 sra r17,r17,0x10
0x000e3424 addiu r1,r0,0x0018
0x000e3428 beq r16,r1,0x000e343c
0x000e342c nop
0x000e3430 addiu r1,r0,0x0023
0x000e3434 bne r16,r1,0x000e346c
0x000e3438 nop
0x000e343c addiu r1,r0,0x0004
0x000e3440 bne r18,r1,0x000e346c
0x000e3444 nop
0x000e3448 addiu r1,r0,0x00c8
0x000e344c bne r21,r1,0x000e346c
0x000e3450 nop
0x000e3454 slti r1,r3,0x001e
0x000e3458 beq r1,r0,0x000e346c
0x000e345c nop
0x000e3460 addiu r2,r0,0x0031
0x000e3464 sll r17,r2,0x10
0x000e3468 sra r17,r17,0x10
0x000e346c lw r2,-0x6ec8(r28)
0x000e3470 addiu r1,r0,0x0001
0x000e3474 bne r2,r1,0x000e348c
0x000e3478 nop
0x000e347c addiu r2,r0,0x0035
0x000e3480 sll r17,r2,0x10
0x000e3484 sra r17,r17,0x10
0x000e3488 sw r0,-0x6ec8(r28)
0x000e348c addiu r1,r0,0x0004
0x000e3490 bne r18,r1,0x000e34bc
0x000e3494 nop
0x000e3498 slti r1,r21,0x00f0
0x000e349c bne r1,r0,0x000e34bc
0x000e34a0 nop
0x000e34a4 slti r1,r3,0x0032
0x000e34a8 beq r1,r0,0x000e34bc
0x000e34ac nop
0x000e34b0 addiu r2,r0,0x001c
0x000e34b4 sll r17,r2,0x10
0x000e34b8 sra r17,r17,0x10
0x000e34bc addiu r1,r0,0xffff
0x000e34c0 beq r17,r1,0x000e34dc
0x000e34c4 nop
0x000e34c8 sh r17,-0x6cdc(r28)
0x000e34cc jal 0x000aa188
0x000e34d0 addiu r4,r0,0x0006
0x000e34d4 jal 0x000df4d0
0x000e34d8 addiu r4,r0,0x000d
0x000e34dc addu r2,r17,r0
0x000e34e0 lw r31,0x0034(r29)
0x000e34e4 lw r30,0x0030(r29)
0x000e34e8 lw r23,0x002c(r29)
0x000e34ec lw r22,0x0028(r29)
0x000e34f0 lw r21,0x0024(r29)
0x000e34f4 lw r20,0x0020(r29)
0x000e34f8 lw r19,0x001c(r29)
0x000e34fc lw r18,0x0018(r29)
0x000e3500 lw r17,0x0014(r29)
0x000e3504 lw r16,0x0010(r29)
0x000e3508 jr r31
