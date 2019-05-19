void tickSleepMechanics() {
  currentFrame = load(0x134F08)
  lastHandledFrame = load(0x134F06)
  currentHour = load(0x134EBC)
  isSleepy = load(0x138460) & 1 // is sleepy
  partnerType = load(0x1557A8)
  partnerLevel = load(0x12CED1 + partnerType * 52)
  
  // handle tiredness sleep timer
  if(currentFrame % 20 == 0 && currentFrame != lastHandledFrame) {
    tiredness = load(0x138482) // tiredness
    store(0x138476, load(0x138476) + (tiredness * 3) / 10) // tiredness sleep timer
  }
  
  // handle tiredness sleep time increase
  if(isSleepy == 0 && load(0x138476) >= 180 && currentFrame % 200 == 0 && currentFrame != lastHandledFrame) {
    store(0x138470, load(0x138470) - 1) // awake time this day
    store(0x138476, 0) // tiredness sleep timer
    
    standardAwakeTime = load(0x13846C) * 6 // standard awake time
    currentAwakeTime = load(0x138470) // awake time this day
    
    awakeDiff = standardAwakeTime - currentAwakeTime
    awakeDiffHours = awakeDiff / 6
    
    if(awakeDiff % 6 != 0)
      awakeDiffHours++
    
    newSleepyHour = load(0x138468) - load(0x13846E) // wakeup hour - standard sleep time
    newSleepyHour = newSleepyHour - awakeDiffHours
    newSleepyHour = newSleepyHour < 0 ? newSleepyHour - 24 : newSleepyHour
    
    store(0x138464, newSleepyHour) // sleepy hour
    store(0x138466, currentAwakeTime % 6 * 10) // sleepy minute
  }
  
  // handle negative effects of staying up too long
  if(isSleepy != 0 && currentFrame != lastHandledFrame) {
    if(partnerLevel == 1 && currentFrame % 200 == 0) {
      store(0x13848A, load(0x13848A) - 1) // happiness
      store(0x138488, load(0x138488) - 1) // discipline
    }
    else if(partnerLevel == 2 && currentFrame % 300 == 0)) {
      store(0x13848A, load(0x13848A) - 1) // happiness
      store(0x138488, load(0x138488) - 1) // discipline
    }
    else if(currentFrame % 1200 == 0) {
      store(0x13848A, load(0x13848A) - 2) // happiness
      store(0x138488, load(0x138488) - 4) // discipline
    }
    
    if(currentFrame % 1200 == 0 && currentHour != load(0x138464)) { // sleepy hour
      store(0x138472, load(0x138472) + 1) // sickness counter
      store(0x138474, load(0x138474) + 1) // missed sleep hours counter
    }
  }
  
  // handle staying awake a night, i.e. updating sleep times and adding a care mistake
  if(isSleepy != 0) {
    sleepyHour = load(0x138464)
    wakeupHour = load(0x138468)
    
    if((sleepyHour < wakeupHour && sleepyHour < currentHour && currentHour < wakeupHour)
    || (wakeupHour < sleepyHour && currentHour < sleepyHour && currentHour < wakeupHour)) {
      
      if(partnerLevel < 3) {
        newSleepyHour = load(0x13846C) + wakeupHour
        newSleepyHour = newSleepyHour >= 24 ? newSleepyHour - 24 : newSleepyHour
        
        store(0x138464, newSleepyHour)
        store(0x138466, 0) // sleepy Minute
        
        newWakeupHour = newSleepyHour + load(0x13846E) // standard sleep time
        newWakeupHour = newWakeupHour >= 24 ? newWakeupHour - 24 : newWakeupHour
        
        store(0x138468, newWakeupHour)
        store(0x13846A, 0)
      }
      else {
        sleepCycle = load(0x1225CE + partnerType * 28) // sleep cycle
        
        store(0x138464, load(0x122CF4 + sleepCycle * 6)) // sleepy hour 
        store(0x138466, load(0x122CF5 + sleepCycle * 6)) // sleepy minute
        store(0x138468, load(0x122CF6 + sleepCycle * 6)) // wakeup hour
        store(0x13846A, load(0x122CF7 + sleepCycle * 6)) // wakeup minute
      }
      
      store(0x138470, load(0x13846C) * 6) // awake time this day
      store(0x138476, 0) // tiredness sleep counter
      
      store(0x138460, load(0x138460) & 0xFFFE) // reset sleepy flag
      store(0x1384B2, load(0x1384B2) + 1) // add care mistake
      
      setConditionAnimation()
      addTamerLevel(1, -1) // 1% chance of losing a tamer level
    }
  }
  
  // set sleepy flag
  if(isSleepy == 0) {
    wakeupHour = load(0x138468)
    sleepyHour = load(0x138464)
    
    if(wakeupHour < sleepyHour) {
      if(currentHour >= sleepyHour || currentHour < wakeupHour)
        store(0x138460, load(0x138460) | 1)
    }
    else if(sleepyHour < wakeupHour) {
      if(currentHour >= sleepyHour && currentHour < wakeupHour)
        store(0x138460, load(0x138460) | 1)
    }
  }
  
  if(load(0x138460) & 1 != 0) // is still sleepy
    store(0x123ED6, 0) // deferred via 0x000BA40C(0)
  else
    store(0x123ED6, 1) // deferred via 0x000BA40C(1)
}

