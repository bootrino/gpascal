                     ************************************************
                2    * PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 4
                5    * Authors: Nick Gammon & Sue Gobbett
                6    *  HIMEM:$8500  SYM $9500
                     ************************************************
                8    P1       EQU  $8013      
                9    P2       EQU  $8DD4      
                10   P3       EQU  $992E      
                11   P4       EQU  $A380      
                12   P5       EQU  $B384      
                13   P6       EQU  $BCB8      
                14   *
                15   STACK    EQU  $100       
                16   INBUF    EQU  $33C       
                17   KBD:BUF  EQU  $277       
                18   HIMEM    EQU  $283       
                19   COLOR    EQU  $286       
                20   HIBASE   EQU  $288       
                21   AUTODN   EQU  $292       
                22   BITNUM   EQU  $298       
                23   BAUDOF   EQU  $299       
                24   RODBS    EQU  $29D       
                25   RODBE    EQU  $29E       
                26   ENABRS   EQU  $2A1       
                27   WARM:STR EQU  $302       
                28   CINV     EQU  $314       
                29   *
                30   SPACE    EQU  $20        
                31   CR       EQU  $D         
                32   FF       EQU  $C         
                33   LF       EQU  $A         
                34   MAX:STK  EQU  32         
                35   NEW:STK  EQU  $FF        
                36   *
                37   VIC      EQU  $D000      
                38   SID      EQU  $D400      
                39   CIA1     EQU  $DC00      
                40   CIA2     EQU  $DD00      
                41   DATAREG  EQU  $DD01      
                42   DDRB     EQU  $DD03      
                43   FLAG     EQU  $DD0D      
                44   BORDER   EQU  $D020      
                45   BKGND    EQU  $D021      
                46   *
                47   COUT     EQU  $FFD2      
                48   STOP     EQU  $FFE1      
                49   GETIN    EQU  $FFE4      
                50   CHKOUT   EQU  $FFC9      
                51   CLRCHN   EQU  $FFCC      
                52   UNLSN    EQU  $FFAE      
                53   UNTKL    EQU  $FFAB      
                54   CHRIN    EQU  $FFCF      
                55   CHKIN    EQU  $FFC6      
                56   PLOT     EQU  $FFF0      
                57   CHROUT   EQU  $FFD2      
                58   CINT     EQU  $FF81      
                59   IOINIT   EQU  $FF84      
                60   CLALL    EQU  $FFE7      
                61   SETMSG   EQU  $FF90      
                62   SETLFS   EQU  $FFBA      
                63   SETNAM   EQU  $FFBD      
                64   OPEN     EQU  $FFC0      
                65   LOAD     EQU  $FFD5      
                66   READST   EQU  $FFB7      
                67   SAVE     EQU  $FFD8      
                68   RAMTAS   EQU  $FF87      
                69   RESTOR   EQU  $FF8A      
                70   MEMTOP   EQU  $FF99      
                71   UNTLK    EQU  $FFAB      
                72   CLOSE    EQU  $FFC3      
                73   *
                74   *
                75            DUM  $2A7       
                76   *
                77   * PASCAL WORK AREAS
                78   *
                     ************************************************
                80   LINE:CNT EQU  $2         ;
                81   LINE:NO  EQU  LINE:CNT   
                82   REG      EQU  $4         ;
                83   ROWL     EQU  REG        
                84   ROWH     EQU  REG+1      
                85   SRCE     EQU  REG        
                86   REG2     EQU  $6         ;
                87   DEST     EQU  REG2       
                88   WX       EQU  $8         ;
                89   ERR:RTN  EQU  $B         ;
                90   SYMTBL   EQU  $D         
                91   TOKEN    EQU  $16        
                92   TKNADR   EQU  $17        ;
                93   TKNLEN   EQU  $19        
                94   EOF      EQU  $1A        
                95   LIST     EQU  $1B        
                96   NXTCHR   EQU  $1C        ;
                97   VALUE    EQU  $1E        ; 3 BYTES
                98   DIGIT    EQU  $21        
                99   NOTRSV   EQU  $22        
                100  FRAME    EQU  $23        ;
                101  LEVEL    EQU  $25        
                102  PCODE    EQU  $26        
                103  P        EQU  PCODE      
                104  PNTR     EQU  PCODE      
                105  ACT:PCDA EQU  $28        ;
                106  DISPL    EQU  $2A        ;
                107  OFFSET   EQU  $2C        ;
                108  OPND     EQU  $2E        ; 3 BYTES
                109  DCODE    EQU  $31        
                110  ENDSYM   EQU  $32        ;
                111  ARG      EQU  $34        
                112  PROMPT   EQU  $35        
                113  WORKD    EQU  $36        ;
                114  ERRNO    EQU  $38        
                115  RTNADR   EQU  $39        ;
                116  BSAVE    EQU  $3B        
                117  WORK     EQU  $3C        ;
                118  PRCITM   EQU  $3E        ;
                119  DSPWRK   EQU  $40        ;
                120  PFLAG    EQU  $42        
                121  T        EQU  ENDSYM     ; STACK POINTER
                122  TMP:PNTR EQU  T          
                123  BASE     EQU  $45        ;
                124  TO       EQU  BASE       
                125  DATA     EQU  $47        ;
                126  RUNNING  EQU  $49        
                127  UPR:CASE EQU  $4A        
                128  SCE:LIM  EQU  $4B        ;
                129  FUNCTION EQU  SCE:LIM    
                130  SPRITENO EQU  SCE:LIM+1  
                131  STK:USE  EQU  $4D        
                132  VOICENO  EQU  STK:USE    
                133  SYMITM   EQU  $4E        ;
                134  FROM     EQU  SYMITM     
                135  SYNTAX   EQU  $50        
                136  CHK:ARY  EQU  $51        
                137  SECRET   EQU  $52        
                138  VAL:CMP  EQU  $53        
                139  CTRLC:RT EQU  $54        ;
                140  END:PCD  EQU  $56        ;
                141  REGB     EQU  $58        
                142  REG2B    EQU  $59        
                143  LEFTCOL  EQU  $5A        
                144  SIGN     EQU  $5B        
                145  TEMP     EQU  $5C        ;
                146  CALL     EQU  $5E        ;
                147  COUNT    EQU  $60        
                148  LNCNT    EQU  $61        
                149  LS       EQU  $62        
                150  PCSVD    EQU  $63        ;
                151  FIRST    EQU  $65        
                152  DBGTYP   EQU  $66        
                153  DBGFLG   EQU  $67        
                154  DEFP     EQU  $68        ;
                155  DEFS     EQU  $6A        ;
                156  DATTYP   EQU  $6C        
                157  DOS:FLG  EQU  DATTYP     
                158  A5       EQU  $6D        ;
                159  MASK     EQU  A5         
                160  COLL:REG EQU  A5+1       
                161  ST       EQU  $90        
                162  DFLTN    EQU  $99        ; input device
                163  QUEUE    EQU  $C6        
                164  INDX     EQU  $C8        
                165  LXSP     EQU  $C9        
                166  BLNSW    EQU  $CC        
                167  BLNON    EQU  $CF        
                168  CRSW     EQU  $D0        
                169  BASL     EQU  $D1        
                170  CH       EQU  $D3        
                171  *
                172  P:STACK  EQU  $CED0      ; P-CODE STACK
                173  S:ANIMCT EQU  $CED8      ; count of frames
                174  S:ANIMPS EQU  $CEE0      ; current position
                175  S:ANIMCC EQU  $CEE8      ; current frame count
                176  S:ANIMFM EQU  $CEF0      ; no. of frames
                177  S:POINTR EQU  $CEF8      ; pointers - 16 per sprite
                178  SID:IMG  EQU  $CF7C      
                179  S:ACTIVE EQU  $CF98      
                180  S:XPOS   EQU  $CFA0      ; 3 bytes each
                181  S:YPOS   EQU  $CFB8      ; 2 bytes each
                182  S:XINC   EQU  $CFC8      ; 3 bytes each
                183  S:YINC   EQU  $CFE0      ; 2 bytes each
                184  S:COUNT  EQU  $CFF0      ; 2 bytes each
                185  *
                186  COUNT1   DS   1          
                187  COUNT2   DS   1          
                188  SYM:USE  DS   2          ;
                189  SAVCUR   DS   6          ; 6 BYTES
                190  BPOINT   DS   20         
                191  CALL:P   EQU  BPOINT     
                192  CALL:A   EQU  BPOINT+1   
                193  CALL:X   EQU  BPOINT+2   
                194  CALL:Y   EQU  BPOINT+3   
                195  FNC:VAL  EQU  BPOINT+15  
                196  REMAIN   EQU  BPOINT+4   
                197  XPOSL    EQU  BPOINT+15  
                198  XPOSH    EQU  BPOINT+16  
                199  YPOS     EQU  BPOINT+17  
                200  CNTR     EQU  BPOINT+10  
                201  REP:FROM EQU  BPOINT+2   
                202  REP:TO   EQU  BPOINT+3   
                203  REP:LEN  EQU  BPOINT+4   
                204  PNTR:HI  EQU  BPOINT+5   
                205  IN:LGTH  EQU  BPOINT+6   
                206  LENGTH   EQU  BPOINT+7   
                207  FROM:ST  EQU  BPOINT+9   
                208  NUM:LINS EQU  BPOINT+11  
                209  ED:COM   EQU  BPOINT+13  
                210  TO:LINE  EQU  BPOINT+15  
                211  FND:FROM EQU  BPOINT+17  
                212  FND:TO   EQU  BPOINT+18  
                213  FND:POS  EQU  BPOINT+19  
                214  LASTP    DS   2          
                215  INCHAR   DS   1          
                216  IO:A     DS   1          
                217  IO:Y     DS   1          
                218  IO:X     DS   1          
                219  CURR:CHR DS   1          
                220  HEX:WK   DS   1          
                221           DS   2          
                222  STK:AVL  DS   1          
                223  STK:PAGE DS   1          
                224  STK:WRK  DS   1          
                225  STK:RT   DS   2          
                226  BEG:STK  DS   1          
                227  XSAVE    DS   1          
                228  RES      DS   3          ; 3 BYTES
                229  MCAND    DS   3          ; 3 BYTES
                230  DIVISOR  EQU  MCAND      
                231  DVDN     DS   3          ; 3 BYTES
                232  RMNDR    DS   1          
                233  TEMP1    DS   2          
                234  BIN:WRK  DS   3          
                235  ASC:WRK  DS   10         
                236  DEF:PCD  DS   1          
                237  REP:SIZE DS   1          
                238  NLN:FLAG DS   1          
                239  Q:FLAG   DS   1          
                240  FND:FLG  DS   1          
                241  FND:LEN  DS   1          
                242  UC:FLAG  DS   1          
                243  TRN:FLAG DS   1          
                244  GLB:FLAG DS   1          
                245  INT:RTN  DS   2          ; address to return to after a timer interrupt
                246  INT:TEMP DS   1          ; for interrupt service routine
                247  INT:TMP1 DS   1          
                248  INT:TMP2 DS   1          
                249  QT:TGL   DS   1          ; quote toggle
                250  QT:SIZE  DS   1          ; number of characters in reserved words
                251           DEND            
                     ************************************************
                253  *  SYMBOL TABLE DEFINES - RELATIVE TO SYMBOL TABLE ENTRY
                     ************************************************
                255  SYMPRV   EQU  0          
                256  SYMLVL   EQU  2          
                257  SYMTYP   EQU  3          
                258  SYMDSP   EQU  4          
                259  SYMARG   EQU  6          
                260  SYMSUB   EQU  6          
                261  SYMDAT   EQU  8          
                262  SYMLEN   EQU  9          
                263  SYMNAM   EQU  10         
                     ************************************************
                265  * ADDRESS CONSTANTS ETC.
                     ************************************************
                267           DUM  $8000      
                268           DS   3          
                269           DS   3          
                270           DS   3          
8009: 00 40     271  TS       DA   $4000      
800B: 10        272  SYM:SIZE DFB  16         
800C: 5B        273  LHB      ASC  '['
800D: 5D        274  RHB      ASC  ']'
800E: 22        275  QUOT:SYM ASC  '"' ; QUOTE SYMBOL
800F: 2E        276  DELIMIT  ASC  '.' ; FIND/REPLACE DELIMITER
8010: 04        277  PR:CHAN  DFB  4          ; PRINTER CHANNEL
8011: 08        278  DISK:CHN DFB  8          ; DISK CHANNEL
8012: 00        279           DFB  0          ; SPARE FOR NOW
                280           DEND            
                281  *
                282  *
                283  *
                284  V1       EQU  P1         
                285  INIT     EQU  V1         
                286  GETNEXT  EQU  V1+3       
                287  COMSTL   EQU  V1+6       
                288  ISITHX   EQU  V1+9       
                289  ISITAL   EQU  V1+12      
                290  ISITNM   EQU  V1+15      
                291  CHAR     EQU  V1+18      
                292  GEN2:B   EQU  V1+21      
                293  DISHX    EQU  V1+24      
                294  ERROR    EQU  V1+27      
                295  PRBYTE   EQU  V1+51      
                296  GTOKEN   EQU  V1+54      
                297  SPARE2   EQU  V1+57      
                298  FIXAD    EQU  V1+60      
                299  PSHWRK   EQU  V1+63      
                300  PULWRK   EQU  V1+66      
                301  PC       EQU  V1+69      
                302  PT       EQU  V1+72      
                303  PL       EQU  V1+75      
                304  TOKEN1   EQU  V1+78      
                305  GETANS   EQU  V1+81      
                306  PUTSP    EQU  V1+84      
                307  DISPAD   EQU  V1+87      
                308  CROUT    EQU  V1+90      
                309  GET:NUM  EQU  V1+96      
                310  GET:HEX  EQU  V1+99      
                311  PAUSE    EQU  V1+105     
                312  HOME     EQU  V1+108     
                313  RDKEY    EQU  V1+111     
                     ************************************************
                315  * PART 3 VECTORS
                     ************************************************
                317  V3       EQU  P3         
                318  START    EQU  V3         
                319  RESTART  EQU  V3+3       
                320  DSP:BIN  EQU  V3+6       
                321  ST:CMP   EQU  P3+9       
                322  ST:SYN   EQU  P3+12      
                323  DEBUG    EQU  P3+15      
                324  BELL1:AX EQU  P3+24      
                325  MOV:SPT  EQU  P3+27      
                326  SPT:STAT EQU  P3+30      
                327  SPRT:X   EQU  P3+33      
                328  SPRT:Y   EQU  P3+36      
                329  STOP:SPT EQU  P3+39      
                330  STRT:SPT EQU  P3+42      
                331  ANM:SPT  EQU  P3+45      
                332  LOADIT   EQU  P3+48      
                333  SAVEIT   EQU  P3+51      
                334  FREEZE:S EQU  P3+54      
                335  FR:STAT  EQU  P3+57      
                336  X:OPEN   EQU  P3+60      
                337  X:CLOSE  EQU  P3+63      
                338  X:PUT    EQU  P3+66      
                339  X:GET    EQU  P3+69      
                     ************************************************
                341  * PART 5 VECTORS
                     ************************************************
                343  EDITOR   EQU  P5         
                344  GETLN    EQU  P5+3       
                345  GETLNZ   EQU  P5+6       
                346  GETLN1   EQU  P5+9       
                     ************************************************
                348  * PART 4 STARTS HERE
                     ************************************************
                350           ORG  P4         
                     ************************************************
                352  * PART 4 VECTORS
                     ************************************************
A380: 4C E8 A3  354           JMP  INTERJ     
A383: 4C CA A3  355           JMP  DIS4       
A386: 4C D0 A4  356           JMP  BREAK      
A389: 4C F3 A6  357           JMP  CHK:ERR    
A38C: 4C 82 A4  358           JMP  MAIN       
A38F: 4C 7F A4  359           JMP  MAINP      
A392: 4C DF A6  360           JMP  CHK:TOP    
A395: 4C DE AD  361           JMP  TRUE2      
A398: 4C E5 A5  362           JMP  PULTOP     
A39B: 4C BD A9  363           JMP  S:PNT2     
                364  MASKS    EQU  *          
A39E: 01 02 04  365           HEX  0102040810204080 
A3A1: 08 10 20 40 80 
                366  XMASKS   EQU  *          
A3A6: FE FD FB  367           HEX  FEFDFBF7EFDFBF7F ; complement of above 
A3A9: F7 EF DF BF 7F 
                368  * 
                369  *
A3AE: B6 C7 0D  370  DM5      HEX  B6C70D     
A3B1: 62 52 45  371  DM6      ASC  'bREAK ...',0D 
A3B4: 41 4B 20 2E 2E 2E 0D 
A3BB: BD        372  DM7      DFB  $BD        
A3BC: 20 4F 43  373           ASC  ' OCCURRED AT',B0 
A3BF: 43 55 52 52 45 44 20 41 
A3C7: 54 B0 
A3C9: 20        374           ASC  ' '        
                375  *
                376  *
                377  * DISPLAY (X) CHARACTERS FROM (WORK)
                378  *
