0x00       nop
0x04       nop
0x08       lui a1  0x12345
0x0C       add a0  a1  a2
0x10 here: nop                    -00
0x14       nop                    -04
0x18       nop                    -08
0x1C       sw  a0 0x4(x0)         -12
0x20       lw  a0 0x8(x0)         -16
0x24       beq x0     x0 here(-20)