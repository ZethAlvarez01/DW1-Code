void addHappiness(int amount) {
  newHappiness = load(0x13848A) + amount
  store(0x13848A, newHappiness)
  
  if(newHappiness > 100)
    store(0x13848A, 100)
}

0x000c58a8 lui r1,0x8014
0x000c58ac lh r2,-0x7b76(r1)
0x000c58b0 nop
0x000c58b4 add r2,r2,r4
0x000c58b8 lui r1,0x8014
0x000c58bc sh r2,-0x7b76(r1)
0x000c58c0 lui r1,0x8014
0x000c58c4 lh r2,-0x7b76(r1)
0x000c58c8 nop
0x000c58cc slti r1,r2,0x0064
0x000c58d0 bne r1,r0,0x000c58e4
0x000c58d4 nop
0x000c58d8 addiu r2,r0,0x0064
0x000c58dc lui r1,0x8014
0x000c58e0 sh r2,-0x7b76(r1)
0x000c58e4 jr r31
0x000c58e8 nop