A3CA: 8A        379  DIS4     TXA             
A3CB: 48        380           PHA             
A3CC: 20 67 80  381           JSR  PUTSP      
A3CF: 68        382           PLA             
A3D0: AA        383           TAX             
A3D1: A0 00     384  DIS5     LDY  #0         
A3D3: B1 3C     385           LDA  (WORK),Y   
A3D5: E6 3C     386           INC  WORK       
A3D7: D0 02     387           BNE  DIS5:A     
A3D9: E6 3D     388           INC  WORK+1     
                389  DIS5:A   EQU  *          
A3DB: A8        390           TAY             
A3DC: 8A        391           TXA             
A3DD: 48        392           PHA             
A3DE: 98        393           TYA             
A3DF: 20 2B 80  394           JSR  DISHX      
A3E2: 68        395           PLA             
A3E3: AA        396           TAX             
A3E4: CA        397           DEX             
A3E5: D0 EA     398           BNE  DIS5       
A3E7: 60        399           RTS             
                400  *
                401  * INTERPRETER INITIALIZATION
                402  *
                403  INTERJ   EQU  *          
A3E8: A9 7F     404           LDA  #$7F       
A3EA: 8D 0D DD  405           STA  CIA2+13    
A3ED: 4C 12 AC  406           JMP  SOUND:CL   ; clear SID, go to MAIN
                407  *
                408  *
                409  *
                410  BELL1    EQU  *          
A3F0: 48        411           PHA             
A3F1: A9 00     412           LDA  #0         
A3F3: 85 49     413           STA  RUNNING    
A3F5: 20 6D 80  414           JSR  CROUT      
A3F8: 68        415           PLA             
A3F9: 60        416           RTS             
                417  *
                418  *
A3FA: 20 F0 A3  419  RUNERR   JSR  BELL1      
A3FD: A9 BB     420           LDA  #DM7       
A3FF: A2 A3     421           LDX  #>DM7      
A401: A0 0F     422           LDY  #15        
A403: 20 5B 80  423           JSR  PT         
A406: AD C6 02  424           LDA  LASTP+1    
A409: 20 46 80  425           JSR  PRBYTE     
A40C: AD C5 02  426           LDA  LASTP      
A40F: 20 2B 80  427           JSR  DISHX      
                428  FINISHD  EQU  *          
A412: A9 00     429           LDA  #0         
A414: 85 C6     430           STA  QUEUE      ; clear keyboard queue
A416: 20 6D 80  431           JSR  CROUT      
A419: A9 28     432           LDA  #FIN:MSG   
A41B: A2 A4     433           LDX  #>FIN:MSG  
A41D: A0 1E     434           LDY  #30        
A41F: 20 5B 80  435           JSR  PT         
A422: 20 82 80  436           JSR  RDKEY      ; wait till message seen
A425: 4C 31 99  437           JMP  RESTART    
                438  *
A428: 52 55 4E  439  FIN:MSG  ASC  'RUN FINISHED - PRESS A KEY ...' 
A42B: 20 46 49 4E 49 53 48 45 
A433: 44 20 2D 20 50 52 45 53 
A43B: 53 20 41 20 4B 45 59 20 
A443: 2E 2E 2E 
                440  *
                441  *
                442  CHK:KBD  EQU  *          
A446: C9 AA     443           CMP  #$AA       ; COMMODORE/N
A448: D0 09     444           BNE  CHK:NOTN   
A44A: 20 E4 FF  445           JSR  GETIN      
A44D: A9 00     446           LDA  #0         
A44F: 85 67     447           STA  DBGFLG     
A451: 38        448           SEC             
A452: 60        449           RTS             
A453: C9 A3     450  CHK:NOTN CMP  #$A3       ; COMMODORE/T
A455: D0 0B     451           BNE  CHK:NOTT   
A457: 20 E4 FF  452           JSR  GETIN      
A45A: A9 80     453           LDA  #$80       
A45C: 85 67     454           STA  DBGFLG     
A45E: 85 31     455           STA  DCODE      
A460: 38        456           SEC             
A461: 60        457           RTS             
A462: C9 AC     458  CHK:NOTT CMP  #$AC       ; COMMODORE/D
A464: D0 0B     459           BNE  CHK:NOTD   
A466: 20 E4 FF  460           JSR  GETIN      
A469: A9 01     461           LDA  #1         
A46B: 85 67     462           STA  DBGFLG     
A46D: 85 31     463           STA  DCODE      
A46F: 38        464           SEC             
A470: 60        465           RTS             
A471: 18        466  CHK:NOTD CLC             
A472: 60        467           RTS             
                468  *
                469  OUTCR    EQU  *          
A473: 20 6D 80  470           JSR  CROUT      ; OUTPUT C/R
A476: 4C 82 A4  471           JMP  MAIN       
                472  *
                473  *
A479: 84 05     474  LOWLIT   STY  REG+1      
A47B: 29 7F     475           AND  #$7F       
A47D: 85 04     476           STA  REG        
A47F: 20 2C A6  477  MAINP    JSR  PSHTOP     
A482: A5 67     478  MAIN     LDA  DBGFLG     
A484: F0 03     479           BEQ  MAIN:2     
A486: 20 3D 99  480           JSR  DEBUG      
                481  MAIN:2   EQU  *          
A489: 20 E1 FF  482           JSR  STOP       
A48C: D0 03     483           BNE  MAIN:3     
A48E: 4C D0 A4  484           JMP  BREAK      ; stop pressed
A491: A5 C6     485  MAIN:3   LDA  QUEUE      ; key in queue?
A493: F0 06     486           BEQ  MAIN:OK    ; no
A495: AD 77 02  487           LDA  KBD:BUF    ; what is it?
A498: 20 46 A4  488           JSR  CHK:KBD    
                489  MAIN:OK  EQU  *          
A49B: A5 26     490           LDA  P          
A49D: 8D C5 02  491           STA  LASTP      
A4A0: A5 27     492           LDA  P+1        
A4A2: 8D C6 02  493           STA  LASTP+1    
A4A5: A0 00     494           LDY  #0         
A4A7: 84 58     495           STY  REGB       
A4A9: B1 26     496           LDA  (P),Y      
A4AB: 30 04     497           BMI  MAIN:5     
A4AD: C9 62     498           CMP  #$62       
A4AF: B0 12     499           BGE  INVINS     
                500  MAIN:5   EQU  *          
A4B1: E6 26     501           INC  P          
A4B3: D0 02     502           BNE  MAIN:1     
A4B5: E6 27     503           INC  P+1        
                504  MAIN:1   EQU  *          
A4B7: AA        505           TAX             
A4B8: 30 BF     506           BMI  LOWLIT     
A4BA: BD D7 A4  507           LDA  EXADTBH,X  
A4BD: 48        508           PHA             
A4BE: BD 39 A5  509           LDA  EXADTBL,X  
A4C1: 48        510           PHA             
A4C2: 60        511           RTS             
                512  *
                513  NOTIMP   EQU  *          
                514  INVINS   EQU  *          
A4C3: A9 AE     515           LDA  #DM5       
A4C5: A2 A3     516           LDX  #>DM5      
                517  NOTIM1   EQU  *          
A4C7: 20 F0 A3  518           JSR  BELL1      
A4CA: 20 5E 80  519           JSR  PL         
A4CD: 4C FA A3  520           JMP  RUNERR     
                521  *
                522  BREAK    EQU  *          
A4D0: A9 B1     523           LDA  #DM6       
A4D2: A2 A3     524           LDX  #>DM6      
A4D4: 4C C7 A4  525           JMP  NOTIM1     
                526  *
                527  EXADTBH  EQU  *          
A4D7: A6        528           DFB  >LIT-1     
A4D8: AA        529           DFB  >DEF:SPRT-1 
A4D9: A6        530           DFB  >NEG-1     
A4DA: B2        531           DFB  >HPLOT-1   
A4DB: A6        532           DFB  >ADD-1     
A4DC: B3        533           DFB  >TOHPLOT-1 
A4DD: A6        534           DFB  >SUB-1     
A4DE: A9        535           DFB  >GETKEY-1  
A4DF: A6        536           DFB  >MUL-1     
A4E0: A8        537           DFB  >CLEAR-1   
A4E1: AC        538           DFB  >DIV-1     
A4E2: AC        539           DFB  >MOD-1     
A4E3: B3        540           DFB  >ADRNN-1   
A4E4: B3        541           DFB  >ADRNC-1   
A4E5: B3        542           DFB  >ADRAN-1   
A4E6: B3        543           DFB  >ADRAC-1   
A4E7: AD        544           DFB  >EQL-1     
A4E8: A4        545           DFB  >FINISHD-1 
A4E9: AE        546           DFB  >NEQ-1     
A4EA: AC        547           DFB  >CUR-1     
A4EB: AE        548           DFB  >LSS-1     
A4EC: 99        549           DFB  >FREEZE:S-1 
A4ED: AE        550           DFB  >GEQ-1     
A4EE: B0        551           DFB  >INH-1     
A4EF: AE        552           DFB  >GTR-1     
A4F0: AE        553           DFB  >LEQ-1     
A4F1: AE        554           DFB  >ORR-1     
A4F2: AE        555           DFB  >AND-1     
A4F3: B0        556           DFB  >INP-1     
A4F4: B2        557           DFB  >INPC-1    
A4F5: B0        558           DFB  >OUT-1     
A4F6: B2        559           DFB  >OUTC-1    
A4F7: AE        560           DFB  >EOR-1     
A4F8: B0        561           DFB  >OUH-1     
A4F9: AE        562           DFB  >SHL-1     
A4FA: B0        563           DFB  >OUS-1     
A4FB: AE        564           DFB  >SHR-1     
A4FC: B2        565           DFB  >INS-1     
A4FD: AE        566           DFB  >INC-1     
A4FE: B0        567           DFB  >CLL-1     
A4FF: AE        568           DFB  >DEC-1     
A500: AF        569           DFB  >RTN-1     
A501: AE        570           DFB  >MOV-1     
A502: B1        571           DFB  >CLA-1     
A503: AF        572           DFB  >LOD-1     
A504: AF        573           DFB  >LODC-1    
A505: AF        574           DFB  >LDA-1     
A506: AF        575           DFB  >LDAC-1    
A507: AF        576           DFB  >LDI-1     
A508: AF        577           DFB  >LDIC-1    
A509: AF        578           DFB  >STO-1     
A50A: AF        579           DFB  >STOC-1    
A50B: AF        580           DFB  >STA-1     
A50C: AF        581           DFB  >STAC-1    
A50D: AF        582           DFB  >STI-1     
A50E: AF        583           DFB  >STIC-1    
A50F: B0        584           DFB  >ABSCLL-1  
A510: A7        585           DFB  >WAIT-1    
A511: AE        586           DFB  >XOR-1     
A512: B1        587           DFB  >INT-1     
A513: B1        588           DFB  >JMP-1     
A514: B1        589           DFB  >JMZ-1     
A515: B1        590           DFB  >JM1-1     
A516: A9        591           DFB  >SPRITE-1  
A517: A7        592           DFB  >MVE:SPRT-1 
A518: AB        593           DFB  >VOICE-1   
A519: A9        594           DFB  >GRAPHICS-1 
A51A: AB        595           DFB  >SOUND-1   
A51B: A8        596           DFB  >SET:CLK-1 
A51C: A8        597           DFB  >SCROLL-1  
A51D: A7        598           DFB  >SP:COLL-1 
A51E: A7        599           DFB  >BK:COLL-1 
A51F: A7        600           DFB  >CURSORX-1 
A520: A7        601           DFB  >CURSORY-1 
A521: A7        602           DFB  >CLOCK-1   
A522: A7        603           DFB  >PADDLE-1  
A523: 99        604           DFB  >SPRT:X-1  
A524: A8        605           DFB  >JOY-1     
A525: 99        606           DFB  >SPRT:Y-1  
A526: A8        607           DFB  >OSC3-1    
A527: A8        608           DFB  >VOICE3-1  
A528: A8        609           DFB  >SCROLLX-1 
A529: A8        610           DFB  >SCROLLY-1 
A52A: 99        611           DFB  >SPT:STAT-1 
A52B: 99        612           DFB  >MOV:SPT-1 
A52C: 99        613           DFB  >STOP:SPT-1 
A52D: 99        614           DFB  >STRT:SPT-1 
A52E: 99        615           DFB  >ANM:SPT-1 
A52F: AD        616           DFB  >ABS-1     
A530: A7        617           DFB  >INVALID-1 
A531: 99        618           DFB  >LOADIT-1  
A532: 99        619           DFB  >SAVEIT-1  
A533: 99        620           DFB  >X:OPEN-1  
A534: 99        621           DFB  >FR:STAT-1 
A535: A4        622           DFB  >OUTCR-1   
A536: 99        623           DFB  >X:CLOSE-1 
A537: 99        624           DFB  >X:GET-1   
A538: 99        625           DFB  >X:PUT-1   
                626  EXADTBL  EQU  *          
A539: 5E        627           DFB  LIT-1      
A53A: FA        628           DFB  DEF:SPRT-1 
A53B: 6F        629           DFB  NEG-1      
A53C: 5E        630           DFB  HPLOT-1    
A53D: 88        631           DFB  ADD-1      
A53E: 4F        632           DFB  TOHPLOT-1  
A53F: 9D        633           DFB  SUB-1      
A540: 5E        634           DFB  GETKEY-1   
A541: A3        635           DFB  MUL-1      
A542: DB        636           DFB  CLEAR-1    
A543: B3        637           DFB  DIV-1      
A544: 8D        638           DFB  MOD-1      
A545: 62        639           DFB  ADRNN-1    
A546: 52        640           DFB  ADRNC-1    
A547: 70        641           DFB  ADRAN-1    
A548: 76        642           DFB  ADRAC-1    
A549: CA        643           DFB  EQL-1      
A54A: 11        644           DFB  FINISHD-1  
A54B: 06        645           DFB  NEQ-1      
A54C: 78        646           DFB  CUR-1      
A54D: 13        647           DFB  LSS-1      
A54E: 63        648           DFB  FREEZE:S-1 
A54F: 29        649           DFB  GEQ-1      
A550: C4        650           DFB  INH-1      
A551: 1A        651           DFB  GTR-1      
A552: 30        652           DFB  LEQ-1      
A553: 51        653           DFB  ORR-1      
A554: 63        654           DFB  AND-1      
A555: 27        655           DFB  INP-1      
A556: 01        656           DFB  INPC-1     
A557: 7C        657           DFB  OUT-1      
A558: 12        658           DFB  OUTC-1     
A559: 75        659           DFB  EOR-1      
A55A: 85        660           DFB  OUH-1      
A55B: 8A        661           DFB  SHL-1      
A55C: 9A        662           DFB  OUS-1      
A55D: A4        663           DFB  SHR-1      
A55E: 1D        664           DFB  INS-1      
A55F: BF        665           DFB  INC-1      
A560: F5        666           DFB  CLL-1      
A561: D7        667           DFB  DEC-1      
A562: EE        668           DFB  RTN-1      
A563: ED        669           DFB  MOV-1      
A564: 89        670           DFB  CLA-1      
A565: 23        671           DFB  LOD-1      
A566: 11        672           DFB  LODC-1     
A567: 42        673           DFB  LDA-1      
A568: 37        674           DFB  LDAC-1     
A569: 7D        675           DFB  LDI-1      
A56A: 77        676           DFB  LDIC-1     
A56B: 90        677           DFB  STO-1      
A56C: 83        678           DFB  STOC-1     
A56D: A3        679           DFB  STA-1      
A56E: B9        680           DFB  STAC-1     
A56F: D3        681           DFB  STI-1      
A570: C5        682           DFB  STIC-1     
A571: EE        683           DFB  ABSCLL-1   
A572: CA        684           DFB  WAIT-1     
A573: 3F        685           DFB  XOR-1      
A574: B1        686           DFB  INT-1      
A575: D2        687           DFB  JMP-1      
A576: E7        688           DFB  JMZ-1      
A577: F8        689           DFB  JM1-1      
A578: 64        690           DFB  SPRITE-1   
A579: 0D        691           DFB  MVE:SPRT-1 
A57A: 3F        692           DFB  VOICE-1    
A57B: F5        693           DFB  GRAPHICS-1 
A57C: EE        694           DFB  SOUND-1    
A57D: 4A        695           DFB  SET:CLK-1  
A57E: 9A        696           DFB  SCROLL-1   
A57F: 56        697           DFB  SP:COLL-1  
A580: 5C        698           DFB  BK:COLL-1  
A581: 62        699           DFB  CURSORX-1  
A582: 6B        700           DFB  CURSORY-1  
A583: 74        701           DFB  CLOCK-1    
A584: E0        702           DFB  PADDLE-1   
A585: 4E        703           DFB  SPRT:X-1   
A586: 11        704           DFB  JOY-1      
A587: 51        705           DFB  SPRT:Y-1   
A588: 24        706           DFB  OSC3-1     
A589: 2A        707           DFB  VOICE3-1   
A58A: 30        708           DFB  SCROLLX-1  
A58B: 38        709           DFB  SCROLLY-1  
A58C: 4B        710           DFB  SPT:STAT-1 
A58D: 48        711           DFB  MOV:SPT-1  
A58E: 54        712           DFB  STOP:SPT-1 
A58F: 57        713           DFB  STRT:SPT-1 
A590: 5A        714           DFB  ANM:SPT-1  
A591: 26        715           DFB  ABS-1      
A592: 51        716           DFB  INVALID-1  
A593: 5D        717           DFB  LOADIT-1   
A594: 60        718           DFB  SAVEIT-1   
A595: 69        719           DFB  X:OPEN-1   
A596: 66        720           DFB  FR:STAT-1  
A597: 72        721           DFB  OUTCR-1    
A598: 6C        722           DFB  X:CLOSE-1  
A599: 72        723           DFB  X:GET-1    
A59A: 6F        724           DFB  X:PUT-1    
A59B: A0 00     725  GETADR   LDY  #0         
A59D: B1 26     726           LDA  (P),Y      
A59F: 8D A7 02  727           STA  COUNT1     
A5A2: A5 46     728           LDA  BASE+1     
A5A4: A6 45     729           LDX  BASE       
                730  GET2     EQU  *          
