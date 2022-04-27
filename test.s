START     ADD     r0, r0, #0x0 ; i = 0;
          ADD     r1, r1, #0xA ; limit = 10

LOOP      CMP     r0, r1 ; while (i < 10)
          BEQ     EXIT_LOOP
          ADD     r0, r0, #0x1 ; i++
          B       LOOP

EXIT_LOOP MOV     r3, r0
          STR     r3, [sp, #-4]! ; store contents of r3 on the stack (push {r3})
          LDR     r4, [sp], #4 ; get content from the stack and store in r4 (pop {r4})