0x000a5804 lhu r3,-0x6c24(r28)
0x000a5808 addiu r29,r29,0xffe8
0x000a580c lui r1,0x8014
0x000a5810 sw r31,0x0014(r29)
0x000a5814 lw r2,-0x7ba0(r1)
0x000a5818 sw r16,0x0010(r29)
0x000a581c andi r16,r2,0x0001
0x000a5820 addiu r2,r0,0x0014
0x000a5824 div r3,r2
0x000a5828 addu r4,r3,r0
0x000a582c mfhi r2
0x000a5830 bne r2,r0,0x000a5894
0x000a5834 addu r5,r3,r0
0x000a5838 lhu r2,-0x6c26(r28)
0x000a583c nop
0x000a5840 beq r4,r2,0x000a5894
0x000a5844 nop
0x000a5848 lui r1,0x8014
0x000a584c lh r3,-0x7b7e(r1)
0x000a5850 nop
0x000a5854 sll r2,r3,0x01
0x000a5858 add r3,r2,r3
0x000a585c lui r2,0x6666
0x000a5860 ori r2,r2,0x6667
0x000a5864 mult r2,r3
0x000a5868 lui r1,0x8014
0x000a586c mfhi r2
0x000a5870 srl r3,r3,0x1f
0x000a5874 sra r2,r2,0x02
0x000a5878 addu r3,r2,r3
0x000a587c lh r2,-0x7b8a(r1)
0x000a5880 sll r3,r3,0x10
0x000a5884 sra r3,r3,0x10
0x000a5888 add r2,r2,r3
0x000a588c lui r1,0x8014
0x000a5890 sh r2,-0x7b8a(r1)
0x000a5894 bne r16,r0,0x000a59c8
0x000a5898 nop
0x000a589c lui r1,0x8014
0x000a58a0 lh r2,-0x7b8a(r1)
0x000a58a4 nop
0x000a58a8 slti r1,r2,0x00b4
0x000a58ac bne r1,r0,0x000a59c8
0x000a58b0 nop
0x000a58b4 addiu r2,r0,0x00c8
0x000a58b8 div r5,r2
0x000a58bc mfhi r2
0x000a58c0 bne r2,r0,0x000a59c8
0x000a58c4 nop
0x000a58c8 lhu r2,-0x6c26(r28)
0x000a58cc nop
0x000a58d0 beq r4,r2,0x000a59c8
0x000a58d4 nop
0x000a58d8 lui r1,0x8014
0x000a58dc lh r2,-0x7b90(r1)
0x000a58e0 nop
0x000a58e4 addi r2,r2,-0x0001
0x000a58e8 lui r1,0x8014
0x000a58ec sh r2,-0x7b90(r1)
0x000a58f0 lui r1,0x8014
0x000a58f4 sh r0,-0x7b8a(r1)
0x000a58f8 lui r1,0x8014
0x000a58fc lh r3,-0x7b94(r1)
0x000a5900 nop
0x000a5904 sll r2,r3,0x01
0x000a5908 add r3,r2,r3
0x000a590c lui r1,0x8014
0x000a5910 lh r2,-0x7b90(r1)
0x000a5914 sll r3,r3,0x01
0x000a5918 sub r3,r3,r2
0x000a591c addu r8,r2,r0
0x000a5920 lui r2,0x2aaa
0x000a5924 ori r2,r2,0xaaab
0x000a5928 mult r2,r3
0x000a592c addu r7,r3,r0
0x000a5930 srl r3,r3,0x1f
0x000a5934 mfhi r2
0x000a5938 addu r2,r2,r3
0x000a593c sll r6,r2,0x18
0x000a5940 addiu r2,r0,0x0006
0x000a5944 div r7,r2
0x000a5948 mfhi r2
0x000a594c beq r2,r0,0x000a5960
0x000a5950 sra r6,r6,0x18
0x000a5954 addi r2,r6,0x0001
0x000a5958 sll r6,r2,0x18
0x000a595c sra r6,r6,0x18
0x000a5960 addiu r2,r0,0x0006
0x000a5964 div r8,r2
0x000a5968 lui r1,0x8014
0x000a596c lh r3,-0x7b98(r1)
0x000a5970 mfhi r2
0x000a5974 sll r7,r2,0x18
0x000a5978 lui r1,0x8014
0x000a597c lh r2,-0x7b92(r1)
0x000a5980 nop
0x000a5984 sub r2,r3,r2
0x000a5988 sub r2,r2,r6
0x000a598c lui r1,0x8014
0x000a5990 sh r2,-0x7b9c(r1)
0x000a5994 lui r1,0x8014
0x000a5998 lh r2,-0x7b9c(r1)
0x000a599c nop
0x000a59a0 bgez r2,0x000a59b4
0x000a59a4 sra r7,r7,0x18
0x000a59a8 addi r2,r2,0x0018
0x000a59ac lui r1,0x8014
0x000a59b0 sh r2,-0x7b9c(r1)
0x000a59b4 sll r2,r7,0x02
0x000a59b8 add r2,r2,r7
0x000a59bc sll r2,r2,0x01
0x000a59c0 lui r1,0x8014
0x000a59c4 sh r2,-0x7b9a(r1)
0x000a59c8 lui r1,0x8015
0x000a59cc lw r2,0x57a8(r1)
0x000a59d0 nop
0x000a59d4 addu r6,r2,r0
0x000a59d8 sll r3,r6,0x01
0x000a59dc add r3,r3,r6
0x000a59e0 sll r3,r3,0x02
0x000a59e4 add r3,r3,r6
0x000a59e8 sll r6,r3,0x02
0x000a59ec lui r3,0x8013
0x000a59f0 addiu r3,r3,0xced1
0x000a59f4 addu r3,r3,r6
0x000a59f8 lbu r3,0x0000(r3)
0x000a59fc lui r1,0x8014
0x000a5a00 lw r6,-0x7ba0(r1)
0x000a5a04 sll r3,r3,0x10
0x000a5a08 andi r6,r6,0x0001
0x000a5a0c beq r6,r0,0x000a5b9c
0x000a5a10 sra r3,r3,0x10
0x000a5a14 addiu r1,r0,0x0001
0x000a5a18 bne r3,r1,0x000a5a78
0x000a5a1c nop
0x000a5a20 addiu r6,r0,0x00c8
0x000a5a24 div r5,r6
0x000a5a28 mfhi r6
0x000a5a2c bne r6,r0,0x000a5b30
0x000a5a30 nop
0x000a5a34 lhu r6,-0x6c26(r28)
0x000a5a38 nop
0x000a5a3c beq r4,r6,0x000a5b30
0x000a5a40 nop
0x000a5a44 lui r1,0x8014
0x000a5a48 lh r6,-0x7b76(r1)
0x000a5a4c nop
0x000a5a50 addi r6,r6,-0x0001
0x000a5a54 lui r1,0x8014
0x000a5a58 sh r6,-0x7b76(r1)
0x000a5a5c lui r1,0x8014
0x000a5a60 lh r6,-0x7b78(r1)
0x000a5a64 nop
0x000a5a68 addi r6,r6,-0x0001
0x000a5a6c lui r1,0x8014
0x000a5a70 beq r0,r0,0x000a5b30
0x000a5a74 sh r6,-0x7b78(r1)
0x000a5a78 addiu r1,r0,0x0002
0x000a5a7c bne r3,r1,0x000a5adc
0x000a5a80 nop
0x000a5a84 addiu r6,r0,0x012c
0x000a5a88 div r5,r6
0x000a5a8c mfhi r6
0x000a5a90 bne r6,r0,0x000a5b30
0x000a5a94 nop
0x000a5a98 lhu r6,-0x6c26(r28)
0x000a5a9c nop
0x000a5aa0 beq r4,r6,0x000a5b30
0x000a5aa4 nop
0x000a5aa8 lui r1,0x8014
0x000a5aac lh r6,-0x7b76(r1)
0x000a5ab0 nop
0x000a5ab4 addi r6,r6,-0x0001
0x000a5ab8 lui r1,0x8014
0x000a5abc sh r6,-0x7b76(r1)
0x000a5ac0 lui r1,0x8014
0x000a5ac4 lh r6,-0x7b78(r1)
0x000a5ac8 nop
0x000a5acc addi r6,r6,-0x0001
0x000a5ad0 lui r1,0x8014
0x000a5ad4 beq r0,r0,0x000a5b30
0x000a5ad8 sh r6,-0x7b78(r1)
0x000a5adc addiu r6,r0,0x04b0
0x000a5ae0 div r5,r6
0x000a5ae4 mfhi r6
0x000a5ae8 bne r6,r0,0x000a5b30
0x000a5aec nop
0x000a5af0 lhu r6,-0x6c26(r28)
0x000a5af4 nop
0x000a5af8 beq r4,r6,0x000a5b30
0x000a5afc nop
0x000a5b00 lui r1,0x8014
0x000a5b04 lh r6,-0x7b76(r1)
0x000a5b08 nop
0x000a5b0c addi r6,r6,-0x0002
0x000a5b10 lui r1,0x8014
0x000a5b14 sh r6,-0x7b76(r1)
0x000a5b18 lui r1,0x8014
0x000a5b1c lh r6,-0x7b78(r1)
0x000a5b20 nop
0x000a5b24 addi r6,r6,-0x0004
0x000a5b28 lui r1,0x8014
0x000a5b2c sh r6,-0x7b78(r1)
0x000a5b30 addiu r6,r0,0x04b0
0x000a5b34 div r5,r6
0x000a5b38 mfhi r5
0x000a5b3c bne r5,r0,0x000a5b9c
0x000a5b40 nop
0x000a5b44 lhu r5,-0x6c26(r28)
0x000a5b48 nop
0x000a5b4c beq r4,r5,0x000a5b9c
0x000a5b50 nop
0x000a5b54 lui r1,0x8014
0x000a5b58 lh r5,-0x6c70(r28)
0x000a5b5c lh r4,-0x7b9c(r1)
0x000a5b60 nop
0x000a5b64 beq r5,r4,0x000a5b9c
0x000a5b68 nop
0x000a5b6c lui r1,0x8014
0x000a5b70 lh r4,-0x7b8e(r1)
0x000a5b74 nop
0x000a5b78 addi r4,r4,0x0001
0x000a5b7c lui r1,0x8014
0x000a5b80 sh r4,-0x7b8e(r1)
0x000a5b84 lui r1,0x8014
0x000a5b88 lh r4,-0x7b8c(r1)
0x000a5b8c nop
0x000a5b90 addi r4,r4,0x0001
0x000a5b94 lui r1,0x8014
0x000a5b98 sh r4,-0x7b8c(r1)
0x000a5b9c lui r1,0x8014
0x000a5ba0 lw r4,-0x7ba0(r1)
0x000a5ba4 nop
0x000a5ba8 andi r4,r4,0x0001
0x000a5bac beq r4,r0,0x000a5db8
0x000a5bb0 nop
0x000a5bb4 lui r1,0x8014
0x000a5bb8 lh r5,-0x7b9c(r1)
0x000a5bbc lui r1,0x8014
0x000a5bc0 lh r4,-0x7b98(r1)
0x000a5bc4 addu r6,r5,r0
0x000a5bc8 slt r1,r5,r4
0x000a5bcc beq r1,r0,0x000a5bf4
0x000a5bd0 addu r7,r4,r0
0x000a5bd4 lh r4,-0x6c70(r28)
0x000a5bd8 nop
0x000a5bdc slt r1,r6,r4
0x000a5be0 beq r1,r0,0x000a5bf4
0x000a5be4 addu r5,r4,r0
0x000a5be8 slt r1,r5,r7
0x000a5bec beq r1,r0,0x000a5c20
0x000a5bf0 nop
0x000a5bf4 slt r1,r7,r6
0x000a5bf8 beq r1,r0,0x000a5db8
0x000a5bfc nop
0x000a5c00 lh r4,-0x6c70(r28)
0x000a5c04 nop
0x000a5c08 slt r1,r4,r6
0x000a5c0c beq r1,r0,0x000a5db8
0x000a5c10 addu r5,r4,r0
0x000a5c14 slt r1,r5,r7
0x000a5c18 bne r1,r0,0x000a5db8
0x000a5c1c nop
0x000a5c20 slti r1,r3,0x0003
0x000a5c24 beq r1,r0,0x000a5cc0
0x000a5c28 nop
0x000a5c2c lui r1,0x8014
0x000a5c30 lh r2,-0x7b94(r1)
0x000a5c34 nop
0x000a5c38 add r2,r7,r2
0x000a5c3c lui r1,0x8014
0x000a5c40 sh r2,-0x7b9c(r1)
0x000a5c44 lui r1,0x8014
0x000a5c48 lh r2,-0x7b9c(r1)
0x000a5c4c nop
0x000a5c50 slti r1,r2,0x0018
0x000a5c54 bne r1,r0,0x000a5c68
0x000a5c58 nop
0x000a5c5c addi r2,r2,-0x0018
0x000a5c60 lui r1,0x8014
0x000a5c64 sh r2,-0x7b9c(r1)
0x000a5c68 lui r1,0x8014
0x000a5c6c sh r0,-0x7b9a(r1)
0x000a5c70 lui r1,0x8014
0x000a5c74 lh r3,-0x7b9c(r1)
0x000a5c78 lui r1,0x8014
0x000a5c7c lh r2,-0x7b92(r1)
0x000a5c80 nop
0x000a5c84 add r2,r3,r2
0x000a5c88 lui r1,0x8014
0x000a5c8c sh r2,-0x7b98(r1)
0x000a5c90 lui r1,0x8014
0x000a5c94 lh r2,-0x7b98(r1)
0x000a5c98 nop
0x000a5c9c slti r1,r2,0x0018
0x000a5ca0 bne r1,r0,0x000a5cb4
0x000a5ca4 nop
0x000a5ca8 addi r2,r2,-0x0018
0x000a5cac lui r1,0x8014
0x000a5cb0 sh r2,-0x7b98(r1)
0x000a5cb4 lui r1,0x8014
0x000a5cb8 beq r0,r0,0x000a5d4c
0x000a5cbc sh r0,-0x7b96(r1)
0x000a5cc0 sll r3,r2,0x03
0x000a5cc4 sub r2,r3,r2
0x000a5cc8 sll r3,r2,0x02
0x000a5ccc lui r2,0x8012
0x000a5cd0 addiu r2,r2,0x25ce
0x000a5cd4 addu r2,r2,r3
0x000a5cd8 lbu r3,0x0000(r2)
0x000a5cdc lui r1,0x8014
0x000a5ce0 sll r2,r3,0x01
0x000a5ce4 add r2,r2,r3
0x000a5ce8 sll r3,r2,0x01
0x000a5cec lui r2,0x8012
0x000a5cf0 addiu r2,r2,0x2cf4
0x000a5cf4 addu r2,r2,r3
0x000a5cf8 lbu r2,0x0000(r2)
0x000a5cfc addu r4,r3,r0
0x000a5d00 sh r2,-0x7b9c(r1)
0x000a5d04 lui r2,0x8012
0x000a5d08 addiu r2,r2,0x2cf5
0x000a5d0c addu r2,r2,r4
0x000a5d10 lbu r2,0x0000(r2)
0x000a5d14 lui r1,0x8014
0x000a5d18 sh r2,-0x7b9a(r1)
0x000a5d1c lui r2,0x8012
0x000a5d20 addiu r2,r2,0x2cf6
0x000a5d24 addu r2,r2,r4
0x000a5d28 lbu r2,0x0000(r2)
0x000a5d2c lui r1,0x8014
0x000a5d30 sh r2,-0x7b98(r1)
0x000a5d34 lui r2,0x8012
0x000a5d38 addiu r2,r2,0x2cf7
0x000a5d3c addu r2,r2,r4
0x000a5d40 lbu r2,0x0000(r2)
0x000a5d44 lui r1,0x8014
0x000a5d48 sh r2,-0x7b96(r1)
0x000a5d4c lui r1,0x8014
0x000a5d50 lh r3,-0x7b94(r1)
0x000a5d54 nop
0x000a5d58 sll r2,r3,0x01
0x000a5d5c add r2,r2,r3
0x000a5d60 sll r2,r2,0x01
0x000a5d64 lui r1,0x8014
0x000a5d68 sh r2,-0x7b90(r1)
0x000a5d6c lui r1,0x8014
0x000a5d70 sh r0,-0x7b8a(r1)
0x000a5d74 lui r1,0x8014
0x000a5d78 lw r3,-0x7ba0(r1)
0x000a5d7c addiu r2,r0,0xfffe
0x000a5d80 and r2,r3,r2
0x000a5d84 lui r1,0x8014
0x000a5d88 sw r2,-0x7ba0(r1)
0x000a5d8c lui r1,0x8014
0x000a5d90 lh r2,-0x7b4e(r1)
0x000a5d94 nop
0x000a5d98 addi r2,r2,0x0001
0x000a5d9c lui r1,0x8014
0x000a5da0 sh r2,-0x7b4e(r1)
0x000a5da4 jal 0x000df2d0
0x000a5da8 nop
0x000a5dac addiu r4,r0,0x0001
0x000a5db0 jal 0x000acbf4
0x000a5db4 addiu r5,r0,0xffff
0x000a5db8 bne r16,r0,0x000a5e60
0x000a5dbc nop
0x000a5dc0 lui r1,0x8014
0x000a5dc4 lh r3,-0x7b98(r1)
0x000a5dc8 lui r1,0x8014
0x000a5dcc lh r2,-0x7b9c(r1)
0x000a5dd0 addu r5,r3,r0
0x000a5dd4 slt r1,r3,r2
0x000a5dd8 beq r1,r0,0x000a5e1c
0x000a5ddc addu r4,r2,r0
0x000a5de0 lh r2,-0x6c70(r28)
0x000a5de4 nop
0x000a5de8 slt r1,r2,r4
0x000a5dec beq r1,r0,0x000a5e00
0x000a5df0 addu r3,r2,r0
0x000a5df4 slt r1,r3,r5
0x000a5df8 beq r1,r0,0x000a5e60
0x000a5dfc nop
0x000a5e00 lui r1,0x8014
0x000a5e04 lw r2,-0x7ba0(r1)
0x000a5e08 nop
0x000a5e0c ori r2,r2,0x0001
0x000a5e10 lui r1,0x8014
0x000a5e14 beq r0,r0,0x000a5e60
0x000a5e18 sw r2,-0x7ba0(r1)
0x000a5e1c slt r1,r4,r5
0x000a5e20 beq r1,r0,0x000a5e60
0x000a5e24 nop
0x000a5e28 lh r2,-0x6c70(r28)
0x000a5e2c nop
0x000a5e30 slt r1,r2,r4
0x000a5e34 bne r1,r0,0x000a5e60
0x000a5e38 addu r3,r2,r0
0x000a5e3c slt r1,r3,r5
0x000a5e40 beq r1,r0,0x000a5e60
0x000a5e44 nop
0x000a5e48 lui r1,0x8014
0x000a5e4c lw r2,-0x7ba0(r1)
0x000a5e50 nop
0x000a5e54 ori r2,r2,0x0001
0x000a5e58 lui r1,0x8014
0x000a5e5c sw r2,-0x7ba0(r1)
0x000a5e60 lui r1,0x8014
0x000a5e64 lw r2,-0x7ba0(r1)
0x000a5e68 nop
0x000a5e6c andi r2,r2,0x0001
0x000a5e70 beq r2,r0,0x000a5e88
0x000a5e74 nop
0x000a5e78 jal 0x000ba40c
0x000a5e7c addu r4,r0,r0
0x000a5e80 beq r0,r0,0x000a5e94
0x000a5e84 lw r31,0x0014(r29)
0x000a5e88 jal 0x000ba40c
0x000a5e8c addiu r4,r0,0x0001
0x000a5e90 lw r31,0x0014(r29)
0x000a5e94 lw r16,0x0010(r29)
0x000a5e98 jr r31
0x000a5e9c addiu r29,r29,0x0018