A5A6: 85 48     731           STA  DATA+1     
A5A8: 86 47     732           STX  DATA       
A5AA: A8        733           TAY             
A5AB: AD A7 02  734           LDA  COUNT1     
A5AE: F0 19     735           BEQ  GET1       
A5B0: 38        736           SEC             
A5B1: 8A        737           TXA             
A5B2: E9 02     738           SBC  #2         
A5B4: 85 3C     739           STA  WORK       
A5B6: 98        740           TYA             
A5B7: E9 00     741           SBC  #0         
A5B9: 85 3D     742           STA  WORK+1     
A5BB: A0 00     743           LDY  #0         
A5BD: B1 3C     744           LDA  (WORK),Y   
A5BF: C8        745           INY             
A5C0: AA        746           TAX             
A5C1: B1 3C     747           LDA  (WORK),Y   
A5C3: CE A7 02  748           DEC  COUNT1     
A5C6: 4C A6 A5  749           JMP  GET2       
                750  GET1     EQU  *          
A5C9: A0 01     751           LDY  #1         
A5CB: 18        752           CLC             
A5CC: B1 26     753           LDA  (P),Y      
A5CE: 65 47     754           ADC  DATA       
A5D0: 85 47     755           STA  DATA       
A5D2: C8        756           INY             
A5D3: B1 26     757           LDA  (P),Y      
A5D5: 65 48     758           ADC  DATA+1     
A5D7: 85 48     759           STA  DATA+1     
A5D9: A5 26     760           LDA  P          
A5DB: 18        761           CLC             
A5DC: 69 03     762           ADC  #3         
A5DE: 85 26     763           STA  P          
A5E0: 90 02     764           BCC  GET1:A     
A5E2: E6 27     765           INC  P+1        
                766  GET1:A   EQU  *          
A5E4: 60        767           RTS             
                768  PULTOP   EQU  *          
A5E5: A0 00     769           LDY  #0         
A5E7: B1 32     770           LDA  (T),Y      
A5E9: 85 04     771           STA  REG        
A5EB: C8        772           INY             
A5EC: B1 32     773           LDA  (T),Y      
A5EE: 85 05     774           STA  REG+1      
A5F0: C8        775           INY             
A5F1: B1 32     776           LDA  (T),Y      
A5F3: 85 58     777           STA  REGB       
A5F5: A5 32     778           LDA  T          
A5F7: 18        779           CLC             
A5F8: 69 03     780           ADC  #3         
A5FA: 85 32     781           STA  T          
A5FC: 90 02     782           BCC  PUL:END    
A5FE: E6 33     783           INC  T+1        
                784  PUL:END  EQU  *          
A600: A5 04     785           LDA  REG        
A602: A6 05     786           LDX  REG+1      
A604: A4 58     787           LDY  REGB       
A606: 60        788           RTS             
A607: 20 E5 A5  789  PULBOTH  JSR  PULTOP     ; PULLS BOTH OF THEM
                790  PULTOP2  EQU  *          
A60A: A0 00     791           LDY  #0         
A60C: B1 32     792           LDA  (T),Y      
A60E: 85 06     793           STA  REG2       
A610: C8        794           INY             
A611: B1 32     795           LDA  (T),Y      
A613: 85 07     796           STA  REG2+1     
A615: C8        797           INY             
A616: B1 32     798           LDA  (T),Y      
A618: 85 59     799           STA  REG2B      
A61A: A5 32     800           LDA  T          
A61C: 18        801           CLC             
A61D: 69 03     802           ADC  #3         
A61F: 85 32     803           STA  T          
A621: 90 02     804           BCC  PUL2:END   
A623: E6 33     805           INC  T+1        
                806  PUL2:END EQU  *          
A625: A5 06     807           LDA  REG2       
A627: A6 07     808           LDX  REG2+1     
A629: A4 59     809           LDY  REG2B      
A62B: 60        810           RTS             
                811  PSHTOP   EQU  *          
A62C: 38        812           SEC             
A62D: A5 32     813           LDA  T          
A62F: E9 03     814           SBC  #3         
A631: 85 32     815           STA  T          
A633: B0 02     816           BCS  PSH1       
A635: C6 33     817           DEC  T+1        
                818  PSH1     EQU  *          
A637: A0 00     819           LDY  #0         
A639: A5 04     820           LDA  REG        
A63B: 91 32     821           STA  (T),Y      
A63D: C8        822           INY             
A63E: A5 05     823           LDA  REG+1      
A640: 91 32     824           STA  (T),Y      
A642: C8        825           INY             
A643: A5 58     826           LDA  REGB       
A645: 91 32     827           STA  (T),Y      
A647: 60        828           RTS             
                829  GETLIT   EQU  *          
A648: A0 00     830           LDY  #0         
A64A: B1 26     831           LDA  (P),Y      
A64C: 85 04     832           STA  REG        
A64E: C8        833           INY             
A64F: B1 26     834           LDA  (P),Y      
A651: 85 05     835           STA  REG+1      
A653: A5 26     836           LDA  P          
A655: 18        837           CLC             
A656: 69 02     838           ADC  #2         
A658: 85 26     839           STA  P          
A65A: 90 02     840           BCC  GET:END    
A65C: E6 27     841           INC  P+1        
A65E: 60        842  GET:END  RTS             
                843  *
                844  *
A65F: 20 48 A6  845  LIT      JSR  GETLIT     
A662: 88        846           DEY             
A663: B1 26     847           LDA  (P),Y      
A665: 85 58     848           STA  REGB       
A667: E6 26     849           INC  P          
A669: D0 02     850           BNE  LIT1       
A66B: E6 27     851           INC  P+1        
                852  LIT1     EQU  *          
A66D: 4C 7F A4  853           JMP  MAINP      
                854  *
A670: 20 E5 A5  855  NEG      JSR  PULTOP     
A673: 38        856           SEC             
A674: A9 00     857           LDA  #0         
A676: E5 04     858           SBC  REG        
A678: 85 04     859           STA  REG        
A67A: A9 00     860           LDA  #0         
A67C: E5 05     861           SBC  REG+1      
A67E: 85 05     862           STA  REG+1      
A680: A9 00     863           LDA  #0         
A682: E5 58     864           SBC  REGB       
A684: 85 58     865           STA  REGB       
A686: 4C 7F A4  866           JMP  MAINP      
                867  *
                868  *
A689: 20 07 A6  869  ADD      JSR  PULBOTH    
A68C: 18        870           CLC             
A68D: 65 04     871           ADC  REG        
A68F: 85 04     872           STA  REG        
A691: 8A        873           TXA             
A692: 65 05     874           ADC  REG+1      
A694: 85 05     875           STA  REG+1      
A696: 98        876           TYA             
A697: 65 58     877           ADC  REGB       
A699: 85 58     878           STA  REGB       
A69B: 4C 7F A4  879           JMP  MAINP      
                880  *
A69E: 20 F1 AD  881  SUB      JSR  SUBSTK     
A6A1: 4C 7F A4  882           JMP  MAINP      
                883  *
                884  MUL      EQU  *          
A6A4: 20 59 AD  885           JSR  FNDSGN     
A6A7: A2 18     886           LDX  #24        
A6A9: 0E D6 02  887  MUL5     ASL  RES        
A6AC: 2E D7 02  888           ROL  RES+1      
A6AF: 2E D8 02  889           ROL  RES+2      
A6B2: 0E DC 02  890           ASL  DVDN       
A6B5: 2E DD 02  891           ROL  DVDN+1     
A6B8: 2E DE 02  892           ROL  DVDN+2     
A6BB: 90 1C     893           BCC  MUL6       
A6BD: 18        894           CLC             
A6BE: AD D9 02  895           LDA  MCAND      
A6C1: 6D D6 02  896           ADC  RES        
A6C4: 8D D6 02  897           STA  RES        
A6C7: AD DA 02  898           LDA  MCAND+1    
A6CA: 6D D7 02  899           ADC  RES+1      
A6CD: 8D D7 02  900           STA  RES+1      
A6D0: AD DB 02  901           LDA  MCAND+2    
A6D3: 6D D8 02  902           ADC  RES+2      
A6D6: 8D D8 02  903           STA  RES+2      
A6D9: CA        904  MUL6     DEX             
A6DA: D0 CD     905           BNE  MUL5       
A6DC: 4C A5 AD  906           JMP  FIXSGN     
                907  *
                908  CHK:TOP  EQU  *          
A6DF: 48        909           PHA             ; limit
A6E0: 20 E5 A5  910           JSR  PULTOP     
A6E3: C6 04     911           DEC  REG        ; make zero relative
A6E5: A5 05     912           LDA  REG+1      
A6E7: 05 58     913           ORA  REGB       
A6E9: D0 08     914           BNE  CHK:ERR    
A6EB: 68        915           PLA             
A6EC: C5 04     916           CMP  REG        
A6EE: 90 03     917           BLT  CHK:ERR    ; too big
A6F0: A5 04     918           LDA  REG        
A6F2: 60        919           RTS             ; ok
                920  *
                921  CHK:ERR  EQU  *          
A6F3: A9 FA     922           LDA  #CHK:MG    
A6F5: A2 A6     923           LDX  #>CHK:MG   
A6F7: 4C C7 A4  924           JMP  NOTIM1     
                925  *
A6FA: B6 D9     926  CHK:MG   DFB  $B6,$D9    
A6FC: 20 49 4E  927           ASC  ' IN FUNCTION CALL',0D 
A6FF: 20 46 55 4E 43 54 49 4F 
A707: 4E 20 43 41 4C 4C 0D 
                928  *
                929  *
                930  MVE:SPRT EQU  *          
A70E: 20 E5 A5  931           JSR  PULTOP     
A711: 8D C2 02  932           STA  YPOS       
A714: 20 E5 A5  933           JSR  PULTOP     
A717: 8D C0 02  934           STA  XPOSL      
A71A: 8A        935           TXA             
A71B: 29 01     936           AND  #1         
A71D: 8D C1 02  937           STA  XPOSH      
A720: A9 07     938           LDA  #7         
A722: 20 DF A6  939           JSR  CHK:TOP    
A725: AA        940           TAX             ; sprite number
A726: A9 00     941           LDA  #0         
A728: 9D 98 CF  942           STA  S:ACTIVE,X ; non-active now
A72B: AD C1 02  943           LDA  XPOSH      
A72E: F0 03     944           BEQ  MVE:1      
A730: BD 9E A3  945           LDA  MASKS,X    
A733: 85 5C     946  MVE:1    STA  TEMP       
A735: BD A6 A3  947           LDA  XMASKS,X   
A738: 2D 10 D0  948           AND  VIC+$10    
A73B: 05 5C     949           ORA  TEMP       ; set high order x bit on/off
A73D: 8D 10 D0  950           STA  VIC+$10    
A740: 8A        951           TXA             
A741: 0A        952           ASL             
A742: AA        953           TAX             
A743: AD C0 02  954           LDA  XPOSL      
A746: 9D 00 D0  955           STA  VIC,X      ; low order 8 bits of position
A749: AD C2 02  956           LDA  YPOS       
A74C: 9D 01 D0  957           STA  VIC+1,X    ; Y co-ord
A74F: 4C 82 A4  958           JMP  MAIN       
                959  *
                960  INVALID  EQU  *          
A752: A5 6C     961           LDA  DOS:FLG    
A754: 4C DE AD  962           JMP  TRUE2      
                963  *
                964  SP:COLL  EQU  *          
A757: AD 1E D0  965           LDA  VIC+30     
A75A: 4C DE AD  966           JMP  TRUE2      
                967  *
                968  BK:COLL  EQU  *          
A75D: AD 1F D0  969           LDA  VIC+31     
A760: 4C DE AD  970           JMP  TRUE2      
                971  *
                972  CURSORX  EQU  *          
A763: 38        973           SEC             
A764: 20 F0 FF  974           JSR  PLOT       
A767: C8        975           INY             
A768: 98        976           TYA             
A769: 4C DE AD  977           JMP  TRUE2      
                978  *
                979  CURSORY  EQU  *          
A76C: 38        980           SEC             
A76D: 20 F0 FF  981           JSR  PLOT       
A770: E8        982           INX             
A771: 8A        983           TXA             
A772: 4C DE AD  984           JMP  TRUE2      
                985  * 
                986  CLOCK    EQU  *          
A775: A9 03     987           LDA  #3         
A777: 20 DF A6  988           JSR  CHK:TOP    
A77A: AA        989           TAX             
A77B: BD 08 DD  990           LDA  CIA2+8,X   ; 1 = 10ths, 2 = secs etc.
A77E: 85 5D     991           STA  TEMP+1     
A780: 29 7F     992           AND  #$7F       
A782: 48        993           PHA             
A783: 4A        994           LSR             
A784: 4A        995           LSR             
A785: 4A        996           LSR             
A786: 4A        997           LSR             
A787: 0A        998           ASL             
A788: 85 5C     999           STA  TEMP       ; times 2
A78A: 0A        1000          ASL             
A78B: 0A        1001          ASL             ; times 8
A78C: 65 5C     1002          ADC  TEMP       ; times 10
A78E: 85 5C     1003          STA  TEMP       
A790: 68        1004          PLA             
A791: 29 0F     1005          AND  #$0F       
A793: 18        1006          CLC             
A794: 65 5C     1007          ADC  TEMP       
A796: E0 03     1008          CPX  #3         ; asking for hours, oh newt?
A798: D0 0D     1009          BNE  CLOCK:2    ; forget it then
A79A: C9 0C     1010          CMP  #12        ; 12 o'clock?
A79C: D0 02     1011          BNE  CLOCK:3    ; no
A79E: A9 00     1012          LDA  #0         ; make 12=0 so output looks right 
A7A0: A4 5D     1013 CLOCK:3  LDY  TEMP+1     ; PM?
A7A2: 10 03     1014          BPL  CLOCK:2    
A7A4: 18        1015          CLC             
A7A5: 69 0C     1016          ADC  #12        
                1017 CLOCK:2  EQU  *          
A7A7: 4C DE AD  1018          JMP  TRUE2      ; answer
                1019 *
                1020 PADL:RD  EQU  *          
A7AA: 78        1021          SEI             
A7AB: AD 02 DC  1022          LDA  CIA1+2     ; save ddr register
A7AE: 48        1023          PHA             
A7AF: A9 C0     1024          LDA  #$C0       
A7B1: 8D 02 DC  1025          STA  CIA1+2     ; set porta for read
A7B4: 8A        1026          TXA             ; which paddle to read
A7B5: 8D 00 DC  1027          STA  CIA1       
A7B8: A0 81     1028          LDY  #$81       ; wait a while 
                1029 PDLRD:2  EQU  *          
A7BA: EA        1030          NOP             
A7BB: 88        1031          DEY             
A7BC: D0 FC     1032          BNE  PDLRD:2    
A7BE: AD 19 D4  1033          LDA  SID+25     ; x value
A7C1: 85 04     1034          STA  REG        
A7C3: AD 1A D4  1035          LDA  SID+26     
A7C6: 85 05     1036          STA  REG+1      
A7C8: 4C 06 A8  1037          JMP  JOY:RD1    
                1038 *
                1039 WAIT     EQU  *          
