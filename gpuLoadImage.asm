int gpuLoadImage(gpuFunctionPtr, headerPtr, headerSize, dataPtr) {
  setGPUTimeout()
  
  // empty queue
  while((load(0x116CD4) + 1) & 0x3F == load(0x116CD8)) {
    if(checkGPUTimeout() != 0)
      return -1
      
    processImageQueue()
  }
  
  irqMask = setIRQMask(0)
  store(0x116C30, irqMask)
  store(0x116C5C, 1)
  
  unknownValue = load(0x116C55)
  dmaCtrlReg = load(0x116C1C)
  
  // queue is empty, DMA is ready and unknown OR unknown is 0 -> do stuff right away
  if(unknownValue == 0 || (load(0x116CD4) == load(0x116CD8) && load(dmaCtrlReg) & 0x01000000 == 0 && load(0x116C60) == 0)) {
    
    statusRegPtr = load(0x116C10)
    while(load(statusRegPtr) & 0x04000000 == 0); // wait till GPU ready to receive command
    
    gpuFunctionPtr(headerPtr, dataPtr)
    
    irqMask = load(0x116C30)
    setIRQMask(irqMask)
    return 0
  }
  
  proxySetDMAIRQHandler(2, 0x93DDC) // set DMA2 IRQ Handler to processImageQueue
  
  // add call to queue
  queuePtrOffset = load(0x116CD4) * 96
      
  if(headerSize != 0) {
    for(i = 0; i >= headerSize / 4; i++) {
      headerData = load(headerPtr + i * 4)
      store(0x1355C0 + queuePtrOffset + i * 4, headerData) // header
    }
    
    store(0x1355B8 + queuePtrOffset, 0x1355C0 + queuePtrOffset) // headerPtr
  }
  else 
    store(0x1355B8 + queuePtrOffset, headerPtr) // headerPtr
  
  store(0x1355BC + queuePtrOffset, dataPtr) // data ptr
  store(0x1355B4 + queuePtrOffset, gpuFunctionPtr) // func ptr
  
  newQueueEnd = (load(0x116CD4) + 1) & 0x3F
  store(0x116CD4, newQueueEnd)
  
  irqMask = load(0x116C30)
  setIRQMask(irqMask)
  processImageQueue()
  
  return (load(0x116CD4) - load(0x116CD8)) & 0x3F // remaining queue size
}

