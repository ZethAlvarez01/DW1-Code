int 0x000623A0() {
  store(0x73E54, 0)  
  store(0x73E60, 30)
  store(0x73E62, 50)
  store(0x73E63, 128)
  store(0x73E64, 256)
  store(0x73E68, 128)
  store(0x73E69, 128)
  store(0x73E6A, 128)
  store(0x73E6C, 20)
  store(0x73E6E, 20)
  
  // copies 0x73E54-0x73E78 to 0x73E78-0x73E9C
  for(i = 0; i < 9; i++) {
    r14 = load(0x73E54 + i * 4)
    store(0x73E78 + i * 4, r14)
  }
  
  store(0x73E80, 16)
  store(0x73E82, 16)
  store(0x73E90, 8)
  store(0x73E92, 8)
  store(0x73E9E, -1)
}

0x000623a0 lui r1,0x8007
0x000623a4 sw r0,0x3e54(r1)
0x000623a8 lui r24,0x8007
0x000623ac lui r15,0x8007
0x000623b0 addiu r2,r0,0x001e
0x000623b4 lui r1,0x8007
0x000623b8 sh r2,0x3e60(r1)
0x000623bc addiu r2,r0,0x0032
0x000623c0 lui r1,0x8007
0x000623c4 sb r2,0x3e62(r1)
0x000623c8 addiu r3,r0,0x0080
0x000623cc lui r1,0x8007
0x000623d0 sb r3,0x3e63(r1)
0x000623d4 addiu r2,r0,0x0014
0x000623d8 lui r1,0x8007
0x000623dc sh r2,0x3e6c(r1)
0x000623e0 lui r1,0x8007
0x000623e4 sh r2,0x3e6e(r1)
0x000623e8 addiu r2,r0,0x0100
0x000623ec lui r1,0x8007
0x000623f0 sh r2,0x3e64(r1)
0x000623f4 addu r2,r3,r0
0x000623f8 lui r1,0x8007
0x000623fc sb r2,0x3e68(r1)
0x00062400 addu r2,r3,r0
0x00062404 lui r1,0x8007
0x00062408 sb r2,0x3e69(r1)
0x0006240c lui r1,0x8007
0x00062410 sb r3,0x3e6a(r1)
0x00062414 addiu r24,r24,0x3e54
0x00062418 addiu r15,r15,0x3e78
0x0006241c addiu r25,r0,0x0009
0x00062420 lw r14,0x0000(r24)
0x00062424 addiu r25,r25,0xffff
0x00062428 sw r14,0x0000(r15)
0x0006242c addiu r24,r24,0x0004
0x00062430 bgtz r25,0x00062420
0x00062434 addiu r15,r15,0x0004
0x00062438 lui r3,0x8007
0x0006243c addiu r3,r3,0x3e78
0x00062440 addiu r2,r0,0x0008
0x00062444 sh r2,0x0018(r3)
0x00062448 sh r2,0x001a(r3)
0x0006244c addiu r2,r0,0x0010
0x00062450 sh r2,0x0008(r3)
0x00062454 sh r2,0x000a(r3)
0x00062458 addiu r2,r0,0xffff
0x0006245c lui r1,0x8007
0x00062460 jr r31
0x00062464 sh r2,0x3e9e(r1)