A7CB: 20 E5 A5  1040          JSR  PULTOP     ; raster line
A7CE: AD 11 D0  1041 WAIT:DLY LDA  VIC+$11    ; msb bit of raster
A7D1: 29 80     1042          AND  #$80       
A7D3: C5 05     1043          CMP  REG+1      
A7D5: 90 F7     1044          BLT  WAIT:DLY   ; not yet
A7D7: AD 12 D0  1045          LDA  VIC+$12    ; other bits
A7DA: C5 04     1046          CMP  REG        
A7DC: 90 F0     1047          BLT  WAIT:DLY   ; too low
A7DE: 4C 82 A4  1048          JMP  MAIN       
                1049 *
                1050 PADDLE   EQU  *          
A7E1: A9 01     1051          LDA  #1         
A7E3: 20 DF A6  1052          JSR  CHK:TOP    
A7E6: D0 08     1053          BNE  PADDLE2    
                1054 *
                1055 PADDLE1  EQU  *          
A7E8: A2 40     1056          LDX  #$40       
                1057 PADL2:A  EQU  *          
A7EA: 20 AA A7  1058          JSR  PADL:RD    
A7ED: 4C 7F A4  1059          JMP  MAINP      
                1060 *
                1061 PADDLE2  EQU  *          
A7F0: A2 80     1062          LDX  #$80       
A7F2: D0 F6     1063          BNE  PADL2:A    
                1064 *
                1065 *
A7F4: 78        1066 JOY:RD   SEI             
A7F5: B9 02 DC  1067          LDA  CIA1+2,Y   
A7F8: 48        1068          PHA             
A7F9: A9 00     1069          LDA  #0         
A7FB: 99 02 DC  1070          STA  CIA1+2,Y   ; DDR 
A7FE: B9 00 DC  1071          LDA  CIA1,Y     ; read joystick 
A801: 29 1F     1072          AND  #$1F       
A803: 49 1F     1073          EOR  #$1F       ; reverse
A805: AA        1074          TAX             
A806: 68        1075 JOY:RD1  PLA             
A807: 99 02 DC  1076          STA  CIA1+2,Y   
A80A: A9 7F     1077          LDA  #$7F       
A80C: 8D 00 DC  1078          STA  CIA1       
A80F: 8A        1079          TXA             
A810: 58        1080          CLI             
A811: 60        1081          RTS             
                1082 *
                1083 JOY      EQU  *          
A812: A9 01     1084          LDA  #1         
A814: 20 DF A6  1085          JSR  CHK:TOP    
A817: D0 08     1086          BNE  JOY2       
                1087 *
                1088 JOY1     EQU  *          
A819: A0 01     1089          LDY  #1         
                1090 JOY1:A   EQU  *          
A81B: 20 F4 A7  1091          JSR  JOY:RD     
A81E: 4C DE AD  1092          JMP  TRUE2      
                1093 *
                1094 JOY2     EQU  *          
A821: A0 00     1095          LDY  #0         
A823: F0 F6     1096          BEQ  JOY1:A     
                1097 *
                1098 OSC3     EQU  *          
A825: AD 1B D4  1099          LDA  SID+27     
A828: 4C DE AD  1100          JMP  TRUE2      
                1101 *
                1102 VOICE3   EQU  *          
A82B: AD 1C D4  1103          LDA  SID+28     
A82E: 4C DE AD  1104          JMP  TRUE2      
                1105 *
                1106 SCROLLX  EQU  *          
A831: AD 16 D0  1107          LDA  VIC+$16    
A834: 29 07     1108 SCROLLX1 AND  #7         
A836: 4C DE AD  1109          JMP  TRUE2      
                1110 *
                1111 SCROLLY  EQU  *          
A839: AD 11 D0  1112          LDA  VIC+$11    
A83C: 4C 34 A8  1113          JMP  SCROLLX1   
                1114 * 
A83F: AA        1115 ADDIT    TAX             
A840: F0 08     1116          BEQ  ADDIT:9    
A842: A9 00     1117          LDA  #0         
A844: 18        1118          CLC             
A845: 69 01     1119 ADDIT:1  ADC  #1         
A847: CA        1120          DEX             
A848: D0 FB     1121          BNE  ADDIT:1    
A84A: 60        1122 ADDIT:9  RTS             
                1123 *
                1124 SET:CLK  EQU  *          
A84B: AD 0E DD  1125          LDA  CIA2+14    
A84E: 09 80     1126          ORA  #$80       
A850: 8D 0E DD  1127          STA  CIA2+14    
A853: AD 0F DD  1128          LDA  CIA2+15    
A856: 29 7F     1129          AND  #$7F       
A858: 8D 0F DD  1130          STA  CIA2+15    
A85B: 20 E5 A5  1131          JSR  PULTOP     
A85E: 48        1132          PHA             
A85F: 20 E5 A5  1133          JSR  PULTOP     
A862: 48        1134          PHA             
A863: 20 E5 A5  1135          JSR  PULTOP     
A866: 48        1136          PHA             
A867: 20 E5 A5  1137          JSR  PULTOP     
A86A: A2 00     1138          LDX  #0         
A86C: C9 0C     1139          CMP  #12        
A86E: 90 05     1140          BLT  CLK:AM     
A870: A2 80     1141          LDX  #$80       
A872: 38        1142          SEC             
A873: E9 0C     1143          SBC  #12        ; back to range 0 to 11
A875: 8E BB 02  1144 CLK:AM   STX  CNTR       
A878: F8        1145          SED             
A879: 20 3F A8  1146          JSR  ADDIT      
A87C: 0D BB 02  1147          ORA  CNTR       
A87F: 8D 0B DD  1148          STA  CIA2+11    
A882: 68        1149          PLA             
A883: 20 3F A8  1150          JSR  ADDIT      
A886: 8D 0A DD  1151          STA  CIA2+10    
A889: 68        1152          PLA             
A88A: 20 3F A8  1153          JSR  ADDIT      
A88D: 8D 09 DD  1154          STA  CIA2+9     
A890: 68        1155          PLA             
A891: 20 3F A8  1156          JSR  ADDIT      
A894: 8D 08 DD  1157          STA  CIA2+8     
A897: D8        1158          CLD             
A898: 4C 82 A4  1159          JMP  MAIN       
                1160 *
                1161 SCROLL   EQU  *          
A89B: 20 E5 A5  1162          JSR  PULTOP     
A89E: 29 07     1163          AND  #7         ; y co-ord
A8A0: 8D C0 02  1164          STA  FNC:VAL    
A8A3: AD 11 D0  1165          LDA  VIC+$11    
A8A6: 29 F8     1166          AND  #$F8       
A8A8: 0D C0 02  1167          ORA  FNC:VAL    
A8AB: 8D 11 D0  1168          STA  VIC+$11    
A8AE: 20 E5 A5  1169          JSR  PULTOP     
A8B1: 29 07     1170          AND  #7         ; x co-ord
A8B3: 8D C0 02  1171          STA  FNC:VAL    
A8B6: AD 16 D0  1172          LDA  VIC+$16    
A8B9: 29 F8     1173          AND  #$F8       
A8BB: 0D C0 02  1174          ORA  FNC:VAL    
A8BE: 8D 16 D0  1175          STA  VIC+$16    
A8C1: 4C 82 A4  1176          JMP  MAIN       
                1177 *
                1178 GET:BNK  EQU  *          
A8C4: AD 02 DD  1179          LDA  CIA2+2     
A8C7: 29 FC     1180          AND  #$FC       
A8C9: 8D 02 DD  1181          STA  CIA2+2     ; set data direction to read
A8CC: AD 00 DD  1182          LDA  CIA2       
A8CF: 29 03     1183          AND  #3         ; video bank
A8D1: 49 FF     1184          EOR  #$FF       ; make zero relative
A8D3: 0A        1185          ASL             
A8D4: 0A        1186          ASL             
A8D5: 0A        1187          ASL             
A8D6: 0A        1188          ASL             
A8D7: 0A        1189          ASL             
A8D8: 0A        1190          ASL             
A8D9: 85 5D     1191          STA  TEMP+1     
A8DB: 60        1192          RTS             
                1193 *
                1194 CLEAR    EQU  *          
A8DC: 20 E5 A5  1195          JSR  PULTOP     
A8DF: 29 0F     1196          AND  #$0F       
A8E1: 8D C0 02  1197          STA  FNC:VAL    ; colour
A8E4: 20 E5 A5  1198          JSR  PULTOP     
A8E7: 0A        1199          ASL             
A8E8: 0A        1200          ASL             
A8E9: 0A        1201          ASL             
A8EA: 0A        1202          ASL             
A8EB: 0D C0 02  1203          ORA  FNC:VAL    
A8EE: 8D C0 02  1204          STA  FNC:VAL    
A8F1: 20 C4 A8  1205          JSR  GET:BNK    
A8F4: AD 18 D0  1206          LDA  VIC+$18    ; character base
A8F7: 29 0E     1207          AND  #$0E       
A8F9: 0A        1208          ASL             
A8FA: 0A        1209          ASL             
A8FB: 05 5D     1210          ORA  TEMP+1     
A8FD: 85 5D     1211          STA  TEMP+1     
A8FF: C9 04     1212          CMP  #$04       
A901: B0 03     1213          BGE  CLR:2      
A903: 4C F3 A6  1214 CLR:ERR  JMP  CHK:ERR    ; too low
A906: A9 00     1215 CLR:2    LDA  #0         
A908: 85 5C     1216          STA  TEMP       
A90A: AD 11 D0  1217          LDA  VIC+17     ; mode
A90D: 29 20     1218          AND  #$20       
A90F: F0 F2     1219          BEQ  CLR:ERR    ; not bit map
A911: A9 40     1220          LDA  #8000      ; hi-res (bit map)
A913: 85 04     1221          STA  REG        
A915: A9 1F     1222          LDA  #>8000     
A917: 85 05     1223          STA  REG+1      
A919: A0 00     1224          LDY  #0         
A91B: 98        1225          TYA             
A91C: 20 4A A9  1226          JSR  CLR:LOOP   ; clear character memory
A91F: 20 C4 A8  1227          JSR  GET:BNK    
A922: AD 18 D0  1228          LDA  VIC+$18    ; now do screen memory
A925: 29 F0     1229          AND  #$F0       
A927: 4A        1230          LSR             
A928: 4A        1231          LSR             
A929: 05 5D     1232          ORA  TEMP+1     
A92B: 85 5D     1233          STA  TEMP+1     
A92D: C9 04     1234          CMP  #$04       
A92F: B0 03     1235          BGE  CLR:3      
A931: 4C F3 A6  1236          JMP  CHK:ERR    ; too low
                1237 CLR:3    EQU  *          
A934: A9 00     1238          LDA  #0         
A936: A8        1239          TAY             
A937: 85 5C     1240          STA  TEMP       
A939: A9 E8     1241          LDA  #1000      
A93B: 85 04     1242          STA  REG        
A93D: A9 03     1243          LDA  #>1000     
A93F: 85 05     1244          STA  REG+1      
A941: AD C0 02  1245          LDA  FNC:VAL    ; colour
A944: 20 4A A9  1246          JSR  CLR:LOOP   ; clear screen memory
A947: 4C 82 A4  1247          JMP  MAIN       
                1248 *
A94A: 91 5C     1249 CLR:LOOP STA  (TEMP),Y   
A94C: E6 5C     1250          INC  TEMP       
A94E: D0 02     1251          BNE  CLR:1      
A950: E6 5D     1252          INC  TEMP+1     
                1253 CLR:1    EQU  *          
A952: C6 04     1254          DEC  REG        
A954: A6 04     1255          LDX  REG        
A956: E0 FF     1256          CPX  #$FF       
A958: D0 F0     1257          BNE  CLR:LOOP   
A95A: C6 05     1258          DEC  REG+1      
A95C: 10 EC     1259          BPL  CLR:LOOP   
A95E: 60        1260          RTS             
                1261 *
                1262 GETKEY   EQU  *          
A95F: 20 E4 FF  1263          JSR  GETIN      
A962: 4C DE AD  1264          JMP  TRUE2      
                1265 *
                1266 *
                1267 SPRITE   EQU  *          
A965: 20 E5 A5  1268          JSR  PULTOP     
A968: 8D C0 02  1269          STA  FNC:VAL    
A96B: A9 06     1270          LDA  #6         
A96D: 20 DF A6  1271          JSR  CHK:TOP    ; FUNCTION
A970: 85 4B     1272          STA  FUNCTION   
A972: A9 07     1273          LDA  #7         
A974: 20 DF A6  1274          JSR  CHK:TOP    
A977: 85 4C     1275          STA  SPRITENO   
A979: A5 4B     1276          LDA  FUNCTION   
A97B: F0 2C     1277          BEQ  SPRT:COL   ; set colour
A97D: C9 01     1278          CMP  #1         
A97F: F0 35     1279          BEQ  SPRT:PNT   ; point sprite
A981: 0A        1280          ASL             
A982: AA        1281          TAX             ; offset into table
A983: BD D6 A9  1282          LDA  SPRT:TB-4,X 
A986: 85 5C     1283          STA  TEMP       
A988: BD D7 A9  1284          LDA  SPRT:TB-3,X 
A98B: 85 5D     1285          STA  TEMP+1     
A98D: A6 4C     1286          LDX  SPRITENO   
A98F: A0 00     1287          LDY  #0         
A991: AD C0 02  1288          LDA  FNC:VAL    
A994: 29 01     1289          AND  #1         
A996: F0 03     1290          BEQ  SPRT:1     
A998: BD 9E A3  1291          LDA  MASKS,X    
A99B: 8D E0 02  1292 SPRT:1   STA  TEMP1      
A99E: BD A6 A3  1293          LDA  XMASKS,X   
A9A1: 31 5C     1294          AND  (TEMP),Y   
A9A3: 0D E0 02  1295          ORA  TEMP1      ; set bit
A9A6: 4C 47 AA  1296          JMP  GR:4       
                1297 *
                1298 SPRT:COL EQU  *          
A9A9: A6 4C     1299          LDX  SPRITENO   
A9AB: AD C0 02  1300          LDA  FNC:VAL    
A9AE: 29 0F     1301          AND  #15        
A9B0: 9D 27 D0  1302          STA  VIC+$27,X  ; set colour
A9B3: 4C 82 A4  1303          JMP  MAIN       
                1304 *
                1305 SPRT:PNT EQU  *          
A9B6: A9 00     1306          LDA  #0         
A9B8: A4 4C     1307          LDY  SPRITENO   
A9BA: 99 D8 CE  1308          STA  S:ANIMCT,Y 
                1309 S:PNT2   EQU  *          
A9BD: 20 C4 A8  1310          JSR  GET:BNK    
A9C0: AD 18 D0  1311          LDA  VIC+$18    
A9C3: 29 F0     1312          AND  #$F0       ; video base
A9C5: 4A        1313          LSR             
A9C6: 4A        1314          LSR             
A9C7: 18        1315          CLC             
A9C8: 69 03     1316          ADC  #3         
A9CA: 65 5D     1317          ADC  TEMP+1     ; add bank
A9CC: 85 5D     1318          STA  TEMP+1     
A9CE: A9 F8     1319          LDA  #$F8       
A9D0: 85 5C     1320          STA  TEMP       ; sprite pointers
A9D2: A4 4C     1321          LDY  SPRITENO   
A9D4: AD C0 02  1322          LDA  FNC:VAL    
A9D7: 4C 47 AA  1323          JMP  GR:4       ; point sprite pointer
                1324 *
                1325 SPRT:TB  EQU  *          
A9DA: 1C D0     1326          DA   VIC+$1C    
A9DC: 1D D0     1327          DA   VIC+$1D    
A9DE: 17 D0     1328          DA   VIC+$17    
A9E0: 1B D0     1329          DA   VIC+$1B    
A9E2: 15 D0     1330          DA   VIC+$15    
                1331 *
                1332 W:BASE   EQU  *          
A9E4: 20 C4 A8  1333          JSR  GET:BNK    
A9E7: AD C0 02  1334          LDA  FNC:VAL    
A9EA: 29 0F     1335          AND  #$0F       
A9EC: 0A        1336          ASL             
A9ED: 0A        1337          ASL             ; times 4
A9EE: 05 5D     1338          ORA  TEMP+1     ; bank
A9F0: 8D 88 02  1339          STA  HIBASE     
A9F3: 4C 82 A4  1340          JMP  MAIN       
                1341 *
                1342 GRAPHICS EQU  *          
