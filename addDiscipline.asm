void addDiscipline(int amount) {
  newDiscipline = load(0x138488) + amount
  store(0x138488, newDiscipline)
  
  if(newDiscipline > 100)
    store(0x138488, 100)
}

0x000c58ec lui r1,0x8014
0x000c58f0 lh r2,-0x7b78(r1)
0x000c58f4 nop
0x000c58f8 add r2,r2,r4
0x000c58fc lui r1,0x8014
0x000c5900 sh r2,-0x7b78(r1)
0x000c5904 lui r1,0x8014
0x000c5908 lh r2,-0x7b78(r1)
0x000c590c nop
0x000c5910 slti r1,r2,0x0064
0x000c5914 bne r1,r0,0x000c5928
0x000c5918 nop
0x000c591c addiu r2,r0,0x0064
0x000c5920 lui r1,0x8014
0x000c5924 sh r2,-0x7b78(r1)
0x000c5928 jr r31
0x000c592c nop