0x00093b2c addiu r29,r29,0xffd8
0x00093b30 sw r19,0x001c(r29)
0x00093b34 addu r19,r4,r0
0x00093b38 sw r16,0x0010(r29)
0x00093b3c addu r16,r5,r0
0x00093b40 sw r17,0x0014(r29)
0x00093b44 addu r17,r6,r0
0x00093b48 sw r18,0x0018(r29)
0x00093b4c sw r31,0x0020(r29)
0x00093b50 jal 0x000942c8
0x00093b54 addu r18,r7,r0
0x00093b58 j 0x00093b78
0x00093b5c nop
0x00093b60 jal 0x000942fc
0x00093b64 nop
0x00093b68 bne r2,r0,0x00093dc0
0x00093b6c addiu r2,r0,0xffff
0x00093b70 jal 0x00093ddc
0x00093b74 nop
0x00093b78 lui r2,0x8011
0x00093b7c lw r2,0x6cd4(r2)
0x00093b80 lui r3,0x8011
0x00093b84 lw r3,0x6cd8(r3)
0x00093b88 addiu r2,r2,0x0001
0x00093b8c andi r2,r2,0x003f
0x00093b90 beq r2,r3,0x00093b60
0x00093b94 nop
0x00093b98 jal 0x00092450
0x00093b9c addu r4,r0,r0
0x00093ba0 lui r4,0x8011
0x00093ba4 addiu r4,r4,0x6c54
0x00093ba8 lui r1,0x8011
0x00093bac sw r2,0x6c30(r1)
0x00093bb0 lbu r3,0x0001(r4)
0x00093bb4 addiu r2,r0,0x0001
0x00093bb8 beq r3,r0,0x00093c0c
0x00093bbc sw r2,0x0008(r4)
0x00093bc0 lui r3,0x8011
0x00093bc4 lw r3,0x6cd4(r3)
0x00093bc8 lui r2,0x8011
0x00093bcc lw r2,0x6cd8(r2)
0x00093bd0 nop
0x00093bd4 bne r3,r2,0x00093c50
0x00093bd8 nop
0x00093bdc lui r2,0x8011
0x00093be0 lw r2,0x6c1c(r2)
0x00093be4 nop
0x00093be8 lw r2,0x0000(r2)
0x00093bec lui r3,0x0100
0x00093bf0 and r2,r2,r3
0x00093bf4 bne r2,r0,0x00093c50
0x00093bf8 nop
0x00093bfc lw r2,0x000c(r4)
0x00093c00 nop
0x00093c04 bne r2,r0,0x00093c50
0x00093c08 nop
0x00093c0c lui r3,0x8011
0x00093c10 lw r3,0x6c10(r3)
0x00093c14 lui r4,0x0400
0x00093c18 lw r2,0x0000(r3)
0x00093c1c nop
0x00093c20 and r2,r2,r4
0x00093c24 beq r2,r0,0x00093c18
0x00093c28 nop
0x00093c2c addu r4,r16,r0
0x00093c30 jalr r19,r31
0x00093c34 addu r5,r18,r0
0x00093c38 lui r4,0x8011
0x00093c3c lw r4,0x6c30(r4)
0x00093c40 jal 0x00092450
0x00093c44 nop
0x00093c48 j 0x00093dc0
0x00093c4c addu r2,r0,r0
0x00093c50 lui r5,0x8009
0x00093c54 addiu r5,r5,0x3ddc
0x00093c58 jal 0x000923ac
0x00093c5c addiu r4,r0,0x0002
0x00093c60 beq r17,r0,0x00093d0c
0x00093c64 addu r6,r0,r0
0x00093c68 lui r8,0x8013
0x00093c6c addiu r8,r8,0x55c0
0x00093c70 addu r7,r16,r0
0x00093c74 addu r2,r17,r0
0x00093c78 bgez r2,0x00093c84
0x00093c7c nop
0x00093c80 addiu r2,r2,0x0003
0x00093c84 sra r2,r2,0x02
0x00093c88 slt r2,r6,r2
0x00093c8c beq r2,r0,0x00093cc8
0x00093c90 sll r4,r6,0x02
0x00093c94 lw r5,0x0000(r7)
0x00093c98 addiu r7,r7,0x0004
0x00093c9c lui r3,0x8011
0x00093ca0 lw r3,0x6cd4(r3)
0x00093ca4 addiu r6,r6,0x0001
0x00093ca8 sll r2,r3,0x01
0x00093cac addu r2,r2,r3
0x00093cb0 sll r2,r2,0x05
0x00093cb4 addu r2,r2,r8
0x00093cb8 addu r4,r4,r2
0x00093cbc sw r5,0x0000(r4)
0x00093cc0 j 0x00093c78
0x00093cc4 addu r2,r17,r0
0x00093cc8 lui r2,0x8011
0x00093ccc lw r2,0x6cd4(r2)
0x00093cd0 lui r3,0x8011
0x00093cd4 lw r3,0x6cd4(r3)
0x00093cd8 sll r4,r2,0x01
0x00093cdc addu r4,r4,r2
0x00093ce0 sll r4,r4,0x05
0x00093ce4 sll r2,r3,0x01
0x00093ce8 addu r2,r2,r3
0x00093cec sll r2,r2,0x05
0x00093cf0 lui r3,0x8013
0x00093cf4 addiu r3,r3,0x55c0
0x00093cf8 addu r2,r2,r3
0x00093cfc lui r1,0x8013
0x00093d00 addu r1,r1,r4
0x00093d04 j 0x00093d30
0x00093d08 sw r2,0x55b8(r1)
0x00093d0c lui r3,0x8011
0x00093d10 lw r3,0x6cd4(r3)
0x00093d14 nop
0x00093d18 sll r2,r3,0x01
0x00093d1c addu r2,r2,r3
0x00093d20 sll r2,r2,0x05
0x00093d24 lui r1,0x8013
0x00093d28 addu r1,r1,r2
0x00093d2c sw r16,0x55b8(r1)
0x00093d30 lui r3,0x8011
0x00093d34 lw r3,0x6cd4(r3)
0x00093d38 nop
0x00093d3c sll r2,r3,0x01
0x00093d40 addu r2,r2,r3
0x00093d44 sll r2,r2,0x05
0x00093d48 lui r1,0x8013
0x00093d4c addu r1,r1,r2
0x00093d50 sw r18,0x55bc(r1)
0x00093d54 lui r3,0x8011
0x00093d58 lw r3,0x6cd4(r3)
0x00093d5c nop
0x00093d60 sll r2,r3,0x01
0x00093d64 addu r2,r2,r3
0x00093d68 sll r2,r2,0x05
0x00093d6c lui r1,0x8013
0x00093d70 addu r1,r1,r2
0x00093d74 sw r19,0x55b4(r1)
0x00093d78 lui r2,0x8011
0x00093d7c lw r2,0x6cd4(r2)
0x00093d80 lui r4,0x8011
0x00093d84 lw r4,0x6c30(r4)
0x00093d88 addiu r2,r2,0x0001
0x00093d8c andi r2,r2,0x003f
0x00093d90 lui r1,0x8011
0x00093d94 jal 0x00092450
0x00093d98 sw r2,0x6cd4(r1)
0x00093d9c jal 0x00093ddc
0x00093da0 nop
0x00093da4 lui r2,0x8011
0x00093da8 lw r2,0x6cd4(r2)
0x00093dac lui r3,0x8011
0x00093db0 lw r3,0x6cd8(r3)
0x00093db4 nop
0x00093db8 subu r2,r2,r3
0x00093dbc andi r2,r2,0x003f
0x00093dc0 lw r31,0x0020(r29)
0x00093dc4 lw r19,0x001c(r29)
0x00093dc8 lw r18,0x0018(r29)
0x00093dcc lw r17,0x0014(r29)
0x00093dd0 lw r16,0x0010(r29)
0x00093dd4 jr r31
0x00093dd8 addiu r29,r29,0x0028