A9F6: 20 E5 A5  1343          JSR  PULTOP     
A9F9: 8D C0 02  1344          STA  FNC:VAL    
A9FC: A9 11     1345          LDA  #17        
A9FE: 20 DF A6  1346          JSR  CHK:TOP    
AA01: 85 4B     1347          STA  FUNCTION   
AA03: C9 11     1348          CMP  #17        
AA05: F0 DD     1349          BEQ  W:BASE     ; write base
AA07: C9 06     1350          CMP  #6         
AA09: D0 12     1351          BNE  GR:3       
AA0B: AD 02 DD  1352          LDA  CIA2+2     
AA0E: 09 03     1353          ORA  #3         ; set data direction register
AA10: 8D 02 DD  1354          STA  CIA2+2     
AA13: AD C0 02  1355          LDA  FNC:VAL    
AA16: 49 FF     1356          EOR  #$FF       
AA18: 8D C0 02  1357          STA  FNC:VAL    
AA1B: A5 4B     1358          LDA  FUNCTION   
AA1D: 0A        1359 GR:3     ASL             
AA1E: 0A        1360          ASL             
AA1F: 18        1361          CLC             
AA20: 65 4B     1362          ADC  FUNCTION   ; times 5
AA22: AA        1363          TAX             
AA23: BD 4C AA  1364          LDA  G:TABLE,X  ; address to patch
AA26: 85 5C     1365          STA  TEMP       
AA28: BD 4D AA  1366          LDA  G:TABLE+1,X 
AA2B: 85 5D     1367          STA  TEMP+1     
AA2D: BD 4E AA  1368          LDA  G:TABLE+2,X ; mask
AA30: 2D C0 02  1369          AND  FNC:VAL    
AA33: BC 4F AA  1370          LDY  G:TABLE+3,X ; bit to shift left
AA36: F0 04     1371          BEQ  GR:1       ; none
AA38: 0A        1372 GR:2     ASL             
AA39: 88        1373          DEY             
AA3A: D0 FC     1374          BNE  GR:2       
AA3C: 8D C0 02  1375 GR:1     STA  FNC:VAL    
AA3F: B1 5C     1376          LDA  (TEMP),Y   ; old value of location
AA41: 3D 50 AA  1377          AND  G:TABLE+4,X ; mask out required bits
AA44: 0D C0 02  1378          ORA  FNC:VAL    ; or in new bits
AA47: 91 5C     1379 GR:4     STA  (TEMP),Y   ; new value
AA49: 4C 82 A4  1380          JMP  MAIN       ; finished!
                1381 *
                1382 G:TABLE  EQU  *          
                1383 *
                1384 * graphics controls
                1385 *
AA4C: 11 D0     1386          DA   VIC+$11    ; hires
AA4E: 01 05 DF  1387          HEX  0105DF     
AA51: 16 D0     1388          DA   VIC+$16    ; multicolour
AA53: 01 04 EF  1389          HEX  0104EF     
AA56: 11 D0     1390          DA   VIC+$11    ; ext. bkgnd
AA58: 01 06 BF  1391          HEX  0106BF     
AA5B: 16 D0     1392          DA   VIC+$16    ; 40 cols
AA5D: 01 03 F7  1393          HEX  0103F7     
AA60: 11 D0     1394          DA   VIC+$11    ; 25 lines
AA62: 01 03 F7  1395          HEX  0103F7     
AA65: 11 D0     1396          DA   VIC+$11    ; blank screen
AA67: 01 04 EF  1397          HEX  0104EF     
AA6A: 00 DD     1398          DA   CIA2       ; bank select
AA6C: 03 00 FC  1399          HEX  0300FC     
AA6F: 18 D0     1400          DA   VIC+$18    ; char gen base
AA71: 07 01 F1  1401          HEX  0701F1     
AA74: 18 D0     1402          DA   VIC+$18    ; video base
AA76: 0F 04 0F  1403          HEX  0F040F     
AA79: 86 02     1404          DA   $286       ; cursor colour
AA7B: 0F 00 F0  1405          HEX  0F00F0     
AA7E: 20 D0     1406          DA   VIC+$20    ; border colour
AA80: 0F 00 F0  1407          HEX  0F00F0     
AA83: 21 D0     1408          DA   VIC+$21    ; other colours
AA85: 0F 00 F0  1409          HEX  0F00F0     
AA88: 22 D0     1410          DA   VIC+$22    
AA8A: 0F 00 F0  1411          HEX  0F00F0     
AA8D: 23 D0     1412          DA   VIC+$23    
AA8F: 0F 00 F0  1413          HEX  0F00F0     
AA92: 24 D0     1414          DA   VIC+$24    
AA94: 0F 00 F0  1415          HEX  0F00F0     
AA97: 25 D0     1416          DA   VIC+$25    
AA99: 0F 00 F0  1417          HEX  0F00F0     
AA9C: 26 D0     1418          DA   VIC+$26    
AA9E: 0F 00 F0  1419          HEX  0F00F0     
                1420 *
                1421 * voice controls
                1422 *
AAA1: 05 D4     1423          DA   SID+5      ; attack
AAA3: 0F 04 0F  1424          HEX  0F040F     
AAA6: 05 D4     1425          DA   SID+5      ; decay
AAA8: 0F 00 F0  1426          HEX  0F00F0     
AAAB: 06 D4     1427          DA   SID+6      ; sustain
AAAD: 0F 04 0F  1428          HEX  0F040F     
AAB0: 06 D4     1429          DA   SID+6      ; release
AAB2: 0F 00 F0  1430          HEX  0F00F0     
AAB5: 04 D4     1431          DA   SID+4      ; play
AAB7: 01 00 FE  1432          HEX  0100FE     
AABA: 04 D4     1433          DA   SID+4      ; sync
AABC: 01 01 FD  1434          HEX  0101FD     
AABF: 04 D4     1435          DA   SID+4      ; ring mod
AAC1: 01 02 FB  1436          HEX  0102FB     
AAC4: 04 D4     1437          DA   SID+4      ; triangle
AAC6: 01 04 EF  1438          HEX  0104EF     
AAC9: 04 D4     1439          DA   SID+4      ; sawtooth
AACB: 01 05 DF  1440          HEX  0105DF     
AACE: 04 D4     1441          DA   SID+4      ; pulse
AAD0: 01 06 BF  1442          HEX  0106BF     
AAD3: 04 D4     1443          DA   SID+4      ; noise
AAD5: 01 07 7F  1444          HEX  01077F     
AAD8: 04 D4     1445          DA   SID+4      ; test
AADA: 01 03 F7  1446          HEX  0103F7     
                1447 *
                1448 * sound controls
                1449 *
AADD: 18 D4     1450          DA   SID+24     ; volume
AADF: 0F 00 F0  1451          HEX  0F00F0     
AAE2: 17 D4     1452          DA   SID+23     ; resonance
AAE4: 0F 04 0F  1453          HEX  0F040F     
AAE7: 18 D4     1454          DA   SID+24     ; low pass
AAE9: 01 04 EF  1455          HEX  0104EF     
AAEC: 18 D4     1456          DA   SID+24     ; band pass
AAEE: 01 05 DF  1457          HEX  0105DF     
AAF1: 18 D4     1458          DA   SID+24     ; high pass
AAF3: 01 06 BF  1459          HEX  0106BF     
AAF6: 18 D4     1460          DA   SID+24     ; cutoff voice3
AAF8: 01 07 7F  1461          HEX  01077F     
                1462 *
                1463 * end of table
                1464 *
                1465 *
                1466 DEF:SPRT EQU  *          
AAFB: A9 F0     1467          LDA  #240       ; will become 60
AAFD: 85 5C     1468          STA  TEMP       
AAFF: 20 C4 A8  1469          JSR  GET:BNK    
AB02: A0 3F     1470          LDY  #63        ; get pointer off stack first 
AB04: B1 32     1471          LDA  (T),Y      
AB06: 4A        1472          LSR             
AB07: 66 5C     1473          ROR  TEMP       
AB09: 4A        1474          LSR             
AB0A: 66 5C     1475          ROR  TEMP       
AB0C: 18        1476          CLC             
AB0D: 65 5D     1477          ADC  TEMP+1     ; add in bank
AB0F: 85 5D     1478          STA  TEMP+1     
AB11: C9 04     1479          CMP  #$04       ; too low?
AB13: B0 03     1480          BGE  DEF:2      ; no
AB15: 4C F3 A6  1481          JMP  CHK:ERR    
AB18: A9 15     1482 DEF:2    LDA  #21        
AB1A: 48        1483 DEF:1    PHA             ; save counter
AB1B: 20 E5 A5  1484          JSR  PULTOP     ; get row
AB1E: A0 02     1485          LDY  #2         ; do it in reverse order 
AB20: A5 04     1486          LDA  REG        
AB22: 91 5C     1487          STA  (TEMP),Y   
AB24: 88        1488          DEY             
AB25: A5 05     1489          LDA  REG+1      
AB27: 91 5C     1490          STA  (TEMP),Y   
AB29: 88        1491          DEY             
AB2A: A5 58     1492          LDA  REGB       
AB2C: 91 5C     1493          STA  (TEMP),Y   
AB2E: C6 5C     1494          DEC  TEMP       
AB30: C6 5C     1495          DEC  TEMP       
AB32: C6 5C     1496          DEC  TEMP       ; (will not cross page boundary) 
AB34: 68        1497          PLA             
AB35: AA        1498          TAX             ; counter
AB36: CA        1499          DEX             
AB37: 8A        1500          TXA             
AB38: D0 E0     1501          BNE  DEF:1      ; more to go
AB3A: 20 E5 A5  1502          JSR  PULTOP     ; discard pointer (read earlier)
AB3D: 4C 82 A4  1503          JMP  MAIN       
                1504 *
                1505 VOICE    EQU  *          
AB40: 20 E5 A5  1506          JSR  PULTOP     
AB43: 8D C0 02  1507          STA  FNC:VAL    
AB46: 8E C1 02  1508          STX  FNC:VAL+1  
AB49: A9 0E     1509          LDA  #14        
AB4B: 20 DF A6  1510          JSR  CHK:TOP    
AB4E: 85 4B     1511          STA  FUNCTION   
AB50: A9 02     1512          LDA  #2         
AB52: 20 DF A6  1513          JSR  CHK:TOP    
AB55: 85 4D     1514          STA  VOICENO    
AB57: 8D E0 02  1515          STA  TEMP1      ; save for filter
AB5A: 0A        1516          ASL             
AB5B: 0A        1517          ASL             
AB5C: 0A        1518          ASL             ; times 8
AB5D: 38        1519          SEC             
AB5E: E5 4D     1520          SBC  VOICENO    ; times 7
AB60: 85 4D     1521          STA  VOICENO    
AB62: A5 4B     1522          LDA  FUNCTION   
AB64: F0 45     1523          BEQ  FREQ       
AB66: C9 01     1524          CMP  #1         
AB68: F0 52     1525          BEQ  WIDTH      
AB6A: C9 02     1526          CMP  #2         
AB6C: F0 61     1527          BEQ  FILTER     
AB6E: 18        1528          CLC             
AB6F: 69 0E     1529          ADC  #14        ; bypass 17 graphics entries ( minus 3 not in table )
AB71: 85 4B     1530 VC:3     STA  FUNCTION   
AB73: 0A        1531          ASL             
AB74: 0A        1532          ASL             
AB75: 18        1533          CLC             
AB76: 65 4B     1534          ADC  FUNCTION   ; times 5
AB78: AA        1535          TAX             
AB79: BD 4C AA  1536          LDA  G:TABLE,X  
AB7C: 18        1537          CLC             
AB7D: 65 4D     1538          ADC  VOICENO    ; low-order address
AB7F: 85 5C     1539          STA  TEMP       
AB81: BD 4D AA  1540          LDA  G:TABLE+1,X 
AB84: 85 5D     1541          STA  TEMP+1     
AB86: BD 4E AA  1542          LDA  G:TABLE+2,X ; mask
AB89: 2D C0 02  1543          AND  FNC:VAL    
AB8C: BC 4F AA  1544          LDY  G:TABLE+3,X ; bits to shift
AB8F: F0 04     1545          BEQ  VC:1       
AB91: 0A        1546 VC:2     ASL             
AB92: 88        1547          DEY             
AB93: D0 FC     1548          BNE  VC:2       
AB95: 8D C0 02  1549 VC:1     STA  FNC:VAL    
AB98: A4 5C     1550          LDY  TEMP       ; offset into SID image
AB9A: B9 7C CF  1551          LDA  SID:IMG,Y  ; get previous value
AB9D: 3D 50 AA  1552          AND  G:TABLE+4,X ; mask out new bits
ABA0: 0D C0 02  1553          ORA  FNC:VAL    ; new value
ABA3: 99 7C CF  1554          STA  SID:IMG,Y  ; new value
ABA6: A0 00     1555          LDY  #0         
ABA8: 4C 47 AA  1556          JMP  GR:4       ; and do SID itself
                1557 *
                1558 FREQ     EQU  *          
ABAB: A6 4D     1559          LDX  VOICENO    
ABAD: AD C0 02  1560          LDA  FNC:VAL    
ABB0: 9D 00 D4  1561          STA  SID,X      
ABB3: AD C1 02  1562          LDA  FNC:VAL+1  
ABB6: 9D 01 D4  1563          STA  SID+1,X    
ABB9: 4C 82 A4  1564          JMP  MAIN       
                1565 *
                1566 WIDTH    EQU  *          
ABBC: A6 4D     1567          LDX  VOICENO    
ABBE: AD C0 02  1568          LDA  FNC:VAL    
ABC1: 9D 02 D4  1569          STA  SID+2,X    
ABC4: AD C1 02  1570          LDA  FNC:VAL+1  
ABC7: 29 0F     1571          AND  #$F        
ABC9: 9D 03 D4  1572          STA  SID+3,X    
ABCC: 4C 82 A4  1573          JMP  MAIN       
                1574 *
                1575 FILTER   EQU  *          
ABCF: AE E0 02  1576          LDX  TEMP1      ; un-multiplied voice 
ABD2: AD C0 02  1577          LDA  FNC:VAL    
ABD5: 29 01     1578          AND  #1         
ABD7: F0 03     1579          BEQ  FILT:1     
ABD9: BD 9E A3  1580          LDA  MASKS,X    
ABDC: 85 5C     1581 FILT:1   STA  TEMP       
ABDE: BD A6 A3  1582          LDA  XMASKS,X   
ABE1: 2D 93 CF  1583          AND  SID:IMG+23 
ABE4: 05 5C     1584          ORA  TEMP       
ABE6: 8D 17 D4  1585          STA  SID+23     
ABE9: 8D 93 CF  1586          STA  SID:IMG+23 
ABEC: 4C 82 A4  1587          JMP  MAIN       
                1588 *
                1589 SOUND    EQU  *          
ABEF: 84 4D     1590          STY  VOICENO    ; not voice relative
ABF1: 20 E5 A5  1591          JSR  PULTOP     
ABF4: 8D C0 02  1592          STA  FNC:VAL    
ABF7: 8E C1 02  1593          STX  FNC:VAL+1  
ABFA: 8C C2 02  1594          STY  FNC:VAL+2  
ABFD: A9 08     1595          LDA  #8         
ABFF: 20 DF A6  1596          JSR  CHK:TOP    
AC02: F0 0E     1597          BEQ  SOUND:CL   
AC04: C9 01     1598          CMP  #1         
AC06: F0 1A     1599          BEQ  SOUND:F    
AC08: C9 02     1600          CMP  #2         
AC0A: F0 33     1601          BEQ  DELAY      
AC0C: 18        1602          CLC             
AC0D: 69 1A     1603          ADC  #26        ; bypass 17 graphics + 12 voice - 3 not in table 
AC0F: 4C 71 AB  1604          JMP  VC:3       ; handle with table
                1605 *
AC12: A0 18     1606 SOUND:CL LDY  #24        
AC14: A9 00     1607          LDA  #0         
AC16: 99 00 D4  1608 SOUND:C1 STA  SID,Y      
AC19: 99 7C CF  1609          STA  SID:IMG,Y  
AC1C: 88        1610          DEY             
AC1D: 10 F7     1611          BPL  SOUND:C1   
AC1F: 4C 82 A4  1612          JMP  MAIN       
                1613 *
AC22: AD C0 02  1614 SOUND:F  LDA  FNC:VAL    
AC25: 29 07     1615          AND  #7         
AC27: 8D 15 D4  1616          STA  SID+21     
AC2A: AD C0 02  1617          LDA  FNC:VAL    
AC2D: 4E C1 02  1618          LSR  FNC:VAL+1  
AC30: 6A        1619          ROR             
AC31: 4E C1 02  1620          LSR  FNC:VAL+1  
AC34: 6A        1621          ROR             
AC35: 4E C1 02  1622          LSR  FNC:VAL+1  
AC38: 6A        1623          ROR             
AC39: 8D 16 D4  1624          STA  SID+22     
AC3C: 4C 82 A4  1625          JMP  MAIN       
                1626 *
                1627 DELAY    EQU  *          
AC3F: AD 0E DD  1628          LDA  CIA2+14    
AC42: 29 C0     1629          AND  #$C0       
AC44: 8D 0E DD  1630          STA  CIA2+14    
AC47: A9 00     1631          LDA  #0         
AC49: 8D 0F DD  1632          STA  CIA2+15    
AC4C: AD C0 02  1633          LDA  FNC:VAL    
AC4F: 8D 06 DD  1634          STA  CIA2+6     
AC52: AD C1 02  1635          LDA  FNC:VAL+1  
AC55: 8D 07 DD  1636          STA  CIA2+7     
AC58: A9 66     1637          LDA  #$66       ; calibrated to give 100'ths of a second
AC5A: 8D 04 DD  1638          STA  CIA2+4     
AC5D: A9 26     1639          LDA  #$26       
AC5F: 8D 05 DD  1640          STA  CIA2+5     
AC62: A9 59     1641          LDA  #$59       ; one shot/ count TA 
AC64: 8D 0F DD  1642          STA  CIA2+15    ; start TB
AC67: AD 0E DD  1643          LDA  CIA2+14    
AC6A: 09 11     1644          ORA  #$11       
AC6C: 8D 0E DD  1645          STA  CIA2+14    ; start TA
AC6F: AD 0F DD  1646 DEL:WAIT LDA  CIA2+15    ; finished?
AC72: 29 01     1647          AND  #1         
AC74: D0 F9     1648          BNE  DEL:WAIT   ; nope
AC76: 4C 82 A4  1649          JMP  MAIN       
                1650 *
                1651 *
AC79: A9 28     1652 CUR      LDA  #40        
AC7B: 20 DF A6  1653          JSR  CHK:TOP    
AC7E: 48        1654 CUR1     PHA             
AC7F: A9 19     1655          LDA  #25        
AC81: 20 DF A6  1656          JSR  CHK:TOP    
AC84: AA        1657 CUR2     TAX             
AC85: 68        1658          PLA             
AC86: A8        1659          TAY             
AC87: 18        1660          CLC             
AC88: 20 F0 FF  1661          JSR  PLOT       ; SET CURSOR POSITION
AC8B: 4C 82 A4  1662          JMP  MAIN       
                1663 *
AC8E: 20 59 AD  1664 MOD      JSR  FNDSGN     
AC91: 20 BD AC  1665          JSR  DIVIDE     
AC94: AD B5 02  1666          LDA  REMAIN     
AC97: 8D D6 02  1667          STA  RES        
AC9A: AD B6 02  1668          LDA  REMAIN+1   
AC9D: 8D D7 02  1669          STA  RES+1      
ACA0: AD B7 02  1670          LDA  REMAIN+2   
ACA3: 8D D8 02  1671          STA  RES+2      
ACA6: 4C BA AC  1672          JMP  DIV14      
                1673 *
ACA9: 64 49 56  1674 DIVBY0   ASC  'dIVIDE BY',BE,0D 
ACAC: 49 44 45 20 42 59 BE 0D 
                1675 *
ACB4: 20 59 AD  1676 DIV      JSR  FNDSGN     
ACB7: 20 BD AC  1677          JSR  DIVIDE     
ACBA: 4C A5 AD  1678 DIV14    JMP  FIXSGN     
                1679 *
ACBD: AD D9 02  1680 DIVIDE   LDA  DIVISOR    
ACC0: 0D DA 02  1681          ORA  DIVISOR+1  
ACC3: 0D DB 02  1682          ORA  DIVISOR+2  
ACC6: D0 07     1683          BNE  DIV1       
ACC8: A9 A9     1684          LDA  #DIVBY0    
ACCA: A2 AC     1685          LDX  #>DIVBY0   
ACCC: 4C C7 A4  1686          JMP  NOTIM1     
                1687 *
ACCF: 20 30 AD  1688 DIV1     JSR  ZERRES     ; zero result
ACD2: 8D B5 02  1689          STA  REMAIN     
ACD5: 8D B6 02  1690          STA  REMAIN+1   
ACD8: 8D B7 02  1691          STA  REMAIN+2   
ACDB: A9 18     1692          LDA  #24        
ACDD: 8D BB 02  1693 L:5      STA  CNTR       
                1694 L:10     EQU  *          
ACE0: 0E DC 02  1695          ASL  DVDN       
ACE3: 2E DD 02  1696          ROL  DVDN+1     
ACE6: 2E DE 02  1697          ROL  DVDN+2     
ACE9: 2E B5 02  1698          ROL  REMAIN     
ACEC: 2E B6 02  1699          ROL  REMAIN+1   
ACEF: 2E B7 02  1700          ROL  REMAIN+2   
ACF2: 38        1701          SEC             
ACF3: AD B5 02  1702          LDA  REMAIN     
ACF6: ED D9 02  1703          SBC  DIVISOR    
ACF9: AA        1704          TAX             
ACFA: AD B6 02  1705          LDA  REMAIN+1   
ACFD: ED DA 02  1706          SBC  DIVISOR+1  
AD00: A8        1707          TAY             
AD01: AD B7 02  1708          LDA  REMAIN+2   
AD04: ED DB 02  1709          SBC  DIVISOR+2  
AD07: 30 0E     1710          BMI  L:20       
AD09: 8D B7 02  1711          STA  REMAIN+2   
AD0C: 98        1712          TYA             
AD0D: 8D B6 02  1713          STA  REMAIN+1   
AD10: 8A        1714          TXA             
AD11: 8D B5 02  1715          STA  REMAIN     
AD14: 38        1716          SEC             
AD15: B0 01     1717          BCS  L:30       
                1718 L:20     EQU  *          
AD17: 18        1719          CLC             
                1720 L:30     EQU  *          
AD18: 2E D6 02  1721          ROL  RES        
AD1B: 2E D7 02  1722          ROL  RES+1      
AD1E: 2E D8 02  1723          ROL  RES+2      
AD21: CE BB 02  1724          DEC  CNTR       
AD24: D0 BA     1725          BNE  L:10       
AD26: 60        1726          RTS             
                1727 *
AD27: 20 E5 A5  1728 ABS      JSR  PULTOP     
AD2A: 20 3C AD  1729          JSR  ABSREG     
AD2D: 4C 68 B0  1730          JMP  INP3       
                1731 *
                1732 *
AD30: A9 00     1733 ZERRES   LDA  #0         
AD32: 8D D6 02  1734          STA  RES        
AD35: 8D D7 02  1735          STA  RES+1      
AD38: 8D D8 02  1736          STA  RES+2      
AD3B: 60        1737          RTS             
                1738 *
AD3C: A5 58     1739 ABSREG   LDA  REGB       
AD3E: 10 12     1740          BPL  ABS1       
AD40: 38        1741          SEC             
AD41: A9 00     1742          LDA  #0         
AD43: E5 04     1743          SBC  REG        
AD45: AA        1744          TAX             
AD46: A9 00     1745          LDA  #0         
AD48: E5 05     1746          SBC  REG+1      
AD4A: A8        1747          TAY             
AD4B: A9 00     1748          LDA  #0         
AD4D: E5 58     1749          SBC  REGB       
AD4F: 4C 58 AD  1750          JMP  ABS2       
AD52: A6 04     1751 ABS1     LDX  REG        
AD54: A4 05     1752          LDY  REG+1      
AD56: A5 58     1753          LDA  REGB       
AD58: 60        1754 ABS2     RTS             
                1755 *
AD59: 20 30 AD  1756 FNDSGN   JSR  ZERRES     ; zero result 
AD5C: 20 E5 A5  1757          JSR  PULTOP     
AD5F: 20 0A A6  1758          JSR  PULTOP2    
AD62: A5 58     1759          LDA  REGB       
AD64: 29 80     1760          AND  #$80       
AD66: 8D DF 02  1761          STA  RMNDR      
AD69: A5 59     1762          LDA  REG2B      
AD6B: 29 80     1763          AND  #$80       
AD6D: 4D DF 02  1764          EOR  RMNDR      
AD70: 8D DF 02  1765          STA  RMNDR      
AD73: 20 3C AD  1766          JSR  ABSREG     
AD76: 8D DB 02  1767          STA  DIVISOR+2  
AD79: 8C DA 02  1768          STY  DIVISOR+1  
AD7C: 8E D9 02  1769          STX  DIVISOR    
AD7F: A5 59     1770          LDA  REG2B      
AD81: 10 12     1771          BPL  MUL3       
AD83: 38        1772          SEC             
AD84: A9 00     1773          LDA  #0         
AD86: E5 06     1774          SBC  REG2       
AD88: AA        1775          TAX             
AD89: A9 00     1776          LDA  #0         
AD8B: E5 07     1777          SBC  REG2+1     
AD8D: A8        1778          TAY             
AD8E: A9 00     1779          LDA  #0         
AD90: E5 59     1780          SBC  REG2B      
AD92: 4C 9B AD  1781          JMP  MUL4       
AD95: A6 06     1782 MUL3     LDX  REG2       
AD97: A4 07     1783          LDY  REG2+1     
AD99: A5 59     1784          LDA  REG2B      
AD9B: 8E DC 02  1785 MUL4     STX  DVDN       
AD9E: 8C DD 02  1786          STY  DVDN+1     
ADA1: 8D DE 02  1787          STA  DVDN+2     
ADA4: 60        1788          RTS             
                1789 *
                1790 *
ADA5: AD DF 02  1791 FIXSGN   LDA  RMNDR      
ADA8: 10 15     1792          BPL  MUL7       
ADAA: 38        1793          SEC             
ADAB: A9 00     1794          LDA  #0         
ADAD: ED D6 02  1795          SBC  RES        
ADB0: AA        1796          TAX             
ADB1: A9 00     1797          LDA  #0         
ADB3: ED D7 02  1798          SBC  RES+1      
ADB6: A8        1799          TAY             
ADB7: A9 00     1800          LDA  #0         
ADB9: ED D8 02  1801          SBC  RES+2      
ADBC: 4C C8 AD  1802          JMP  MUL8       
ADBF: AE D6 02  1803 MUL7     LDX  RES        
ADC2: AC D7 02  1804          LDY  RES+1      
ADC5: AD D8 02  1805          LDA  RES+2      
ADC8: 4C 68 B0  1806 MUL8     JMP  INP3       
                1807 *
                1808 *
                1809 *
ADCB: 20 07 A6  1810 EQL      JSR  PULBOTH    
ADCE: C5 04     1811          CMP  REG        
ADD0: D0 17     1812          BNE  FALSE      
ADD2: 8A        1813          TXA             
ADD3: C5 05     1814          CMP  REG+1      
ADD5: D0 12     1815          BNE  FALSE      
ADD7: 98        1816          TYA             
ADD8: C5 58     1817          CMP  REGB       
ADDA: D0 0D     1818          BNE  FALSE      
                1819 *
ADDC: A9 01     1820 TRUE     LDA  #1         
ADDE: 85 04     1821 TRUE2    STA  REG        
ADE0: A9 00     1822          LDA  #0         
ADE2: 85 05     1823          STA  REG+1      
ADE4: 85 58     1824 TRUE1    STA  REGB       
ADE6: 4C 7F A4  1825          JMP  MAINP      
                1826 *
ADE9: A9 00     1827 FALSE    LDA  #0         
ADEB: 85 04     1828          STA  REG        
ADED: 85 05     1829          STA  REG+1      
ADEF: F0 F3     1830          BEQ  TRUE1      
                1831 *
                1832 *
ADF1: 20 07 A6  1833 SUBSTK   JSR  PULBOTH    
ADF4: 38        1834          SEC             
ADF5: E5 04     1835          SBC  REG        
ADF7: 85 04     1836          STA  REG        
ADF9: A8        1837          TAY             
ADFA: 8A        1838          TXA             
ADFB: E5 05     1839          SBC  REG+1      
ADFD: 85 05     1840          STA  REG+1      
ADFF: AA        1841          TAX             
AE00: A5 59     1842          LDA  REG2B      
AE02: E5 58     1843          SBC  REGB       
AE04: 85 58     1844          STA  REGB       
AE06: 60        1845          RTS             
                1846 *
AE07: 20 F1 AD  1847 NEQ      JSR  SUBSTK     
AE0A: D0 D0     1848          BNE  TRUE       
AE0C: 98        1849          TYA             
AE0D: D0 CD     1850          BNE  TRUE       
AE0F: 8A        1851          TXA             
AE10: D0 CA     1852          BNE  TRUE       
AE12: F0 D5     1853          BEQ  FALSE      
                1854 *
AE14: 20 F1 AD  1855 LSS      JSR  SUBSTK     
AE17: 30 C3     1856          BMI  TRUE       
AE19: 10 CE     1857          BPL  FALSE      
                1858 *
AE1B: 20 F1 AD  1859 GTR      JSR  SUBSTK     
AE1E: 30 C9     1860          BMI  FALSE      
AE20: D0 BA     1861          BNE  TRUE       
AE22: 98        1862          TYA             
AE23: D0 B7     1863          BNE  TRUE       
AE25: 8A        1864          TXA             
AE26: D0 B4     1865          BNE  TRUE       
AE28: F0 BF     1866          BEQ  FALSE      
                1867 *
AE2A: 20 F1 AD  1868 GEQ      JSR  SUBSTK     
AE2D: 30 BA     1869          BMI  FALSE      
AE2F: 10 AB     1870          BPL  TRUE       
                1871 *
AE31: 20 F1 AD  1872 LEQ      JSR  SUBSTK     
AE34: 30 A6     1873          BMI  TRUE       
AE36: D0 B1     1874          BNE  FALSE      
AE38: 98        1875          TYA             
AE39: D0 AE     1876          BNE  FALSE      
AE3B: 8A        1877          TXA             
AE3C: D0 AB     1878          BNE  FALSE      
AE3E: F0 9C     1879          BEQ  TRUE       
                1880 *
AE40: 20 07 A6  1881 XOR      JSR  PULBOTH    
AE43: 45 04     1882          EOR  REG        
AE45: 85 04     1883          STA  REG        
AE47: 8A        1884          TXA             
AE48: 45 05     1885          EOR  REG+1      
AE4A: 85 05     1886          STA  REG+1      
AE4C: 98        1887          TYA             
AE4D: 45 58     1888          EOR  REGB       
AE4F: 4C E4 AD  1889          JMP  TRUE1      
                1890 *
AE52: 20 07 A6  1891 ORR      JSR  PULBOTH    
AE55: 05 04     1892          ORA  REG        
AE57: 85 04     1893          STA  REG        
AE59: 8A        1894          TXA             
AE5A: 05 05     1895          ORA  REG+1      
AE5C: 85 05     1896          STA  REG+1      
AE5E: 98        1897          TYA             
AE5F: 05 58     1898          ORA  REGB       
AE61: 4C E4 AD  1899          JMP  TRUE1      
                1900 *
AE64: 20 07 A6  1901 AND      JSR  PULBOTH    
AE67: 25 04     1902          AND  REG        
AE69: 85 04     1903          STA  REG        
AE6B: 8A        1904          TXA             
AE6C: 25 05     1905          AND  REG+1      
AE6E: 85 05     1906          STA  REG+1      
AE70: 98        1907          TYA             
AE71: 25 58     1908          AND  REGB       
AE73: 4C E4 AD  1909          JMP  TRUE1      
                1910 *
AE76: 20 E5 A5  1911 EOR      JSR  PULTOP     
AE79: A5 04     1912          LDA  REG        
AE7B: D0 0B     1913          BNE  EOR1       
AE7D: A5 05     1914          LDA  REG+1      
AE7F: D0 07     1915          BNE  EOR1       
AE81: A5 58     1916          LDA  REGB       
AE83: D0 03     1917          BNE  EOR1       
AE85: 4C DC AD  1918          JMP  TRUE       
AE88: 4C E9 AD  1919 EOR1     JMP  FALSE      
                1920 *
AE8B: 20 0A A6  1921 SHL      JSR  PULTOP2    
AE8E: 29 1F     1922          AND  #$1F       
AE90: 48        1923          PHA             
AE91: 20 E5 A5  1924          JSR  PULTOP     
AE94: 68        1925          PLA             
AE95: 85 06     1926          STA  REG2       
AE97: F0 24     1927          BEQ  INC1       
AE99: 06 04     1928 SHL1     ASL  REG        
AE9B: 26 05     1929          ROL  REG+1      
AE9D: 26 58     1930          ROL  REGB       
AE9F: C6 06     1931          DEC  REG2       
AEA1: D0 F6     1932          BNE  SHL1       
AEA3: F0 18     1933          BEQ  INC1       
                1934 *
AEA5: 20 0A A6  1935 SHR      JSR  PULTOP2    
AEA8: 29 1F     1936          AND  #$1F       
AEAA: 48        1937          PHA             
AEAB: 20 E5 A5  1938          JSR  PULTOP     
AEAE: 68        1939          PLA             
AEAF: 85 06     1940          STA  REG2       
AEB1: F0 0A     1941          BEQ  INC1       
AEB3: 46 58     1942 SHR1     LSR  REGB       
AEB5: 66 05     1943          ROR  REG+1      
AEB7: 66 04     1944          ROR  REG        
AEB9: C6 06     1945          DEC  REG2       
AEBB: D0 F6     1946          BNE  SHR1       
AEBD: 4C 7F A4  1947 INC1     JMP  MAINP      
                1948 *
                1949 *
AEC0: 18        1950 INC      CLC             
AEC1: B1 32     1951          LDA  (T),Y      
AEC3: 69 01     1952          ADC  #1         
AEC5: 91 32     1953          STA  (T),Y      
AEC7: C8        1954          INY             
AEC8: B1 32     1955          LDA  (T),Y      
AECA: 69 00     1956          ADC  #0         
AECC: 91 32     1957          STA  (T),Y      
AECE: C8        1958          INY             
AECF: B1 32     1959          LDA  (T),Y      
AED1: 69 00     1960          ADC  #0         
AED3: 91 32     1961 INC2     STA  (T),Y      
AED5: 4C 82 A4  1962          JMP  MAIN       
                1963 *
AED8: 38        1964 DEC      SEC             
AED9: B1 32     1965          LDA  (T),Y      
AEDB: E9 01     1966          SBC  #1         
AEDD: 91 32     1967          STA  (T),Y      
AEDF: C8        1968          INY             
AEE0: B1 32     1969          LDA  (T),Y      
AEE2: E9 00     1970          SBC  #0         
AEE4: 91 32     1971          STA  (T),Y      
AEE6: C8        1972          INY             
AEE7: B1 32     1973          LDA  (T),Y      
AEE9: E9 00     1974          SBC  #0         
AEEB: 4C D3 AE  1975          JMP  INC2       
                1976 *
AEEE: B1 32     1977 MOV      LDA  (T),Y      
AEF0: 48        1978          PHA             
AEF1: C8        1979          INY             
AEF2: B1 32     1980          LDA  (T),Y      
AEF4: 48        1981          PHA             
AEF5: C8        1982          INY             
AEF6: B1 32     1983          LDA  (T),Y      
AEF8: 48        1984          PHA             
AEF9: A5 32     1985          LDA  T          
AEFB: 38        1986          SEC             
AEFC: E9 03     1987          SBC  #3         
AEFE: 85 32     1988          STA  T          
AF00: B0 02     1989          BCS  MOV1       
AF02: C6 33     1990          DEC  T+1        
AF04: 68        1991 MOV1     PLA             
AF05: 91 32     1992          STA  (T),Y      
AF07: 88        1993          DEY             
AF08: 68        1994          PLA             
AF09: 91 32     1995          STA  (T),Y      
AF0B: 88        1996          DEY             
AF0C: 68        1997          PLA             
AF0D: 91 32     1998          STA  (T),Y      
AF0F: 4C 82 A4  1999          JMP  MAIN       
                2000 *
AF12: 20 9B A5  2001 LODC     JSR  GETADR     
AF15: A0 02     2002 LOD3     LDY  #2         
AF17: A9 00     2003 LOD3:A   LDA  #0         
AF19: 85 05     2004          STA  REG+1      
AF1B: 85 58     2005          STA  REGB       
AF1D: B1 47     2006          LDA  (DATA),Y   
AF1F: 85 04     2007          STA  REG        
AF21: 4C 7F A4  2008          JMP  MAINP      
                2009 *
AF24: 20 9B A5  2010 LOD      JSR  GETADR     
AF27: A0 00     2011 LOD2     LDY  #0         
AF29: B1 47     2012          LDA  (DATA),Y   
AF2B: 85 04     2013          STA  REG        
AF2D: C8        2014          INY             
AF2E: B1 47     2015          LDA  (DATA),Y   
AF30: 85 05     2016          STA  REG+1      
AF32: C8        2017          INY             
AF33: B1 47     2018          LDA  (DATA),Y   
AF35: 4C E4 AD  2019          JMP  TRUE1      
                2020 *
AF38: 20 E5 A5  2021 LDAC     JSR  PULTOP     
AF3B: 85 47     2022          STA  DATA       
AF3D: 86 48     2023          STX  DATA+1     
AF3F: A0 00     2024          LDY  #0         
AF41: F0 D4     2025          BEQ  LOD3:A     
                2026 *
AF43: 20 E5 A5  2027 LDA      JSR  PULTOP     
AF46: 85 47     2028          STA  DATA       
AF48: 86 48     2029          STX  DATA+1     
AF4A: 4C 27 AF  2030          JMP  LOD2       
                2031 *
                2032 GETIDC   EQU  *          
AF4D: 20 0A A6  2033          JSR  PULTOP2    
AF50: 20 9B A5  2034          JSR  GETADR     
AF53: 4C 6A AF  2035          JMP  GETID2     
                2036 *
                2037 GETIDX   EQU  *          
AF56: 20 0A A6  2038          JSR  PULTOP2    
AF59: 06 06     2039          ASL  REG2       
AF5B: 26 07     2040          ROL  REG2+1     
AF5D: 18        2041          CLC             
AF5E: 65 06     2042          ADC  REG2       
AF60: 85 06     2043          STA  REG2       
AF62: 8A        2044          TXA             
AF63: 65 07     2045          ADC  REG2+1     
AF65: 85 07     2046          STA  REG2+1     ; TIMES 3
AF67: 20 9B A5  2047          JSR  GETADR     
                2048 *
AF6A: A5 47     2049 GETID2   LDA  DATA       
AF6C: 38        2050          SEC             
AF6D: E5 06     2051          SBC  REG2       
AF6F: 85 47     2052          STA  DATA       
AF71: A5 48     2053          LDA  DATA+1     
AF73: E5 07     2054          SBC  REG2+1     
AF75: 85 48     2055          STA  DATA+1     
AF77: 60        2056          RTS             
                2057 *
AF78: 20 4D AF  2058 LDIC     JSR  GETIDC     
AF7B: 4C 15 AF  2059          JMP  LOD3       
                2060 *
AF7E: 20 56 AF  2061 LDI      JSR  GETIDX     
AF81: 4C 27 AF  2062          JMP  LOD2       
                2063 *
AF84: 20 9B A5  2064 STOC     JSR  GETADR     
AF87: 20 E5 A5  2065          JSR  PULTOP     
AF8A: A0 02     2066          LDY  #2         
AF8C: 91 47     2067 STO5     STA  (DATA),Y   
AF8E: 4C 82 A4  2068          JMP  MAIN       
                2069 *
AF91: 20 9B A5  2070 STO      JSR  GETADR     
AF94: 20 E5 A5  2071          JSR  PULTOP     
AF97: A0 00     2072 STO2     LDY  #0         
AF99: 91 47     2073          STA  (DATA),Y   
AF9B: C8        2074          INY             
AF9C: 8A        2075          TXA             
AF9D: 91 47     2076          STA  (DATA),Y   
AF9F: A5 58     2077          LDA  REGB       
AFA1: C8        2078          INY             
AFA2: D0 E8     2079          BNE  STO5       
                2080 *
AFA4: 20 07 A6  2081 STA      JSR  PULBOTH    
AFA7: A0 00     2082          LDY  #0         
AFA9: A5 04     2083          LDA  REG        
AFAB: 91 06     2084          STA  (REG2),Y   
AFAD: C8        2085          INY             
AFAE: A5 05     2086          LDA  REG+1      
AFB0: 91 06     2087          STA  (REG2),Y   
AFB2: C8        2088          INY             
AFB3: A5 58     2089          LDA  REGB       
AFB5: 91 06     2090 STA5     STA  (REG2),Y   
AFB7: 4C 82 A4  2091          JMP  MAIN       
                2092 *
AFBA: 20 E5 A5  2093 STAC     JSR  PULTOP     
AFBD: 20 0A A6  2094          JSR  PULTOP2    
AFC0: A5 04     2095          LDA  REG        
AFC2: A0 00     2096          LDY  #0         
AFC4: F0 EF     2097          BEQ  STA5       
                2098 *
AFC6: 20 E5 A5  2099 STIC     JSR  PULTOP     
AFC9: 85 5C     2100          STA  TEMP       
AFCB: 20 4D AF  2101          JSR  GETIDC     
AFCE: A5 5C     2102          LDA  TEMP       
AFD0: A0 02     2103          LDY  #2         
AFD2: D0 B8     2104          BNE  STO5       
                2105 *
AFD4: 20 E5 A5  2106 STI      JSR  PULTOP     
AFD7: 85 5C     2107          STA  TEMP       
AFD9: 86 5D     2108          STX  TEMP+1     
AFDB: 98        2109          TYA             
AFDC: 48        2110          PHA             
AFDD: 20 56 AF  2111          JSR  GETIDX     
AFE0: A0 00     2112          LDY  #0         
AFE2: A5 5C     2113          LDA  TEMP       
AFE4: 91 47     2114          STA  (DATA),Y   
AFE6: A5 5D     2115          LDA  TEMP+1     
AFE8: C8        2116          INY             
AFE9: 91 47     2117          STA  (DATA),Y   
AFEB: 68        2118          PLA             
AFEC: C8        2119          INY             
AFED: D0 9D     2120          BNE  STO5       
                2121 *
AFEF: A5 45     2122 RTN      LDA  BASE       
AFF1: 38        2123          SEC             
AFF2: E9 06     2124          SBC  #6         
AFF4: 85 3C     2125          STA  WORK       
AFF6: A5 46     2126          LDA  BASE+1     
AFF8: E9 00     2127          SBC  #0         
AFFA: 85 3D     2128          STA  WORK+1     
AFFC: A0 00     2129          LDY  #0         
AFFE: B1 3C     2130          LDA  (WORK),Y   
B000: 85 26     2131          STA  P          
B002: C8        2132          INY             
B003: B1 3C     2133          LDA  (WORK),Y   
B005: 85 27     2134          STA  P+1        
B007: A5 46     2135          LDA  BASE+1     
B009: 85 33     2136          STA  T+1        
B00B: A5 45     2137          LDA  BASE       
B00D: 85 32     2138          STA  T          
B00F: 38        2139          SEC             
B010: E9 04     2140          SBC  #4         
B012: 85 3C     2141          STA  WORK       
B014: A5 46     2142          LDA  BASE+1     
B016: E9 00     2143          SBC  #0         
B018: 85 3D     2144          STA  WORK+1     
B01A: A0 00     2145          LDY  #0         
B01C: B1 3C     2146          LDA  (WORK),Y   
B01E: 85 45     2147          STA  BASE       
B020: C8        2148          INY             
B021: B1 3C     2149          LDA  (WORK),Y   
B023: 85 46     2150          STA  BASE+1     
B025: 4C 82 A4  2151          JMP  MAIN       
                2152 *
                2153 *
                2154 *
                2155 INP      EQU  *          
B028: 84 5B     2156          STY  SIGN       
B02A: 84 6C     2157          STY  DOS:FLG    
B02C: 88        2158          DEY             
B02D: 84 49     2159          STY  RUNNING    
B02F: A0 08     2160          LDY  #8         
B031: 20 8D B3  2161          JSR  GETLN1     
B034: A9 3C     2162          LDA  #INBUF     
B036: 85 1C     2163          STA  NXTCHR     
B038: A9 03     2164          LDA  #>INBUF    
B03A: 85 1D     2165          STA  NXTCHR+1   
B03C: AD 3C 03  2166          LDA  INBUF      
B03F: 20 46 A4  2167          JSR  CHK:KBD    
B042: B0 E4     2168          BCS  INP        
B044: C9 2D     2169          CMP  #'-'       
B046: D0 07     2170          BNE  INP1       
B048: 85 5B     2171          STA  SIGN       
B04A: E6 1C     2172          INC  NXTCHR     
B04C: AD 3D 03  2173          LDA  INBUF+1    
                2174 INP1     EQU  *          
B04F: 20 22 80  2175          JSR  ISITNM     
B052: B0 1F     2176          BCS  BAD:INP    
                2177 INP:OK   EQU  *          
B054: 20 73 80  2178          JSR  GET:NUM    
B057: B0 1A     2179 INP4     BCS  BAD:INP    
B059: 20 16 80  2180          JSR  GETNEXT    ; followed by c/r?
B05C: 29 7F     2181          AND  #$7F       
B05E: C9 0D     2182          CMP  #$0D       
B060: D0 11     2183          BNE  BAD:INP    ; no
B062: A6 1E     2184          LDX  VALUE      
B064: A4 1F     2185          LDY  VALUE+1    
B066: A5 20     2186          LDA  VALUE+2    
B068: 84 05     2187 INP3     STY  REG+1      
B06A: 86 04     2188          STX  REG        
B06C: A2 0C     2189          LDX  #12        
B06E: 86 49     2190          STX  RUNNING    
B070: 4C E4 AD  2191          JMP  TRUE1      
                2192 *
B073: A9 01     2193 BAD:INP  LDA  #1         
B075: 85 6C     2194          STA  DOS:FLG    
B077: A9 00     2195          LDA  #0         
B079: AA        2196          TAX             
B07A: A8        2197          TAY             
B07B: F0 EB     2198          BEQ  INP3       
                2199 *
                2200 *
                2201 *
B07D: 20 E5 A5  2202 OUT      JSR  PULTOP     
B080: 20 34 99  2203          JSR  DSP:BIN    
B083: 4C 82 A4  2204          JMP  MAIN       
                2205 *
                2206 *
                2207 *
                2208 *
B086: 20 E5 A5  2209 OUH      JSR  PULTOP     
B089: A5 58     2210          LDA  REGB       
B08B: 20 46 80  2211          JSR  PRBYTE     
B08E: A5 05     2212          LDA  REG+1      
B090: 20 46 80  2213          JSR  PRBYTE     
B093: A5 04     2214          LDA  REG        
B095: 20 46 80  2215          JSR  PRBYTE     
B098: 4C 82 A4  2216          JMP  MAIN       
                2217 *
                2218 OUS      EQU  *          
B09B: A5 26     2219          LDA  P          
B09D: 18        2220          CLC             
B09E: 69 01     2221          ADC  #1         
B0A0: 85 3C     2222          STA  WORK       
B0A2: A5 27     2223          LDA  P+1        
B0A4: 69 00     2224          ADC  #0         
B0A6: 85 3D     2225          STA  WORK+1     
B0A8: B1 26     2226          LDA  (P),Y      
B0AA: 8D A7 02  2227          STA  COUNT1     ; NO. OF CHARS
B0AD: 18        2228          CLC             
B0AE: 69 01     2229          ADC  #1         
B0B0: 65 26     2230          ADC  P          
B0B2: 85 26     2231          STA  P          
B0B4: 90 02     2232          BCC  OUS1       
B0B6: E6 27     2233          INC  P+1        
B0B8: A5 3C     2234 OUS1     LDA  WORK       
B0BA: A6 3D     2235          LDX  WORK+1     
B0BC: AC A7 02  2236          LDY  COUNT1     
B0BF: 20 5B 80  2237          JSR  PT         
B0C2: 4C 82 A4  2238          JMP  MAIN       
                2239 *
                2240 INH      EQU  *          
B0C5: 84 5B     2241          STY  SIGN       
B0C7: 84 6C     2242          STY  DOS:FLG    
B0C9: 88        2243          DEY             
B0CA: 84 49     2244          STY  RUNNING    
B0CC: A0 06     2245          LDY  #6         
B0CE: 20 8D B3  2246          JSR  GETLN1     
B0D1: A9 03     2247          LDA  #>INBUF-1  
B0D3: 85 1D     2248          STA  NXTCHR+1   
B0D5: A9 3B     2249          LDA  #INBUF-1   
B0D7: 85 1C     2250          STA  NXTCHR     
B0D9: AD 3C 03  2251          LDA  INBUF      
B0DC: 20 46 A4  2252          JSR  CHK:KBD    
B0DF: B0 E4     2253          BCS  INH        
B0E1: 20 1C 80  2254          JSR  ISITHX     
B0E4: 90 03     2255          BCC  INH:OK     
B0E6: 4C 73 B0  2256 BAD:INP2 JMP  BAD:INP    
                2257 INH:OK   EQU  *          
B0E9: 20 76 80  2258          JSR  GET:HEX    
B0EC: 4C 57 B0  2259          JMP  INP4       
                2260 *
                2261 ABSCLL   EQU  *          
B0EF: 84 5E     2262          STY  CALL       
B0F1: 84 5F     2263          STY  CALL+1     
B0F3: 4C 00 B1  2264          JMP  CLL:A      
                2265 *
                2266 CLL      EQU  *          
B0F6: AD C5 02  2267          LDA  LASTP      
B0F9: 85 5E     2268          STA  CALL       
B0FB: AD C6 02  2269          LDA  LASTP+1    
B0FE: 85 5F     2270          STA  CALL+1     
                2271 CLL:A    EQU  *          
B100: B1 26     2272          LDA  (P),Y      
B102: 8D A7 02  2273          STA  COUNT1     
B105: C8        2274          INY             
B106: 18        2275          CLC             
B107: B1 26     2276          LDA  (P),Y      
B109: 65 5E     2277          ADC  CALL       
B10B: 85 5E     2278          STA  CALL       
B10D: C8        2279          INY             
B10E: B1 26     2280          LDA  (P),Y      
B110: 65 5F     2281          ADC  CALL+1     
B112: 85 5F     2282          STA  CALL+1     
B114: A5 26     2283          LDA  P          
B116: 18        2284          CLC             
B117: 69 03     2285          ADC  #3         
B119: 85 26     2286          STA  P          
B11B: 90 02     2287          BCC  CLL4       
B11D: E6 27     2288          INC  P+1        
                2289 CLL4     EQU  *          
B11F: A5 46     2290          LDA  BASE+1     
B121: A6 45     2291          LDX  BASE       
                2292 CLL2     EQU  *          
B123: 85 48     2293          STA  DATA+1     
B125: 86 47     2294          STX  DATA       
B127: A8        2295          TAY             
B128: AD A7 02  2296          LDA  COUNT1     
B12B: F0 19     2297          BEQ  CLL3       
B12D: 38        2298          SEC             
B12E: 8A        2299          TXA             
B12F: E9 02     2300          SBC  #2         
B131: 85 3C     2301          STA  WORK       
B133: 98        2302          TYA             
B134: E9 00     2303          SBC  #0         
B136: 85 3D     2304          STA  WORK+1     
B138: A0 00     2305          LDY  #0         
B13A: B1 3C     2306          LDA  (WORK),Y   
B13C: C8        2307          INY             
B13D: AA        2308          TAX             
B13E: B1 3C     2309          LDA  (WORK),Y   
B140: CE A7 02  2310          DEC  COUNT1     
B143: 4C 23 B1  2311          JMP  CLL2       
                2312 CLL3     EQU  *          
B146: A5 32     2313          LDA  T          
B148: 85 5C     2314          STA  TEMP       
B14A: A5 33     2315          LDA  T+1        
B14C: 85 5D     2316          STA  TEMP+1     
B14E: A5 47     2317          LDA  DATA       
B150: 85 05     2318          STA  REG+1      
B152: A5 48     2319          LDA  DATA+1     
B154: 85 58     2320          STA  REGB       
B156: A5 46     2321          LDA  BASE+1     
B158: 85 04     2322          STA  REG        
B15A: 20 2C A6  2323          JSR  PSHTOP     
B15D: A5 45     2324          LDA  BASE       
B15F: 85 58     2325          STA  REGB       
B161: A5 5C     2326          LDA  TEMP       
B163: 85 45     2327          STA  BASE       
B165: A5 5D     2328          LDA  TEMP+1     
B167: 85 46     2329          STA  BASE+1     
B169: A5 26     2330          LDA  P          
B16B: 85 04     2331          STA  REG        
B16D: A5 27     2332          LDA  P+1        
B16F: 85 05     2333          STA  REG+1      
B171: 20 2C A6  2334          JSR  PSHTOP     
B174: A5 5E     2335          LDA  CALL       
B176: 85 26     2336          STA  P          
B178: A5 5F     2337          LDA  CALL+1     
B17A: 85 27     2338          STA  P+1        
B17C: 18        2339          CLC             
B17D: A5 32     2340          LDA  T          
B17F: 69 06     2341          ADC  #6         
B181: 85 32     2342          STA  T          
B183: 90 02     2343          BCC  CLL5       
B185: E6 33     2344          INC  T+1        
                2345 CLL5     EQU  *          
B187: 4C 82 A4  2346          JMP  MAIN       
                2347 *
B18A: 20 E5 A5  2348 CLA      JSR  PULTOP     
B18D: AD B1 02  2349          LDA  CALL:P     
B190: 48        2350          PHA             
B191: AD B2 02  2351          LDA  CALL:A     
B194: AE B3 02  2352          LDX  CALL:X     
B197: AC B4 02  2353          LDY  CALL:Y     
B19A: 28        2354          PLP             
B19B: 20 AF B1  2355          JSR  CLL:JMP    
B19E: 08        2356          PHP             
B19F: 8D B2 02  2357          STA  CALL:A     
B1A2: 8E B3 02  2358          STX  CALL:X     
B1A5: 8C B4 02  2359          STY  CALL:Y     
B1A8: 68        2360          PLA             
B1A9: 8D B1 02  2361          STA  CALL:P     
B1AC: 4C 82 A4  2362          JMP  MAIN       
B1AF: 6C 04 00  2363 CLL:JMP  JMP  (REG)      
                2364 *
B1B2: 20 48 A6  2365 INT      JSR  GETLIT     
B1B5: 38        2366          SEC             
B1B6: A5 32     2367          LDA  T          
B1B8: E5 04     2368          SBC  REG        
B1BA: 85 32     2369          STA  T          
B1BC: A5 33     2370          LDA  T+1        
B1BE: E5 05     2371          SBC  REG+1      
B1C0: 85 33     2372          STA  T+1        
B1C2: C9 C0     2373          CMP  #$C0       
B1C4: 90 03     2374          BLT  INT:ERR    
B1C6: 4C 82 A4  2375          JMP  MAIN       
                2376 *
                2377 INT:ERR  EQU  *          
B1C9: A9 D0     2378          LDA  #INT:ERRM  
B1CB: A2 B1     2379          LDX  #>INT:ERRM 
B1CD: 4C C7 A4  2380          JMP  NOTIM1     
                2381 *
B1D0: C6 B1 0D  2382 INT:ERRM HEX  C6B10D     ; stack full
                2383 *
B1D3: 20 48 A6  2384 JMP      JSR  GETLIT     
B1D6: 18        2385          CLC             
B1D7: A5 04     2386          LDA  REG        
B1D9: 6D C5 02  2387          ADC  LASTP      
B1DC: 85 26     2388          STA  P          
B1DE: A5 05     2389          LDA  REG+1      
B1E0: 6D C6 02  2390          ADC  LASTP+1    
B1E3: 85 27     2391          STA  P+1        
B1E5: 4C 82 A4  2392          JMP  MAIN       
                2393 *
B1E8: 20 E5 A5  2394 JMZ      JSR  PULTOP     
B1EB: A5 04     2395          LDA  REG        
B1ED: 05 05     2396          ORA  REG+1      
B1EF: D0 02     2397          BNE  NOJUMP     
B1F1: F0 E0     2398          BEQ  JMP        
                2399 *
B1F3: 20 48 A6  2400 NOJUMP   JSR  GETLIT     
B1F6: 4C 82 A4  2401          JMP  MAIN       
                2402 *
B1F9: 20 E5 A5  2403 JM1      JSR  PULTOP     
B1FC: 05 05     2404          ORA  REG+1      
B1FE: D0 D3     2405          BNE  JMP        
B200: F0 F1     2406          BEQ  NOJUMP     
                2407 *
                2408 *
B202: 20 82 80  2409 INPC     JSR  RDKEY      
B205: 20 46 A4  2410          JSR  CHK:KBD    
B208: B0 F8     2411          BCS  INPC       
                2412 INPC1    EQU  *          
B20A: 85 04     2413          STA  REG        
B20C: A9 00     2414          LDA  #0         
B20E: 85 05     2415          STA  REG+1      
B210: 4C 7F A4  2416          JMP  MAINP      
                2417 *
B213: 20 E5 A5  2418 OUTC     JSR  PULTOP     
B216: A5 04     2419          LDA  REG        
B218: 20 58 80  2420          JSR  PC         
B21B: 4C 82 A4  2421          JMP  MAIN       
                2422 *
                2423 INS      EQU  *          
B21E: B1 26     2424          LDA  (P),Y      
B220: 85 5C     2425          STA  TEMP       
B222: E6 26     2426          INC  P          
B224: D0 02     2427          BNE  INS3       
B226: E6 27     2428          INC  P+1        
                2429 INS3     EQU  *          
B228: A4 5C     2430          LDY  TEMP       
B22A: 20 8D B3  2431          JSR  GETLN1     
B22D: AD 3C 03  2432          LDA  INBUF      
B230: 20 46 A4  2433          JSR  CHK:KBD    
B233: B0 F3     2434          BCS  INS3       
B235: 8A        2435          TXA             
B236: 18        2436          CLC             
B237: 69 01     2437          ADC  #1         
B239: C5 5C     2438          CMP  TEMP       
B23B: 90 02     2439          BLT  INS1       
B23D: A5 5C     2440          LDA  TEMP       
                2441 INS1     EQU  *          
B23F: 85 5D     2442          STA  TEMP+1     
B241: 20 9B A5  2443          JSR  GETADR     
B244: A0 03     2444          LDY  #3         
B246: A2 00     2445          LDX  #0         
                2446 INS2     EQU  *          
B248: C6 47     2447          DEC  DATA       
B24A: A5 47     2448          LDA  DATA       
B24C: C9 FF     2449          CMP  #$FF       
B24E: D0 02     2450          BNE  INS4       
B250: C6 48     2451          DEC  DATA+1     
                2452 INS4     EQU  *          
B252: BD 3C 03  2453          LDA  INBUF,X    
B255: 91 47     2454          STA  (DATA),Y   
B257: E8        2455          INX             
B258: C6 5D     2456          DEC  TEMP+1     
B25A: D0 EC     2457          BNE  INS2       
B25C: 4C 82 A4  2458          JMP  MAIN       
                2459 *
                2460 HPLOT    EQU  *          
B25F: 20 E5 A5  2461          JSR  PULTOP     
B262: A5 58     2462          LDA  REGB       
B264: D0 06     2463          BNE  HPL:ERR    
B266: A5 04     2464          LDA  REG        
B268: C9 C8     2465          CMP  #200       
B26A: 90 03     2466          BLT  HPLOT:1    
B26C: 4C F3 A6  2467 HPL:ERR  JMP  CHK:ERR    ; too big
B26F: 8D C2 02  2468 HPLOT:1  STA  YPOS       
B272: 20 E5 A5  2469          JSR  PULTOP     
B275: AD 16 D0  2470          LDA  VIC+$16    
B278: 29 10     2471          AND  #$10       
B27A: 85 4D     2472          STA  VOICENO    ; multi-colour flag
B27C: F0 04     2473          BEQ  HPLOT:SI   
B27E: 06 04     2474          ASL  REG        
B280: 26 05     2475          ROL  REG+1      ; double x co-ord
                2476 HPLOT:SI EQU  *          
B282: A5 04     2477          LDA  REG        
B284: 8D C0 02  2478          STA  XPOSL      
B287: AA        2479          TAX             
B288: A5 05     2480          LDA  REG+1      
B28A: A8        2481          TAY             
B28B: E0 40     2482          CPX  #$40       
B28D: E9 01     2483          SBC  #1         
B28F: 90 03     2484          BCC  HPLOT:2    
B291: 4C F3 A6  2485          JMP  CHK:ERR    ; too big
B294: 8C C1 02  2486 HPLOT:2  STY  XPOSH      
B297: 20 E5 A5  2487          JSR  PULTOP     
B29A: A5 04     2488          LDA  REG        
B29C: 29 03     2489          AND  #3         
B29E: 8D E1 02  2490          STA  TEMP1+1    ; colour 
B2A1: AD C2 02  2491          LDA  YPOS       
B2A4: 29 F8     2492          AND  #$F8       
B2A6: 85 04     2493          STA  ROWL       
B2A8: A9 00     2494          LDA  #0         
B2AA: 06 04     2495          ASL  ROWL       
B2AC: 2A        2496          ROL             ; X 2
B2AD: 06 04     2497          ASL  ROWL       
B2AF: 2A        2498          ROL             ; X 4
B2B0: 06 04     2499          ASL  ROWL       
B2B2: 2A        2500          ROL             ; X 8
B2B3: 85 5D     2501          STA  TEMP+1     
B2B5: A4 04     2502          LDY  ROWL       
B2B7: 84 5C     2503          STY  TEMP       ; save it
B2B9: 06 04     2504          ASL  ROWL       
B2BB: 2A        2505          ROL             ; X 16
B2BC: 06 04     2506          ASL  ROWL       
B2BE: 2A        2507          ROL             ; X 32
B2BF: 18        2508          CLC             
B2C0: 85 05     2509          STA  ROWH       
B2C2: A5 04     2510          LDA  ROWL       
B2C4: 65 5C     2511          ADC  TEMP       ; now add 8 giving 40
B2C6: 85 04     2512          STA  ROWL       
B2C8: A5 05     2513          LDA  ROWH       
B2CA: 65 5D     2514          ADC  TEMP+1     
B2CC: 85 05     2515          STA  ROWH       
                2516 *
B2CE: 20 C4 A8  2517          JSR  GET:BNK    
B2D1: AD 18 D0  2518          LDA  VIC+$18    
B2D4: 29 0E     2519          AND  #$0E       
B2D6: 0A        2520          ASL             
B2D7: 0A        2521          ASL             
B2D8: 05 5D     2522          ORA  TEMP+1     ; character base
B2DA: 85 5D     2523          STA  TEMP+1     
B2DC: AD C0 02  2524          LDA  XPOSL      
B2DF: 29 F8     2525          AND  #$F8       
B2E1: 18        2526          CLC             
B2E2: 65 04     2527          ADC  ROWL       
B2E4: 85 04     2528          STA  ROWL       
B2E6: AD C1 02  2529          LDA  XPOSH      
B2E9: 05 5D     2530          ORA  TEMP+1     ; bank
B2EB: 65 05     2531          ADC  ROWH       
B2ED: 85 5D     2532          STA  TEMP+1     
B2EF: AD C2 02  2533          LDA  YPOS       
B2F2: 29 07     2534          AND  #7         
B2F4: 05 04     2535          ORA  ROWL       
B2F6: 85 5C     2536          STA  TEMP       
B2F8: AD C0 02  2537          LDA  XPOSL      
B2FB: 29 07     2538          AND  #7         
B2FD: AA        2539          TAX             
B2FE: A5 4D     2540          LDA  VOICENO    ; multi-colour?
B300: F0 14     2541          BEQ  POS:2      ; no
B302: AD E1 02  2542          LDA  TEMP1+1    ; colour 
B305: BC 40 B3  2543          LDY  HSHIFT,X   ; bits to shift
B308: F0 04     2544          BEQ  POS:3      ; none
B30A: 0A        2545 POS:4    ASL             
B30B: 88        2546          DEY             
B30C: D0 FC     2547          BNE  POS:4      
B30E: 8D E0 02  2548 POS:3    STA  TEMP1      
B311: BD 48 B3  2549          LDA  H2MASKS,X  ; bits to mask out
B314: D0 10     2550          BNE  POS:5      
                2551 *
                2552 POS:2    EQU  *          
B316: AD E1 02  2553          LDA  TEMP1+1    ; colour
B319: F0 03     2554          BEQ  POS:1      
B31B: BD 30 B3  2555          LDA  HMASKS,X   
B31E: 8D E0 02  2556 POS:1    STA  TEMP1      
B321: A0 00     2557          LDY  #0         
B323: BD 38 B3  2558          LDA  XHMASKS,X  
                2559 POS:5    EQU  *          
B326: 31 5C     2560          AND  (TEMP),Y   
B328: 0D E0 02  2561          ORA  TEMP1      
B32B: 91 5C     2562          STA  (TEMP),Y   
B32D: 4C 82 A4  2563          JMP  MAIN       
                2564 *
                2565 HMASKS   EQU  *          
B330: 80 40 20  2566          HEX  8040201008040201 
B333: 10 08 04 02 01 
                2567 XHMASKS  EQU  *          
B338: 7F BF DF  2568          HEX  7FBFDFEFF7FBFDFE 
B33B: EF F7 FB FD FE 
                2569 HSHIFT   EQU  *          
B340: 06 06 04  2570          HEX  0606040402020000 
B343: 04 02 02 00 00 
                2571 H2MASKS  EQU  *          
B348: 3F 3F CF  2572          HEX  3F3FCFCFF3F3FCFC 
B34B: CF F3 F3 FC FC 
                2573 *
                2574 TOHPLOT  EQU  *          
B350: 4C 5F B2  2575          JMP  HPLOT      
                2576 *
                2577 *
                2578 ADRNC    EQU  *          
B353: 20 9B A5  2579          JSR  GETADR     
                2580 ADRNC2   EQU  *          
B356: A5 47     2581          LDA  DATA       
B358: 18        2582          CLC             
B359: 69 02     2583          ADC  #2         
B35B: 85 47     2584          STA  DATA       
B35D: 90 07     2585          BCC  ADRN2      
B35F: E6 48     2586          INC  DATA+1     
B361: B0 03     2587          BCS  ADRN2      
                2588 ADRNN    EQU  *          
B363: 20 9B A5  2589          JSR  GETADR     
                2590 ADRN2    EQU  *          
B366: A5 47     2591          LDA  DATA       
B368: 85 04     2592          STA  REG        
B36A: A5 48     2593          LDA  DATA+1     
B36C: 85 05     2594          STA  REG+1      
B36E: 4C 7F A4  2595          JMP  MAINP      
                2596 *
                2597 ADRAN    EQU  *          
B371: 20 56 AF  2598          JSR  GETIDX     
B374: 4C 66 B3  2599          JMP  ADRN2      
                2600 *
                2601 ADRAC    EQU  *          
B377: 20 4D AF  2602          JSR  GETIDC     
B37A: 4C 56 B3  2603          JMP  ADRNC2     
                2604 *
                2605 *
                2606 *
B37D: 00        2608          BRK             


--End assembly, 4094 bytes, Errors: 0 
