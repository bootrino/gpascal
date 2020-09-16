                     ************************************************
                2    * G-PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 1
                5    * Authors: Nick Gammon & Sue Gobbett
                6    * Copyright (C) 1986 - Gambit Games.
                7    *
                8    *  Use:  SYM $9000    to assemble this correctly.
                     ************************************************
                10   P1       EQU  $8013      
                11   P2       EQU  $8DD4      
                12   P3       EQU  $992E      
                13   P4       EQU  $A380      
                14   P5       EQU  $B384      
                15   P6       EQU  $BCB8      
                16   *
                17   *
                18   *
                19   STACK    EQU  $100       
                20   INBUF    EQU  $33C       
                21   KBD:BUF  EQU  $277       
                22   HIMEM    EQU  $283       
                23   COLOR    EQU  $286       
                24   HIBASE   EQU  $288       
                25   AUTODN   EQU  $292       
                26   BITNUM   EQU  $298       
                27   BAUDOF   EQU  $299       
                28   RODBS    EQU  $29D       
                29   RODBE    EQU  $29E       
                30   ENABRS   EQU  $2A1       ; RS232 enables
                31   WARM:STR EQU  $302       ; basic warm start vector
                32   CINV     EQU  $314       ; hardware interrupt vector
                33   *
                34   SPACE    EQU  $20        
                35   CR       EQU  $D         
                36   FF       EQU  $C         
                37   LF       EQU  $A         
                38   MAX:STK  EQU  32         
                39   NEW:STK  EQU  $FF        
                40   *
                41   VIC      EQU  $D000      
                42   SID      EQU  $D400      
                43   CIA1     EQU  $DC00      
                44   CIA2     EQU  $DD00      
                45   DATAREG  EQU  $DD01      
                46   DDRB     EQU  $DD03      
                47   FLAG     EQU  $DD0D      
                48   BORDER   EQU  $D020      
                49   BKGND    EQU  $D021      
                50   *
                51   COUT     EQU  $FFD2      
                52   STOP     EQU  $FFE1      
                53   GETIN    EQU  $FFE4      
                54   CHKOUT   EQU  $FFC9      
                55   CLRCHN   EQU  $FFCC      
                56   UNLSN    EQU  $FFAE      
                57   UNTKL    EQU  $FFAB      
                58   CHRIN    EQU  $FFCF      
                59   CHKIN    EQU  $FFC6      
                60   PLOT     EQU  $FFF0      
                61   CHROUT   EQU  $FFD2      
                62   CINT     EQU  $FF81      
                63   IOINIT   EQU  $FF84      
                64   CLALL    EQU  $FFE7      
                65   SETMSG   EQU  $FF90      
                66   SETLFS   EQU  $FFBA      
                67   SETNAM   EQU  $FFBD      
                68   OPEN     EQU  $FFC0      
                69   LOAD     EQU  $FFD5      
                70   READST   EQU  $FFB7      
                71   SAVE     EQU  $FFD8      
                72   RAMTAS   EQU  $FF87      
                73   RESTOR   EQU  $FF8A      
                74   MEMTOP   EQU  $FF99      
                75   UNTLK    EQU  $FFAB      
                76   CLOSE    EQU  $FFC3      
                77   *
                78   *
                79            DUM  $2A7       
                80   *
                81   * PASCAL WORK AREAS
                82   *
                     ************************************************
                84   LINE:CNT EQU  $2         ; 2 BYTES
                85   LINE:NO  EQU  LINE:CNT   
                86   REG      EQU  $4         ; 2 BYTES
                87   ROWL     EQU  REG        
                88   ROWH     EQU  REG+1      
                89   SRCE     EQU  REG        
                90   REG2     EQU  $6         ; 2 BYTES
                91   DEST     EQU  REG2       
                92   WX       EQU  $8         ; 2 BYTES
                93   ERR:RTN  EQU  $B         ; 2 BYTES
                94   SYMTBL   EQU  $D         
                95   TOKEN    EQU  $16        
                96   TKNADR   EQU  $17        ; 2 BYTES
                97   TKNLEN   EQU  $19        
                98   EOF      EQU  $1A        
                99   LIST     EQU  $1B        
                100  NXTCHR   EQU  $1C        ; 2 BYTES
                101  VALUE    EQU  $1E        ; 3 BYTES
                102  DIGIT    EQU  $21        
                103  NOTRSV   EQU  $22        
                104  FRAME    EQU  $23        ; 2 BYTES
                105  LEVEL    EQU  $25        
                106  PCODE    EQU  $26        
                107  P        EQU  PCODE      
                108  PNTR     EQU  PCODE      
                109  ACT:PCDA EQU  $28        ; 2 BYTES
                110  DISPL    EQU  $2A        ; 2 BYTES
                111  OFFSET   EQU  $2C        ; 2 BYTES
                112  OPND     EQU  $2E        ; 3 BYTES
                113  DCODE    EQU  $31        
                114  ENDSYM   EQU  $32        ; 2 BYTES
                115  ARG      EQU  $34        
                116  PROMPT   EQU  $35        
                117  WORKD    EQU  $36        ; 2 BYTES
                118  ERRNO    EQU  $38        
                119  RTNADR   EQU  $39        ; 2 BYTES
                120  BSAVE    EQU  $3B        
                121  WORK     EQU  $3C        ; 2 BYTES
                122  PRCITM   EQU  $3E        ; 2 BYTES
                123  DSPWRK   EQU  $40        ; 2 BYTES
                124  PFLAG    EQU  $42        
                125  T        EQU  ENDSYM     ; STACK POINTER 2 BYTES
                126  TMP:PNTR EQU  T          
                127  BASE     EQU  $45        ; 2 BYTES
                128  TO       EQU  BASE       
                129  DATA     EQU  $47        ; 2 BYTES
                130  RUNNING  EQU  $49        
                131  UPR:CASE EQU  $4A        
                132  SCE:LIM  EQU  $4B        ; 2 BYTES
                133  FUNCTION EQU  SCE:LIM    
                134  SPRITENO EQU  SCE:LIM+1  
                135  STK:USE  EQU  $4D        
                136  VOICENO  EQU  STK:USE    
                137  SYMITM   EQU  $4E        ; 2 BYTES
                138  FROM     EQU  SYMITM     
                139  SYNTAX   EQU  $50        
                140  CHK:ARY  EQU  $51        
                141  SECRET   EQU  $52        
                142  VAL:CMP  EQU  $53        
                143  CTRLC:RT EQU  $54        ; 2 BYTES
                144  END:PCD  EQU  $56        ; 2 BYTES
                145  REGB     EQU  $58        
                146  REG2B    EQU  $59        
                147  LEFTCOL  EQU  $5A        
                148  SIGN     EQU  $5B        
                149  TEMP     EQU  $5C        ; 2 BYTES
                150  CALL     EQU  $5E        ; 2 BYTES
                151  COUNT    EQU  $60        
                152  LNCNT    EQU  $61        
                153  LS       EQU  $62        
                154  PCSVD    EQU  $63        ; 2 BYTES
                155  FIRST    EQU  $65        
                156  DBGTYP   EQU  $66        
                157  DBGFLG   EQU  $67        
                158  DEFP     EQU  $68        ; 2 BYTES
                159  DEFS     EQU  $6A        ; 2 BYTES
                160  DATTYP   EQU  $6C        
                161  DOS:FLG  EQU  DATTYP     
                162  A5       EQU  $6D        ; 2 BYTES
                163  MASK     EQU  A5         
                164  COLL:REG EQU  A5+1       
                165  ST       EQU  $90        
                166  DFLTN    EQU  $99        ; input device
                167  QUEUE    EQU  $C6        
                168  INDX     EQU  $C8        
                169  LXSP     EQU  $C9        
                170  BLNSW    EQU  $CC        
                171  BLNON    EQU  $CF        
                172  CRSW     EQU  $D0        
                173  BASL     EQU  $D1        
                174  CH       EQU  $D3        
                175  *
                176  P:STACK  EQU  $CED0      ; P-CODE STACK
                177  S:ANIMCT EQU  $CED8      ; count of frames
                178  S:ANIMPS EQU  $CEE0      ; current position
                179  S:ANIMCC EQU  $CEE8      ; current frame count
                180  S:ANIMFM EQU  $CEF0      ; no. of frames
                181  S:POINTR EQU  $CEF8      ; pointers - 16 per sprite
                182  SID:IMG  EQU  $CF7C      
                183  S:ACTIVE EQU  $CF98      
                184  S:XPOS   EQU  $CFA0      ; 3 bytes each
                185  S:YPOS   EQU  $CFB8      ; 2 bytes each
                186  S:XINC   EQU  $CFC8      ; 3 bytes each
                187  S:YINC   EQU  $CFE0      ; 2 bytes each
                188  S:COUNT  EQU  $CFF0      ; 2 bytes each
                189  *
                190  COUNT1   DS   1          
                191  COUNT2   DS   1          
                192  SYM:USE  DS   2          ; 2 BYTES
                193  SAVCUR   DS   6          ; 6 BYTES
                194  BPOINT   DS   20         
                195  CALL:P   EQU  BPOINT     
                196  CALL:A   EQU  BPOINT+1   
                197  CALL:X   EQU  BPOINT+2   
                198  CALL:Y   EQU  BPOINT+3   
                199  FNC:VAL  EQU  BPOINT+15  
                200  REMAIN   EQU  BPOINT+4   
                201  XPOSL    EQU  BPOINT+15  
                202  XPOSH    EQU  BPOINT+16  
                203  YPOS     EQU  BPOINT+17  
                204  CNTR     EQU  BPOINT+10  
                205  REP:FROM EQU  BPOINT+2   
                206  REP:TO   EQU  BPOINT+3   
                207  REP:LEN  EQU  BPOINT+4   
                208  PNTR:HI  EQU  BPOINT+5   
                209  IN:LGTH  EQU  BPOINT+6   
                210  LENGTH   EQU  BPOINT+7   
                211  FROM:ST  EQU  BPOINT+9   
                212  NUM:LINS EQU  BPOINT+11  
                213  ED:COM   EQU  BPOINT+13  
                214  TO:LINE  EQU  BPOINT+15  
                215  FND:FROM EQU  BPOINT+17  
                216  FND:TO   EQU  BPOINT+18  
                217  FND:POS  EQU  BPOINT+19  
                218  LASTP    DS   2          
                219  INCHAR   DS   1          
                220  IO:A     DS   1          
                221  IO:Y     DS   1          
                222  IO:X     DS   1          
                223  CURR:CHR DS   1          
                224  HEX:WK   DS   1          
                225           DS   2          
                226  STK:AVL  DS   1          
                227  STK:PAGE DS   1          
                228  STK:WRK  DS   1          
                229  STK:RT   DS   2          
                230  BEG:STK  DS   1          
                231  XSAVE    DS   1          
                232  RES      DS   3          ; 3 BYTES
                233  MCAND    DS   3          ; 3 BYTES
                234  DIVISOR  EQU  MCAND      
                235  DVDN     DS   3          ; 3 BYTES
                236  RMNDR    DS   1          
                237  TEMP1    DS   2          
                238  BIN:WRK  DS   3          
                239  ASC:WRK  DS   10         
                240  DEF:PCD  DS   1          
                241  REP:SIZE DS   1          
                242  NLN:FLAG DS   1          
                243  Q:FLAG   DS   1          
                244  FND:FLG  DS   1          
                245  FND:LEN  DS   1          
                246  UC:FLAG  DS   1          
                247  TRN:FLAG DS   1          
                248  GLB:FLAG DS   1          
                249  INT:RTN  DS   2          ; address to return to after a timer interrupt
                250  INT:TEMP DS   1          ; for interrupt service routine
                251  INT:TMP1 DS   1          
                252  INT:TMP2 DS   1          
                253  QT:TGL   DS   1          ; quote toggle
                254  QT:SIZE  DS   1          ; number of characters in reserved words
                255           DEND            
                     ************************************************
                257  * ADDRESS CONSTANTS ETC.
                     ************************************************
                259           ORG  $8000      
8000: 4C 2E 99  260           JMP  START      
8003: 4C 31 99  261           JMP  RESTART    
                262           DS   3          
8009: 00 40     263  TS       DA   $4000      
800B: 10        264  SYM:SIZE DFB  16         
800C: 5B        265  LHB      DFB  '['        
800D: 5D        266  RHB      DFB  ']'        
800E: 22        267  QUOT:SYM DFB  '"'        ; QUOTE SYMBOL
800F: 2E        268  DELIMIT  DFB  '.'        ; FIND/REPLACE DELIMITER
8010: 04        269  PR:CHAN  DFB  4          ; PRINTER CHANNEL
8011: 08        270  DISK:CHN DFB  8          ; DISK CHANNEL
8012: 00        271           DFB  0          ; SPARE FOR NOW
                272  *
                     ************************************************
                274  * PART 3 START
                     ************************************************
                276  START    EQU  P3         
                277  RESTART  EQU  START+3    
                278  EXIT:CMP EQU  RESTART    
                279  DSP:BIN  EQU  P3+6       
                280  ST:CMP   EQU  P3+9       
                281  ST:SYN   EQU  P3+12      
                282  DEBUG    EQU  P3+15      
                283  BELL1X   EQU  P3+24      
                284  *
                     ************************************************
                286  * PART 4
                     ************************************************
                288  *
                289  * VECTORS
                     ************************************************
8013: 4C 97 80  291           JMP  INIT       
8016: 4C 07 81  292           JMP  GETNEXT    
8019: 4C 5A 81  293           JMP  COMSTL     
801C: 4C 71 81  294           JMP  ISITHX     
801F: 4C 95 81  295           JMP  ISITAL     
8022: 4C A9 81  296           JMP  ISITNM     
8025: 4C 3A 81  297           JMP  CHAR       
8028: 4C 78 89  298           JMP  GEN2:B     
802B: 4C FE 86  299           JMP  DISHX      
802E: 4C 09 87  300           JMP  ERROR      
8031: 4C 13 89  301           JMP  GETCHK     
8034: 4C 25 89  302           JMP  CHKTKN     
8037: 4C 2A 89  303           JMP  GENNOP     
803A: 4C 43 89  304           JMP  GENADR     
803D: 4C AB 89  305           JMP  GENNJP     
8040: 4C AD 89  306           JMP  GENNJM     
8043: 4C 97 8D  307           JMP  TKNWRK     
8046: 4C E1 8A  308           JMP  PRBYTE     
8049: 4C 21 84  309           JMP  GTOKEN     
804C: 4C A2 8D  310           JMP  WRKTKN     
804F: 4C FC 89  311           JMP  FIXAD      
8052: 4C 4E 8A  312           JMP  PSHWRK     
8055: 4C 61 8A  313           JMP  PULWRK     
8058: 4C FB 8A  314           JMP  PC         
805B: 4C 93 8B  315           JMP  PT         
805E: 4C A8 8B  316           JMP  PL         
8061: 4C 29 84  317           JMP  TOKEN1     
8064: 4C 6C 8D  318           JMP  GETANS     
8067: 4C F7 8A  319           JMP  PUTSP      
806A: 4C E1 89  320           JMP  DISPAD     
806D: 4C 55 81  321           JMP  CROUT      
8070: 4C DD 85  322           JMP  SHLVAL     
8073: 4C 63 85  323           JMP  GET:NUM    
8076: 4C 48 86  324           JMP  GET:HEX    
8079: 4C E8 80  325           JMP  FND:END    
807C: 4C C4 8A  326           JMP  PAUSE      
807F: 4C C4 8D  327           JMP  HOME       
8082: 4C AD 8D  328           JMP  RDKEY      
8085: 4C B3 89  329           JMP  GENJMP     
8088: 4C 99 89  330           JMP  GENRJMP    
808B: D1 BA D2  331  US       HEX  D1BAD2D6D3CECFD0 
808E: D6 D3 CE CF D0 
                     ************************************************
                333  * PART 5 VECTORS
                     ************************************************
                335  EDITOR   EQU  P5         
                336  PUT:LINE EQU  P5+12      
                     ************************************************
                338  * PART 6 VECTORS
                     ************************************************
                340  BLOCK    EQU  P6         
                341  *
                     ************************************************
                343  *
                344  * INITIALIZE
                345  *
                     ************************************************
8093: 4E 4F BF  347  NOSCE    ASC  'NO',BF,0D
8096: 0D 
                348  INIT     EQU  *          
8097: A9 00     349           LDA  #0         
8099: 85 1A     350           STA  EOF        
809B: 85 1B     351           STA  LIST       
809D: 85 25     352           STA  LEVEL      
809F: 85 31     353           STA  DCODE      
80A1: 85 49     354           STA  RUNNING    
80A3: 85 3E     355           STA  PRCITM     
80A5: 85 3F     356           STA  PRCITM+1   
80A7: 85 02     357           STA  LINE:CNT   
80A9: 85 03     358           STA  LINE:CNT+1 
80AB: 85 58     359           STA  REGB       
80AD: A9 8B     360           LDA  #US        
80AF: A2 80     361           LDX  #>US       
80B1: A0 08     362           LDY  #8         
80B3: 20 93 8B  363           JSR  PT         
80B6: A5 0E     364           LDA  SYMTBL+1   
80B8: 8D AA 02  365           STA  SYM:USE+1  
80BB: 85 33     366           STA  ENDSYM+1   
80BD: AD 09 80  367           LDA  TS         
80C0: 38        368           SEC             
80C1: E9 01     369           SBC  #1         
80C3: 85 1C     370           STA  NXTCHR     
80C5: AD 0A 80  371           LDA  TS+1       
80C8: E9 00     372           SBC  #0         
80CA: 85 1D     373           STA  NXTCHR+1   
80CC: 20 E8 80  374           JSR  FND:END    
80CF: A5 26     375           LDA  P          
80D1: 85 28     376           STA  ACT:PCDA   
80D3: A5 27     377           LDA  P+1        
80D5: 85 29     378           STA  ACT:PCDA+1 
80D7: 20 0C 81  379           JSR  LINE       
80DA: A5 1A     380           LDA  EOF        
80DC: F0 28     381           BEQ  GOT:END2   
80DE: A9 93     382           LDA  #NOSCE     
80E0: A2 80     383           LDX  #>NOSCE    
80E2: 20 A8 8B  384           JSR  PL         
80E5: 4C C2 87  385           JMP  ERRRTN     
                386  INIT9    EQU  *          
                     ************************************************
                388  * FIND TEXT END
                     ************************************************
                390  FND:END  EQU  *          
80E8: AD 09 80  391           LDA  TS         
80EB: 85 26     392           STA  PCODE      
80ED: AD 0A 80  393           LDA  TS+1       
80F0: 85 27     394           STA  PCODE+1    
80F2: A0 00     395           LDY  #0         
                396  FND:TXTE EQU  *          
80F4: B1 26     397           LDA  (P),Y      
80F6: F0 08     398           BEQ  GOT:ENDS   
80F8: E6 26     399           INC  P          
80FA: D0 F8     400           BNE  FND:TXTE   
80FC: E6 27     401           INC  P+1        
80FE: D0 F4     402           BNE  FND:TXTE   
                403  GOT:ENDS EQU  *          
8100: E6 26     404           INC  P          
8102: D0 02     405           BNE  GOT:END2   
8104: E6 27     406           INC  P+1        
                407  GOT:END2 EQU  *          
8106: 60        408           RTS             
                     ************************************************
                410  * GET NEXT CHAR FROM INPUT
                     ************************************************
                412  GETNEXT  EQU  *          
8107: A0 01     413           LDY  #1         
8109: B1 1C     414           LDA  (NXTCHR),Y 
810B: 60        415  LINE4    RTS             
                416  *
                417  *
                     ************************************************
                419  * INPUT A LINE
                     ************************************************
810C: 20 07 81  421  LINE     JSR  GETNEXT    
810F: D0 03     422           BNE  LINE1      ; NULL = EOF
8111: E6 1A     423           INC  EOF        
8113: 60        424           RTS             
                425  LINE1    EQU  *          
8114: A5 1C     426           LDA  NXTCHR     
8116: 18        427           CLC             
8117: 69 01     428           ADC  #1         
8119: 85 6D     429           STA  A5         
811B: A5 1D     430           LDA  NXTCHR+1   
811D: 69 00     431           ADC  #0         
811F: 85 6E     432           STA  A5+1       
8121: E6 02     433           INC  LINE:CNT   
8123: D0 02     434           BNE  LINE3      
8125: E6 03     435           INC  LINE:CNT+1 
                436  LINE3    EQU  *          
8127: A5 1B     437           LDA  LIST       
8129: F0 04     438           BEQ  LINE2      
812B: 20 E4 86  439           JSR  DISP       
812E: 60        440           RTS             
                441  LINE2    EQU  *          
812F: A5 02     442           LDA  LINE:CNT   
8131: 29 0F     443           AND  #15        
8133: D0 D6     444           BNE  LINE4      
8135: A9 2A     445           LDA  #'*'       
8137: 4C FB 8A  446           JMP  PC         
                     ************************************************
                448  * GET A CHARACTER
                     ************************************************
                450  CHAR     EQU  *          
813A: E6 1C     451           INC  NXTCHR     
813C: D0 02     452           BNE  CHAR2      
813E: E6 1D     453           INC  NXTCHR+1   
                454  CHAR2    EQU  *          
8140: A0 00     455           LDY  #0         
8142: B1 1C     456           LDA  (NXTCHR),Y 
8144: C9 0D     457           CMP  #CR        
8146: D0 09     458           BNE  CHAR1      
8148: 20 0C 81  459           JSR  LINE       ; END OF LINE 
814B: A5 1A     460           LDA  EOF        
814D: F0 EB     461           BEQ  CHAR       
814F: A9 00     462           LDA  #0         ; END OF FILE MARKER
                463  CHAR1    EQU  *          
8151: 8D CB 02  464           STA  CURR:CHR   
8154: 60        465           RTS             
                466  *
                467  CROUT    EQU  *          
8155: A9 0D     468           LDA  #CR        
8157: 4C FB 8A  469           JMP  PC         
                470  *
                     ************************************************
                472  * COMPARE STRING
                     ************************************************
                474  COMSTL   EQU  *          
815A: 88        475           DEY             
815B: 30 11     476           BMI  COMS8      
815D: B1 04     477           LDA  (SRCE),Y   
815F: C9 C1     478           CMP  #$C1       
8161: 90 06     479           BLT  COMS1      
8163: C9 DB     480           CMP  #$DB       
8165: B0 02     481           BGE  COMS1      
8167: 29 7F     482           AND  #$7F       ; CONVERT TO U/C 
                483  COMS1    EQU  *          
8169: D1 06     484           CMP  (DEST),Y   
816B: F0 ED     485           BEQ  COMSTL     
816D: 60        486  COMS9    RTS             ; NOT EQUAL
816E: A9 00     487  COMS8    LDA  #0         
8170: 60        488           RTS             ; EQUAL
                     ************************************************
                490  * IS IT HEX?
                     ************************************************
                492  ISITHX   EQU  *          
8171: C9 30     493           CMP  #'0'       
8173: 90 1E     494           BLT  NOTHX      
8175: C9 3A     495           CMP  #'9'+1     
8177: 90 15     496           BLT  ISHX       
8179: C9 41     497           CMP  #'A'       
817B: 90 16     498           BLT  NOTHX      
817D: C9 47     499           CMP  #'F'+1     
817F: 90 0A     500           BLT  ISHX:A     
8181: C9 C1     501           CMP  #$C1       
8183: 90 0E     502           BLT  NOTHX      
8185: C9 C7     503           CMP  #$C7       
8187: B0 0A     504           BGE  NOTHX      
8189: 29 7F     505           AND  #$7F       ; convert to upper case 
                506  ISHX:A   EQU  *          
818B: 38        507           SEC             
818C: E9 07     508           SBC  #7         
                509  ISHX     EQU  *          
818E: 38        510           SEC             
818F: E9 30     511           SBC  #'0'       
8191: 18        512           CLC             
8192: 60        513           RTS             
                514  NOTHX    EQU  *          
8193: 38        515           SEC             
8194: 60        516           RTS             
                     ************************************************
                518  * IS IT ALPHA
                     ************************************************
                520  ISITAL   EQU  *          
8195: C9 41     521           CMP  #'A'       
8197: 90 0C     522           BLT  NOTAL      
8199: C9 5B     523           CMP  #'Z'+1     
819B: 90 0A     524           BLT  ISAL       
819D: C9 C1     525           CMP  #$C1       
819F: 90 04     526           BLT  NOTAL      
81A1: C9 DB     527           CMP  #$DB       
81A3: 90 02     528           BLT  ISAL       
                529  NOTAL    EQU  *          
81A5: 38        530           SEC             
81A6: 60        531           RTS             
                532  ISAL     EQU  *          
81A7: 18        533           CLC             
81A8: 60        534           RTS             
                     ************************************************
                536  * IS IT NUMERIC?
                     ************************************************
                538  ISITNM   EQU  *          
81A9: C9 30     539           CMP  #'0'       
81AB: 90 04     540           BLT  NOTNUM     
81AD: C9 3A     541           CMP  #'9'+1     
81AF: 90 02     542           BLT  ISNUM      
                543  NOTNUM   EQU  *          
81B1: 38        544           SEC             
81B2: 60        545           RTS             
                546  ISNUM    EQU  *          
81B3: 18        547           CLC             
81B4: 60        548           RTS             
                549  *
                550  *
                     ************************************************
                552  *
                553  * GET TOKEN !!!
                554  * *********
                555  *
                556  * RESERVED WORD TABLE
                557  *
                     ************************************************
                559  WRD      MAC             ; MACRO DEFINITION FOR TOKENS
                560           DFB  ]1,]2      ; LENGTH, TOKEN NUMBER
                561           ASC  ]3 ; TOKEN NAME
                562           EOM             ; END OF MACRO
                563  WRDLEN   EQU  0          
                564  WRDTYP   EQU  1          
                565  WRDNAM   EQU  2          
                566  RSVWRD   WRD  3;$81;'GET' 
81B5: 03 81     566           DFB  3,$81      ; LENGTH, TOKEN NUMBER
81B7: 47 45 54  566           ASC  'GET' ; TOKEN NAME
                566           EOM             ; END OF MACRO
                567           WRD  5;$82;'CONST' 
81BA: 05 82     567           DFB  5,$82      ; LENGTH, TOKEN NUMBER
81BC: 43 4F 4E  567           ASC  'CONST' ; TOKEN NAME
81BF: 53 54 
                567           EOM             ; END OF MACRO
                568           WRD  3;$83;'VAR' 
81C1: 03 83     568           DFB  3,$83      ; LENGTH, TOKEN NUMBER
81C3: 56 41 52  568           ASC  'VAR' ; TOKEN NAME
                568           EOM             ; END OF MACRO
                569           WRD  5;$84;'ARRAY' 
81C6: 05 84     569           DFB  5,$84      ; LENGTH, TOKEN NUMBER
81C8: 41 52 52  569           ASC  'ARRAY' ; TOKEN NAME
81CB: 41 59 
                569           EOM             ; END OF MACRO
                570           WRD  2;$85;'OF' 
81CD: 02 85     570           DFB  2,$85      ; LENGTH, TOKEN NUMBER
81CF: 4F 46     570           ASC  'OF' ; TOKEN NAME
                570           EOM             ; END OF MACRO
                571           WRD  9;$86;'PROCEDURE' 
81D1: 09 86     571           DFB  9,$86      ; LENGTH, TOKEN NUMBER
81D3: 50 52 4F  571           ASC  'PROCEDURE' ; TOKEN NAME
81D6: 43 45 44 55 52 45 
                571           EOM             ; END OF MACRO
                572           WRD  8;$87;'FUNCTION' 
81DC: 08 87     572           DFB  8,$87      ; LENGTH, TOKEN NUMBER
81DE: 46 55 4E  572           ASC  'FUNCTION' ; TOKEN NAME
81E1: 43 54 49 4F 4E 
                572           EOM             ; END OF MACRO
                573           WRD  5;$88;'BEGIN' 
81E6: 05 88     573           DFB  5,$88      ; LENGTH, TOKEN NUMBER
81E8: 42 45 47  573           ASC  'BEGIN' ; TOKEN NAME
81EB: 49 4E 
                573           EOM             ; END OF MACRO
                574           WRD  3;$89;'END' 
81ED: 03 89     574           DFB  3,$89      ; LENGTH, TOKEN NUMBER
81EF: 45 4E 44  574           ASC  'END' ; TOKEN NAME
                574           EOM             ; END OF MACRO
                575           WRD  2;$8A;'OR' 
81F2: 02 8A     575           DFB  2,$8A      ; LENGTH, TOKEN NUMBER
81F4: 4F 52     575           ASC  'OR' ; TOKEN NAME
                575           EOM             ; END OF MACRO
                576           WRD  3;$8B;'DIV' 
81F6: 03 8B     576           DFB  3,$8B      ; LENGTH, TOKEN NUMBER
81F8: 44 49 56  576           ASC  'DIV' ; TOKEN NAME
                576           EOM             ; END OF MACRO
                577           WRD  3;$8C;'MOD' 
81FB: 03 8C     577           DFB  3,$8C      ; LENGTH, TOKEN NUMBER
81FD: 4D 4F 44  577           ASC  'MOD' ; TOKEN NAME
                577           EOM             ; END OF MACRO
                578           WRD  3;$8D;'AND' 
8200: 03 8D     578           DFB  3,$8D      ; LENGTH, TOKEN NUMBER
8202: 41 4E 44  578           ASC  'AND' ; TOKEN NAME
                578           EOM             ; END OF MACRO
                579           WRD  3;$8E;'SHL' 
8205: 03 8E     579           DFB  3,$8E      ; LENGTH, TOKEN NUMBER
8207: 53 48 4C  579           ASC  'SHL' ; TOKEN NAME
                579           EOM             ; END OF MACRO
                580           WRD  3;$8F;'SHR' 
820A: 03 8F     580           DFB  3,$8F      ; LENGTH, TOKEN NUMBER
820C: 53 48 52  580           ASC  'SHR' ; TOKEN NAME
                580           EOM             ; END OF MACRO
                581           WRD  3;$90;'NOT' 
820F: 03 90     581           DFB  3,$90      ; LENGTH, TOKEN NUMBER
8211: 4E 4F 54  581           ASC  'NOT' ; TOKEN NAME
                581           EOM             ; END OF MACRO
                582           WRD  3;$91;'MEM' 
8214: 03 91     582           DFB  3,$91      ; LENGTH, TOKEN NUMBER
8216: 4D 45 4D  582           ASC  'MEM' ; TOKEN NAME
                582           EOM             ; END OF MACRO
                583           WRD  2;$92;'IF' 
8219: 02 92     583           DFB  2,$92      ; LENGTH, TOKEN NUMBER
821B: 49 46     583           ASC  'IF' ; TOKEN NAME
                583           EOM             ; END OF MACRO
                584           WRD  4;$93;'THEN' 
821D: 04 93     584           DFB  4,$93      ; LENGTH, TOKEN NUMBER
821F: 54 48 45  584           ASC  'THEN' ; TOKEN NAME
8222: 4E 
                584           EOM             ; END OF MACRO
                585           WRD  4;$94;'ELSE' 
8223: 04 94     585           DFB  4,$94      ; LENGTH, TOKEN NUMBER
8225: 45 4C 53  585           ASC  'ELSE' ; TOKEN NAME
8228: 45 
                585           EOM             ; END OF MACRO
                586           WRD  4;$95;'CASE' 
8229: 04 95     586           DFB  4,$95      ; LENGTH, TOKEN NUMBER
822B: 43 41 53  586           ASC  'CASE' ; TOKEN NAME
822E: 45 
                586           EOM             ; END OF MACRO
                587           WRD  5;$96;'WHILE' 
822F: 05 96     587           DFB  5,$96      ; LENGTH, TOKEN NUMBER
8231: 57 48 49  587           ASC  'WHILE' ; TOKEN NAME
8234: 4C 45 
                587           EOM             ; END OF MACRO
                588           WRD  2;$97;'DO' 
8236: 02 97     588           DFB  2,$97      ; LENGTH, TOKEN NUMBER
8238: 44 4F     588           ASC  'DO' ; TOKEN NAME
                588           EOM             ; END OF MACRO
                589           WRD  6;$98;'REPEAT' 
823A: 06 98     589           DFB  6,$98      ; LENGTH, TOKEN NUMBER
823C: 52 45 50  589           ASC  'REPEAT' ; TOKEN NAME
823F: 45 41 54 
                589           EOM             ; END OF MACRO
                590           WRD  5;$99;'UNTIL' 
8242: 05 99     590           DFB  5,$99      ; LENGTH, TOKEN NUMBER
8244: 55 4E 54  590           ASC  'UNTIL' ; TOKEN NAME
8247: 49 4C 
                590           EOM             ; END OF MACRO
                591           WRD  3;$9A;'FOR' 
8249: 03 9A     591           DFB  3,$9A      ; LENGTH, TOKEN NUMBER
824B: 46 4F 52  591           ASC  'FOR' ; TOKEN NAME
                591           EOM             ; END OF MACRO
                592           WRD  2;$9B;'TO' 
824E: 02 9B     592           DFB  2,$9B      ; LENGTH, TOKEN NUMBER
8250: 54 4F     592           ASC  'TO' ; TOKEN NAME
                592           EOM             ; END OF MACRO
                593           WRD  6;$9C;'DOWNTO' 
8252: 06 9C     593           DFB  6,$9C      ; LENGTH, TOKEN NUMBER
8254: 44 4F 57  593           ASC  'DOWNTO' ; TOKEN NAME
8257: 4E 54 4F 
                593           EOM             ; END OF MACRO
                594           WRD  5;$9D;'WRITE' 
825A: 05 9D     594           DFB  5,$9D      ; LENGTH, TOKEN NUMBER
825C: 57 52 49  594           ASC  'WRITE' ; TOKEN NAME
825F: 54 45 
                594           EOM             ; END OF MACRO
                595           WRD  4;$9E;'READ' 
8261: 04 9E     595           DFB  4,$9E      ; LENGTH, TOKEN NUMBER
8263: 52 45 41  595           ASC  'READ' ; TOKEN NAME
8266: 44 
                595           EOM             ; END OF MACRO
                596           WRD  4;$9F;'CALL' 
8267: 04 9F     596           DFB  4,$9F      ; LENGTH, TOKEN NUMBER
8269: 43 41 4C  596           ASC  'CALL' ; TOKEN NAME
826C: 4C 
                596           EOM             ; END OF MACRO
                597  * $A0 not used because of clash with shift/space
                598           WRD  4;$A1;'CHAR' 
826D: 04 A1     598           DFB  4,$A1      ; LENGTH, TOKEN NUMBER
826F: 43 48 41  598           ASC  'CHAR' ; TOKEN NAME
8272: 52 
                598           EOM             ; END OF MACRO
                599           WRD  4;$A2;'MEMC' 
8273: 04 A2     599           DFB  4,$A2      ; LENGTH, TOKEN NUMBER
8275: 4D 45 4D  599           ASC  'MEMC' ; TOKEN NAME
8278: 43 
                599           EOM             ; END OF MACRO
                600           WRD  6;$A3;'CURSOR' 
8279: 06 A3     600           DFB  6,$A3      ; LENGTH, TOKEN NUMBER
827B: 43 55 52  600           ASC  'CURSOR' ; TOKEN NAME
827E: 53 4F 52 
                600           EOM             ; END OF MACRO
                601           WRD  3;$A4;'XOR' 
8281: 03 A4     601           DFB  3,$A4      ; LENGTH, TOKEN NUMBER
8283: 58 4F 52  601           ASC  'XOR' ; TOKEN NAME
                601           EOM             ; END OF MACRO
                602           WRD  12;$A5;'DEFINESPRITE' 
8286: 0C A5     602           DFB  12,$A5     ; LENGTH, TOKEN NUMBER
8288: 44 45 46  602           ASC  'DEFINESPRITE' ; TOKEN NAME
828B: 49 4E 45 53 50 52 49 54 
8293: 45 
                602           EOM             ; END OF MACRO
                603           WRD  4;$A6;'PLOT' 
8294: 04 A6     603           DFB  4,$A6      ; LENGTH, TOKEN NUMBER
8296: 50 4C 4F  603           ASC  'PLOT' ; TOKEN NAME
8299: 54 
                603           EOM             ; END OF MACRO
                604           WRD  6;$A7;'GETKEY' 
829A: 06 A7     604           DFB  6,$A7      ; LENGTH, TOKEN NUMBER
829C: 47 45 54  604           ASC  'GETKEY' ; TOKEN NAME
829F: 4B 45 59 
                604           EOM             ; END OF MACRO
                605           WRD  5;$A8;'CLEAR' 
82A2: 05 A8     605           DFB  5,$A8      ; LENGTH, TOKEN NUMBER
82A4: 43 4C 45  605           ASC  'CLEAR' ; TOKEN NAME
82A7: 41 52 
                605           EOM             ; END OF MACRO
                606           WRD  7;$A9;'ADDRESS' 
82A9: 07 A9     606           DFB  7,$A9      ; LENGTH, TOKEN NUMBER
82AB: 41 44 44  606           ASC  'ADDRESS' ; TOKEN NAME
82AE: 52 45 53 53 
                606           EOM             ; END OF MACRO
                607           WRD  4;$AA;'WAIT' 
82B2: 04 AA     607           DFB  4,$AA      ; LENGTH, TOKEN NUMBER
82B4: 57 41 49  607           ASC  'WAIT' ; TOKEN NAME
82B7: 54 
                607           EOM             ; END OF MACRO
                608           WRD  3;$AB;'CHR' 
82B8: 03 AB     608           DFB  3,$AB      ; LENGTH, TOKEN NUMBER
82BA: 43 48 52  608           ASC  'CHR' ; TOKEN NAME
                608           EOM             ; END OF MACRO
                609           WRD  3;$AC;'HEX' 
82BD: 03 AC     609           DFB  3,$AC      ; LENGTH, TOKEN NUMBER
82BF: 48 45 58  609           ASC  'HEX' ; TOKEN NAME
                609           EOM             ; END OF MACRO
                610           WRD  12;$AD;'SPRITEFREEZE' 
82C2: 0C AD     610           DFB  12,$AD     ; LENGTH, TOKEN NUMBER
82C4: 53 50 52  610           ASC  'SPRITEFREEZE' ; TOKEN NAME
82C7: 49 54 45 46 52 45 45 5A 
82CF: 45 
                610           EOM             ; END OF MACRO
                611           WRD  5;$AE;'CLOSE' 
82D0: 05 AE     611           DFB  5,$AE      ; LENGTH, TOKEN NUMBER
82D2: 43 4C 4F  611           ASC  'CLOSE' ; TOKEN NAME
82D5: 53 45 
                611           EOM             ; END OF MACRO
                612           WRD  3;$AF;'PUT' 
82D7: 03 AF     612           DFB  3,$AF      ; LENGTH, TOKEN NUMBER
82D9: 50 55 54  612           ASC  'PUT' ; TOKEN NAME
                612           EOM             ; END OF MACRO
                613           WRD  6;$DF;'SPRITE' 
82DC: 06 DF     613           DFB  6,$DF      ; LENGTH, TOKEN NUMBER
82DE: 53 50 52  613           ASC  'SPRITE' ; TOKEN NAME
82E1: 49 54 45 
                613           EOM             ; END OF MACRO
                614           WRD  14;$E0;'POSITIONSPRITE' 
82E4: 0E E0     614           DFB  14,$E0     ; LENGTH, TOKEN NUMBER
82E6: 50 4F 53  614           ASC  'POSITIONSPRITE' ; TOKEN NAME
82E9: 49 54 49 4F 4E 53 50 52 
82F1: 49 54 45 
                614           EOM             ; END OF MACRO
                615           WRD  5;$E1;'VOICE' 
82F4: 05 E1     615           DFB  5,$E1      ; LENGTH, TOKEN NUMBER
82F6: 56 4F 49  615           ASC  'VOICE' ; TOKEN NAME
82F9: 43 45 
                615           EOM             ; END OF MACRO
                616           WRD  8;$E2;'GRAPHICS' 
82FB: 08 E2     616           DFB  8,$E2      ; LENGTH, TOKEN NUMBER
82FD: 47 52 41  616           ASC  'GRAPHICS' ; TOKEN NAME
8300: 50 48 49 43 53 
                616           EOM             ; END OF MACRO
                617           WRD  5;$E3;'SOUND' 
8305: 05 E3     617           DFB  5,$E3      ; LENGTH, TOKEN NUMBER
8307: 53 4F 55  617           ASC  'SOUND' ; TOKEN NAME
830A: 4E 44 
                617           EOM             ; END OF MACRO
                618           WRD  8;$E4;'SETCLOCK' 
830C: 08 E4     618           DFB  8,$E4      ; LENGTH, TOKEN NUMBER
830E: 53 45 54  618           ASC  'SETCLOCK' ; TOKEN NAME
8311: 43 4C 4F 43 4B 
                618           EOM             ; END OF MACRO
                619           WRD  6;$E5;'SCROLL' 
8316: 06 E5     619           DFB  6,$E5      ; LENGTH, TOKEN NUMBER
8318: 53 43 52  619           ASC  'SCROLL' ; TOKEN NAME
831B: 4F 4C 4C 
                619           EOM             ; END OF MACRO
                620           WRD  13;$E6;'SPRITECOLLIDE' 
831E: 0D E6     620           DFB  13,$E6     ; LENGTH, TOKEN NUMBER
8320: 53 50 52  620           ASC  'SPRITECOLLIDE' ; TOKEN NAME
8323: 49 54 45 43 4F 4C 4C 49 
832B: 44 45 
                620           EOM             ; END OF MACRO
                621           WRD  13;$E7;'GROUNDCOLLIDE' 
832D: 0D E7     621           DFB  13,$E7     ; LENGTH, TOKEN NUMBER
832F: 47 52 4F  621           ASC  'GROUNDCOLLIDE' ; TOKEN NAME
8332: 55 4E 44 43 4F 4C 4C 49 
833A: 44 45 
                621           EOM             ; END OF MACRO
                622           WRD  7;$E8;'CURSORX' 
833C: 07 E8     622           DFB  7,$E8      ; LENGTH, TOKEN NUMBER
833E: 43 55 52  622           ASC  'CURSORX' ; TOKEN NAME
8341: 53 4F 52 58 
                622           EOM             ; END OF MACRO
                623           WRD  7;$E9;'CURSORY' 
8345: 07 E9     623           DFB  7,$E9      ; LENGTH, TOKEN NUMBER
8347: 43 55 52  623           ASC  'CURSORY' ; TOKEN NAME
834A: 53 4F 52 59 
                623           EOM             ; END OF MACRO
                624           WRD  5;$EA;'CLOCK' 
834E: 05 EA     624           DFB  5,$EA      ; LENGTH, TOKEN NUMBER
8350: 43 4C 4F  624           ASC  'CLOCK' ; TOKEN NAME
8353: 43 4B 
                624           EOM             ; END OF MACRO
                625           WRD  6;$EB;'PADDLE' 
8355: 06 EB     625           DFB  6,$EB      ; LENGTH, TOKEN NUMBER
8357: 50 41 44  625           ASC  'PADDLE' ; TOKEN NAME
835A: 44 4C 45 
                625           EOM             ; END OF MACRO
                626           WRD  7;$EC;'SPRITEX' 
835D: 07 EC     626           DFB  7,$EC      ; LENGTH, TOKEN NUMBER
835F: 53 50 52  626           ASC  'SPRITEX' ; TOKEN NAME
8362: 49 54 45 58 
                626           EOM             ; END OF MACRO
                627           WRD  8;$ED;'JOYSTICK' 
8366: 08 ED     627           DFB  8,$ED      ; LENGTH, TOKEN NUMBER
8368: 4A 4F 59  627           ASC  'JOYSTICK' ; TOKEN NAME
836B: 53 54 49 43 4B 
                627           EOM             ; END OF MACRO
                628           WRD  7;$EE;'SPRITEY' 
8370: 07 EE     628           DFB  7,$EE      ; LENGTH, TOKEN NUMBER
8372: 53 50 52  628           ASC  'SPRITEY' ; TOKEN NAME
8375: 49 54 45 59 
                628           EOM             ; END OF MACRO
                629           WRD  6;$EF;'RANDOM' 
8379: 06 EF     629           DFB  6,$EF      ; LENGTH, TOKEN NUMBER
837B: 52 41 4E  629           ASC  'RANDOM' ; TOKEN NAME
837E: 44 4F 4D 
                629           EOM             ; END OF MACRO
                630           WRD  8;$F0;'ENVELOPE' 
8381: 08 F0     630           DFB  8,$F0      ; LENGTH, TOKEN NUMBER
8383: 45 4E 56  630           ASC  'ENVELOPE' ; TOKEN NAME
8386: 45 4C 4F 50 45 
                630           EOM             ; END OF MACRO
                631           WRD  7;$F1;'SCROLLX' 
838B: 07 F1     631           DFB  7,$F1      ; LENGTH, TOKEN NUMBER
838D: 53 43 52  631           ASC  'SCROLLX' ; TOKEN NAME
8390: 4F 4C 4C 58 
                631           EOM             ; END OF MACRO
                632           WRD  7;$F2;'SCROLLY' 
8394: 07 F2     632           DFB  7,$F2      ; LENGTH, TOKEN NUMBER
8396: 53 43 52  632           ASC  'SCROLLY' ; TOKEN NAME
8399: 4F 4C 4C 59 
                632           EOM             ; END OF MACRO
                633           WRD  12;$F3;'SPRITESTATUS' 
839D: 0C F3     633           DFB  12,$F3     ; LENGTH, TOKEN NUMBER
839F: 53 50 52  633           ASC  'SPRITESTATUS' ; TOKEN NAME
83A2: 49 54 45 53 54 41 54 55 
83AA: 53 
                633           EOM             ; END OF MACRO
                634           WRD  10;$F4;'MOVESPRITE' 
83AB: 0A F4     634           DFB  10,$F4     ; LENGTH, TOKEN NUMBER
83AD: 4D 4F 56  634           ASC  'MOVESPRITE' ; TOKEN NAME
83B0: 45 53 50 52 49 54 45 
                634           EOM             ; END OF MACRO
                635           WRD  10;$F5;'STOPSPRITE' 
83B7: 0A F5     635           DFB  10,$F5     ; LENGTH, TOKEN NUMBER
83B9: 53 54 4F  635           ASC  'STOPSPRITE' ; TOKEN NAME
83BC: 50 53 50 52 49 54 45 
                635           EOM             ; END OF MACRO
                636           WRD  11;$F6;'STARTSPRITE' 
83C3: 0B F6     636           DFB  11,$F6     ; LENGTH, TOKEN NUMBER
83C5: 53 54 41  636           ASC  'STARTSPRITE' ; TOKEN NAME
83C8: 52 54 53 50 52 49 54 45 
                636           EOM             ; END OF MACRO
                637           WRD  13;$F7;'ANIMATESPRITE' 
83D0: 0D F7     637           DFB  13,$F7     ; LENGTH, TOKEN NUMBER
83D2: 41 4E 49  637           ASC  'ANIMATESPRITE' ; TOKEN NAME
83D5: 4D 41 54 45 53 50 52 49 
83DD: 54 45 
                637           EOM             ; END OF MACRO
                638           WRD  3;$F8;'ABS' 
83DF: 03 F8     638           DFB  3,$F8      ; LENGTH, TOKEN NUMBER
83E1: 41 42 53  638           ASC  'ABS' ; TOKEN NAME
                638           EOM             ; END OF MACRO
                639           WRD  7;$F9;'INVALID' 
83E4: 07 F9     639           DFB  7,$F9      ; LENGTH, TOKEN NUMBER
83E6: 49 4E 56  639           ASC  'INVALID' ; TOKEN NAME
83E9: 41 4C 49 44 
                639           EOM             ; END OF MACRO
                640           WRD  4;$FA;'LOAD' 
83ED: 04 FA     640           DFB  4,$FA      ; LENGTH, TOKEN NUMBER
83EF: 4C 4F 41  640           ASC  'LOAD' ; TOKEN NAME
83F2: 44 
                640           EOM             ; END OF MACRO
                641           WRD  4;$FB;'SAVE' 
83F3: 04 FB     641           DFB  4,$FB      ; LENGTH, TOKEN NUMBER
83F5: 53 41 56  641           ASC  'SAVE' ; TOKEN NAME
83F8: 45 
                641           EOM             ; END OF MACRO
                642           WRD  4;$FC;'OPEN' 
83F9: 04 FC     642           DFB  4,$FC      ; LENGTH, TOKEN NUMBER
83FB: 4F 50 45  642           ASC  'OPEN' ; TOKEN NAME
83FE: 4E 
                642           EOM             ; END OF MACRO
                643           WRD  12;$FD;'FREEZESTATUS' 
83FF: 0C FD     643           DFB  12,$FD     ; LENGTH, TOKEN NUMBER
8401: 46 52 45  643           ASC  'FREEZESTATUS' ; TOKEN NAME
8404: 45 5A 45 53 54 41 54 55 
840C: 53 
                643           EOM             ; END OF MACRO
                644           WRD  7;$FE;'INTEGER' 
840D: 07 FE     644           DFB  7,$FE      ; LENGTH, TOKEN NUMBER
840F: 49 4E 54  644           ASC  'INTEGER' ; TOKEN NAME
8412: 45 47 45 52 
                644           EOM             ; END OF MACRO
                645           WRD  7;$FF;'WRITELN' 
8416: 07 FF     645           DFB  7,$FF      ; LENGTH, TOKEN NUMBER
8418: 57 52 49  645           ASC  'WRITELN' ; TOKEN NAME
841B: 54 45 4C 4E 
                645           EOM             ; END OF MACRO
841F: 00 00     646  RSVEND   DFB  0,0        ; END OF TABLE
                647  *
                648  GETTKN   EQU  *          
                649  GTOKEN   EQU  *          
8421: 20 3A 81  650           JSR  CHAR       
8424: D0 03     651           BNE  TOKEN1     ; ZERO = EOF
8426: 85 16     652           STA  TOKEN      
8428: 60        653           RTS             
                654  TOKEN1   EQU  *          
8429: C9 20     655           CMP  #'         '
842B: F0 F4     656           BEQ  GTOKEN     ; BYPASS SPACE
842D: C9 A0     657           CMP  #"         " ; ALSO BYPASS SHIFT/SPACE
842F: F0 F0     658           BEQ  GTOKEN     
8431: C9 10     659           CMP  #$10       ; DLE?
8433: D0 09     660           BNE  TOKEN1:A   
8435: E6 1C     661           INC  NXTCHR     
8437: D0 02     662           BNE  DLE:OK     
8439: E6 1D     663           INC  NXTCHR+1   
                664  DLE:OK   EQU  *          
843B: 4C 21 84  665           JMP  GTOKEN     
                666  TOKEN1:A EQU  *          
843E: C9 28     667           CMP  #'('       
8440: F0 03     668           BEQ  TOKEN1:B   
8442: 4C D5 84  669           JMP  TOKEN2     
                670  TOKEN1:B EQU  *          
8445: 20 07 81  671           JSR  GETNEXT    
8448: C9 2A     672           CMP  #'*'       
844A: F0 03     673           BEQ  TOKEN3     ; COMMENT 
844C: 4C 8F 86  674           JMP  TKN26:A    ; BACK TO PROCESS '('
                675  TOKEN3   EQU  *          ; BYPASS COMMENTS
844F: 20 3A 81  676           JSR  CHAR       
8452: D0 05     677           BNE  TOKEN4     
8454: A2 07     678           LDX  #7         ; NO } FOUND
8456: 20 09 87  679           JSR  ERROR      
                680  TOKEN4   EQU  *          
8459: C9 10     681           CMP  #$10       ; dle
845B: D0 08     682           BNE  TOKEN4:A   ; n
845D: E6 1C     683           INC  NXTCHR     ; bypass count
845F: D0 EE     684           BNE  TOKEN3     
8461: E6 1D     685           INC  NXTCHR+1   
8463: D0 EA     686           BNE  TOKEN3     
                687  TOKEN4:A EQU  *          
8465: C9 25     688           CMP  #'%'       ; COMPILER DIRECTIVE?
8467: D0 5B     689           BNE  TOKEN4:B   ; NO SUCH LUCK
8469: 20 3A 81  690           JSR  CHAR       ; AND WHAT MIGHT THE DIRECTIVE BE?
846C: 29 7F     691           AND  #$7F       ; convert case
846E: C9 41     692           CMP  #'A'       ; ADDRESS OF P-CODES?
8470: D0 2E     693           BNE  TOKEN4:D   ; NOPE
8472: 20 21 84  694           JSR  GTOKEN     ; RE-CALL GTOKEN TO FIND THE ADDRESS
8475: C9 4E     695           CMP  #'N'       ; NUMBER?
8477: F0 05     696           BEQ  TOKEN4:C   ; YES
8479: A2 02     697           LDX  #2         
847B: 20 09 87  698           JSR  ERROR      ; 'Constant expected'
                699  TOKEN4:C EQU  *          
847E: A5 1E     700           LDA  VALUE      
8480: 85 26     701           STA  P          
8482: 85 28     702           STA  ACT:PCDA   ; also save for run
8484: A5 1F     703           LDA  VALUE+1    
8486: 85 27     704           STA  P+1        ; STORE NEW P-CODE ADDRESS
8488: 85 29     705           STA  ACT:PCDA+1 
848A: C9 08     706           CMP  #$08       ; TOO LOW?
848C: 90 0D     707           BLT  TOKEN4:I   ; YES - ERROR
848E: C9 40     708           CMP  #$40       ; TOO HIGH
8490: 90 06     709           BLT  TOKEN3J    ; NOPE
8492: D0 07     710           BNE  TOKEN4:I   ; YES
                711  *
                712  * here if address is $40XX - CHECK THAT XX IS ZERO
                713  *
8494: A5 26     714           LDA  P          
8496: F0 00     715           BEQ  TOKEN3J    ; YES - THANK GOODNES
                716  TOKEN3J  EQU  *          
8498: 4C 4F 84  717           JMP  TOKEN3     ; BACK AGAIN
                718  *
                719  * here if address is outside range $0800 to $4000
                720  *
849B: A2 1E     721  TOKEN4:I LDX  #30        
849D: 20 09 87  722           JSR  ERROR      ; crash it
                723  *
                724  *
                725  TOKEN4:D EQU  *          
84A0: C9 4C     726           CMP  #'L'       ; COMMENCE LISTING?
84A2: D0 0E     727           BNE  TOKEN4:E   ; NOPE
                728  TOKEN4:H EQU  *          
84A4: 48        729           PHA             
84A5: A5 1B     730           LDA  LIST       ; ALREADY LISTING THE FILE?
84A7: D0 03     731           BNE  TOKEN4:F   ; YEP
84A9: 20 E4 86  732           JSR  DISP       ; NO - SO DISPLAY THIS LINE THEN
                733  TOKEN4:F EQU  *          
84AC: 68        734           PLA             
84AD: 85 1B     735           STA  LIST       ; SET LISTING FLAG
84AF: 4C 4F 84  736           JMP  TOKEN3     ; BACK FOR NEXT COMMENT
                737  *
                738  TOKEN4:E EQU  *          
84B2: C9 50     739           CMP  #'P'       ; P-CODES LIST?
84B4: D0 04     740           BNE  TOKEN4:G   ; NOPE
84B6: 85 31     741           STA  DCODE      ; SET DISPLAY P-CODE FLAG
84B8: F0 EA     742           BEQ  TOKEN4:H   ; GO BACK AS IF FOR LIST
                743  *
                744  TOKEN4:G EQU  *          
84BA: 49 4E     745           EOR  #'N'       ; NO-LIST?
84BC: D0 06     746           BNE  TOKEN4:B   ; NOPE - FORGET IT THEN
84BE: 85 31     747           STA  DCODE      
84C0: 85 1B     748           STA  LIST       ; (A) MUST BE ZERO - CLEAR BOTH FLAGS
84C2: F0 D4     749           BEQ  TOKEN3J    ; BACK FOR NEXT COMMENT 
                750  *
                751  *
                752  TOKEN4:B EQU  *          
84C4: C9 2A     753           CMP  #'*'       
84C6: D0 D0     754           BNE  TOKEN3J    
84C8: 20 07 81  755           JSR  GETNEXT    
84CB: C9 29     756           CMP  #')'       
84CD: D0 C9     757           BNE  TOKEN3J    
84CF: 20 3A 81  758           JSR  CHAR       ; BYPASS *
84D2: 4C 21 84  759           JMP  GTOKEN     
                760  *
                761  * HERE IF NOT COMMENT OR SPACE
                762  *
                763  TOKEN2   EQU  *          
84D5: A6 1C     764           LDX  NXTCHR     
84D7: 86 17     765           STX  TKNADR     
84D9: A6 1D     766           LDX  NXTCHR+1   
84DB: 86 18     767           STX  TKNADR+1   
84DD: A2 01     768           LDX  #1         
84DF: 86 19     769           STX  TKNLEN     ; DEFAULT LENGTH =1
84E1: CA        770           DEX             
84E2: 86 5B     771           STX  SIGN       
84E4: 86 1F     772           STX  VALUE+1    ; FOR STRINGS
84E6: 86 20     773           STX  VALUE+2    
84E8: 86 22     774           STX  NOTRSV     
84EA: 20 95 81  775           JSR  ISITAL     
84ED: B0 6C     776           BCS  TOKEN5     ; NOT ALPHA
84EF: A9 49     777           LDA  #'I'       
84F1: 85 16     778           STA  TOKEN      ; IDENTIFIER
                779  TOKEN7   EQU  *          
84F3: 20 07 81  780           JSR  GETNEXT    
84F6: 20 95 81  781           JSR  ISITAL     
84F9: 90 0B     782           BCC  TKN18      ; ALPHA
84FB: C9 5F     783           CMP  #'_'       ; UNDERSCORE?
84FD: F0 05     784           BEQ  TKN18:A    ; YEP
84FF: 20 A9 81  785           JSR  ISITNM     
8502: B0 09     786           BCS  TOKEN6     ; END OF IDENT 
8504: E6 22     787  TKN18:A  INC  NOTRSV     
                788  TKN18    EQU  *          
8506: 20 3A 81  789           JSR  CHAR       
8509: E6 19     790           INC  TKNLEN     
850B: D0 E6     791           BNE  TOKEN7     
                792  TOKEN6   EQU  *          
850D: A5 22     793           LDA  NOTRSV     
850F: D0 0E     794           BNE  TKN19      
8511: A9 B5     795           LDA  #RSVWRD    
8513: 85 08     796           STA  WX         
8515: A9 81     797           LDA  #>RSVWRD   
8517: 85 09     798           STA  WX+1       
                799  TOKEN8   EQU  *          
8519: A0 00     800           LDY  #0         
851B: B1 08     801           LDA  (WX),Y     
851D: D0 03     802           BNE  TOKEN9     ; MORE TO GO
                803  TKN19    EQU  *          
851F: A5 16     804           LDA  TOKEN      
8521: 60        805           RTS             
                806  *
                807  * SEARCH FOR RESERVED WORD
                808  *
                809  TOKEN9   EQU  *          
8522: B1 08     810           LDA  (WX),Y     ; LENGTH OF WORD 
8524: C5 19     811           CMP  TKNLEN     ; SAME?
8526: D0 22     812           BNE  TKN10      ; CAN'T BE IT THEN
8528: A8        813           TAY             ; LENGTH
8529: A5 17     814           LDA  TKNADR     
852B: 85 04     815           STA  SRCE       
852D: A5 18     816           LDA  TKNADR+1   
852F: 85 05     817           STA  SRCE+1     
8531: A5 08     818           LDA  WX         
8533: 18        819           CLC             
8534: 69 02     820           ADC  #2         
8536: 85 06     821           STA  DEST       
8538: A5 09     822           LDA  WX+1       
853A: 69 00     823           ADC  #0         
853C: 85 07     824           STA  DEST+1     
853E: 20 5A 81  825           JSR  COMSTL     
8541: D0 07     826           BNE  TKN10      ; NOT FOUND
8543: A0 01     827           LDY  #1         
8545: B1 08     828           LDA  (WX),Y     
8547: 85 16     829           STA  TOKEN      
8549: 60        830           RTS             
                831  TKN10    EQU  *          
854A: A0 00     832           LDY  #0         
854C: B1 08     833           LDA  (WX),Y     ; LENGTH
854E: 18        834           CLC             
854F: 69 02     835           ADC  #2         
8551: 65 08     836           ADC  WX         
8553: 85 08     837           STA  WX         
8555: 90 C2     838           BCC  TOKEN8     
8557: E6 09     839           INC  WX+1       
8559: D0 BE     840           BNE  TOKEN8     
                     ************************************************
                842  * NOT IDENTIFIER
                     ************************************************
                844  *
                     ************************************************
                846  * NOT IDENTIFIER
                     ************************************************
                848  TOKEN5   EQU  *          
855B: 20 A9 81  849           JSR  ISITNM     
855E: 90 03     850           BCC  GET:NUM    
8560: 4C E6 85  851           JMP  TKN12      
                852  GET:NUM  EQU  *          
8563: 38        853           SEC             
8564: E9 30     854           SBC  #'0'       
8566: 85 1E     855           STA  VALUE      
8568: A9 00     856           LDA  #0         
856A: 85 1F     857           STA  VALUE+1    
856C: 85 20     858           STA  VALUE+2    
                859  TKN13    EQU  *          ; NEXT DIGIT
856E: 20 07 81  860           JSR  GETNEXT    
8571: 20 A9 81  861           JSR  ISITNM     
8574: 90 1C     862           BCC  TKN14      ; MORE DIGITS
                863  TKN13A   EQU  *          
8576: A5 5B     864           LDA  SIGN       
8578: F0 12     865           BEQ  TKN13B     
857A: 38        866           SEC             
857B: A9 00     867           LDA  #0         
857D: AA        868           TAX             
857E: E5 1E     869           SBC  VALUE      
8580: 85 1E     870           STA  VALUE      
8582: 8A        871           TXA             
8583: E5 1F     872           SBC  VALUE+1    
8585: 85 1F     873           STA  VALUE+1    
8587: 8A        874           TXA             
8588: E5 20     875           SBC  VALUE+2    
858A: 85 20     876           STA  VALUE+2    
                877  TKN13B   EQU  *          
858C: A9 4E     878           LDA  #'N'       
858E: 85 16     879           STA  TOKEN      
8590: 18        880           CLC             
8591: 60        881           RTS             
                882  TKN14    EQU  *          
8592: 20 3A 81  883           JSR  CHAR       
8595: 38        884           SEC             
8596: E9 30     885           SBC  #'0'       
8598: 85 21     886           STA  DIGIT      
859A: E6 19     887           INC  TKNLEN     
859C: 20 DD 85  888           JSR  SHLVAL     
859F: A5 1E     889           LDA  VALUE      
85A1: A6 1F     890           LDX  VALUE+1    
85A3: A4 20     891           LDY  VALUE+2    
85A5: 20 DD 85  892           JSR  SHLVAL     
85A8: 20 DD 85  893           JSR  SHLVAL     
85AB: 65 1E     894           ADC  VALUE      
85AD: 85 1E     895           STA  VALUE      
85AF: 8A        896           TXA             
85B0: 65 1F     897           ADC  VALUE+1    
85B2: 85 1F     898           STA  VALUE+1    
85B4: 98        899           TYA             
85B5: 65 20     900           ADC  VALUE+2    
85B7: 85 20     901           STA  VALUE+2    
85B9: B0 17     902           BCS  TKN16      
85BB: A5 1E     903           LDA  VALUE      
85BD: 65 21     904           ADC  DIGIT      
85BF: 85 1E     905           STA  VALUE      
85C1: 90 AB     906           BCC  TKN13      
85C3: E6 1F     907           INC  VALUE+1    
85C5: D0 A7     908           BNE  TKN13      
85C7: E6 20     909           INC  VALUE+2    
85C9: F0 07     910           BEQ  TKN16      
85CB: 30 05     911           BMI  TKN16      
85CD: 4C 6E 85  912           JMP  TKN13      
                913  *
85D0: 68        914  TKN16:B  PLA             
85D1: 68        915           PLA             ; CUT STACK
                916  TKN16    EQU  *          
85D2: A5 49     917           LDA  RUNNING    
85D4: 10 02     918           BPL  TKN16:A    
85D6: 38        919           SEC             
85D7: 60        920           RTS             
                921  TKN16:A  EQU  *          
85D8: A2 1E     922           LDX  #30        
85DA: 20 09 87  923           JSR  ERROR      
                924  *
                925  SHLVAL   EQU  *          
85DD: 06 1E     926           ASL  VALUE      
85DF: 26 1F     927           ROL  VALUE+1    
85E1: 26 20     928           ROL  VALUE+2    
85E3: B0 EB     929           BCS  TKN16:B    
85E5: 60        930           RTS             
                931  *
                     ************************************************
                933  * NOT A NUMBER
                     ************************************************
                935  TKN12    EQU  *          
85E6: CD 0E 80  936           CMP  QUOT:SYM   
85E9: D0 4C     937           BNE  TKN17      
85EB: E6 17     938           INC  TKNADR     
85ED: D0 02     939           BNE  TKN12:A    
85EF: E6 18     940           INC  TKNADR+1   
                941  TKN12:A  EQU  *          
85F1: C6 19     942           DEC  TKNLEN     
                943  TKN30:A  EQU  *          
85F3: 20 07 81  944           JSR  GETNEXT    
85F6: C9 0D     945           CMP  #CR        
85F8: D0 05     946           BNE  TKN31      
85FA: A2 08     947           LDX  #8         ; MISSIG QUOTE
85FC: 20 09 87  948           JSR  ERROR      
                949  TKN31    EQU  *          
85FF: CD 0E 80  950           CMP  QUOT:SYM   
8602: D0 2C     951           BNE  TKN20      
8604: 20 3A 81  952           JSR  CHAR       
8607: 20 07 81  953           JSR  GETNEXT    ; ANOTHER?
860A: CD 0E 80  954           CMP  QUOT:SYM   
860D: F0 21     955           BEQ  TKN20      ; IMBEDDED QUOTE
860F: A0 03     956           LDY  #3         
8611: C4 19     957           CPY  TKNLEN     
8613: 90 02     958           BLT  TKN31:A    
8615: A4 19     959           LDY  TKNLEN     
8617: 88        960  TKN31:A  DEY             
8618: 30 07     961           BMI  TKN31:B    
861A: B1 17     962           LDA  (TKNADR),Y 
861C: 99 1E 00  963           STA  VALUE,Y    
861F: D0 F6     964           BNE  TKN31:A    
                965  TKN31:B  EQU  *          
8621: A5 19     966           LDA  TKNLEN     
8623: D0 05     967           BNE  TKN21      
8625: A2 0E     968           LDX  #14        ; BAD STRING
8627: 20 09 87  969           JSR  ERROR      
                970  TKN21    EQU  *          
862A: AD 0E 80  971           LDA  QUOT:SYM   
862D: 85 16     972           STA  TOKEN      
862F: 60        973           RTS             
                974  TKN20    EQU  *          
8630: 20 3A 81  975           JSR  CHAR       
8633: E6 19     976           INC  TKNLEN     
8635: D0 BC     977           BNE  TKN30:A    
                     ************************************************
                979  * NOT A STRING
                     ************************************************
                981  TKN17    EQU  *          
8637: C9 24     982           CMP  #'$'       
8639: D0 3F     983           BNE  TKN29      
863B: 20 07 81  984           JSR  GETNEXT    
863E: 20 71 81  985           JSR  ISITHX     
8641: 90 05     986           BCC  TKN22      
8643: A9 24     987           LDA  #'$'       
8645: 85 16     988           STA  TOKEN      
8647: 60        989           RTS             
                990  TKN22    EQU  *          
                991  GET:HEX  EQU  *          
8648: 85 1E     992           STA  VALUE      
864A: A9 00     993           LDA  #0         
864C: 85 1F     994           STA  VALUE+1    
864E: 85 20     995           STA  VALUE+2    
                996  TKN24    EQU  *          
8650: 20 3A 81  997           JSR  CHAR       
8653: 20 07 81  998           JSR  GETNEXT    
8656: 20 71 81  999           JSR  ISITHX     
8659: 90 03     1000          BCC  TKN23      
865B: 4C 76 85  1001          JMP  TKN13A     
                1002 TKN23    EQU  *          
865E: E6 19     1003          INC  TKNLEN     
8660: A2 04     1004          LDX  #4         
                1005 TKN15    EQU  *          
8662: 20 DD 85  1006          JSR  SHLVAL     
8665: CA        1007          DEX             
8666: D0 FA     1008          BNE  TKN15      
8668: 18        1009          CLC             
8669: 65 1E     1010          ADC  VALUE      
866B: 85 1E     1011          STA  VALUE      
866D: 90 E1     1012          BCC  TKN24      
866F: E6 1F     1013          INC  VALUE+1    
8671: D0 DD     1014          BNE  TKN24      
8673: E6 20     1015          INC  VALUE+2    
8675: D0 D9     1016          BNE  TKN24      
8677: 4C D2 85  1017 TKN16J   JMP  TKN16      
                1018 *
                     ************************************************
                1020 * NOT $ OR HEX LITERAL 
                     ************************************************
                1022 TKN29    EQU  *          
867A: C9 3A     1023          CMP  #':'       
867C: D0 17     1024          BNE  TKN25      
867E: 20 07 81  1025          JSR  GETNEXT    
8681: C9 3D     1026          CMP  #'='       
8683: D0 0A     1027          BNE  TKN26:A    
8685: 20 3A 81  1028          JSR  CHAR       
8688: E6 19     1029          INC  TKNLEN     
868A: A9 41     1030          LDA  #'A'       
                1031 TKN26    EQU  *          
868C: 85 16     1032          STA  TOKEN      
868E: 60        1033          RTS             
                1034 TKN26:A  EQU  *          
868F: A0 00     1035          LDY  #0         
8691: B1 1C     1036          LDA  (NXTCHR),Y 
8693: D0 F7     1037          BNE  TKN26      
                1038 TKN25    EQU  *          
8695: C9 3C     1039          CMP  #'<'       
8697: D0 10     1040          BNE  TKN27      
8699: 20 07 81  1041          JSR  GETNEXT    
869C: C9 3D     1042          CMP  #'='       
869E: D0 1D     1043          BNE  TKN28      
86A0: 20 3A 81  1044          JSR  CHAR       
86A3: E6 19     1045          INC  TKNLEN     
86A5: A9 80     1046          LDA  #$80       
86A7: D0 E3     1047          BNE  TKN26      
                1048 TKN27    EQU  *          
86A9: C9 3E     1049          CMP  #'>'       
86AB: D0 1D     1050          BNE  TKN30      
86AD: 20 07 81  1051          JSR  GETNEXT    
86B0: C9 3D     1052          CMP  #'='       
86B2: D0 DB     1053          BNE  TKN26:A    
86B4: 20 3A 81  1054          JSR  CHAR       
86B7: E6 19     1055          INC  TKNLEN     
86B9: A9 81     1056          LDA  #$81       
86BB: D0 CF     1057          BNE  TKN26      
                1058 TKN28    EQU  *          
86BD: C9 3E     1059          CMP  #'>'       
86BF: D0 CE     1060          BNE  TKN26:A    
86C1: 20 3A 81  1061          JSR  CHAR       
86C4: E6 19     1062          INC  TKNLEN     
86C6: A9 55     1063          LDA  #'U'       
86C8: D0 C2     1064          BNE  TKN26      
86CA: C9 2D     1065 TKN30    CMP  #'-'       
86CC: D0 10     1066          BNE  TKN31:C    
86CE: 85 5B     1067          STA  SIGN       
86D0: 20 07 81  1068 TKN32    JSR  GETNEXT    
86D3: 20 A9 81  1069          JSR  ISITNM     
86D6: B0 B7     1070          BCS  TKN26:A    
86D8: 20 3A 81  1071          JSR  CHAR       
86DB: 4C 5B 85  1072          JMP  TOKEN5     
86DE: C9 2B     1073 TKN31:C  CMP  #'+'       
86E0: D0 AD     1074          BNE  TKN26:A    
86E2: F0 EC     1075          BEQ  TKN32      
                     ************************************************
                1077 * DISPLAY A LINE
                1078 *
                1079 *
                1080 DISP     EQU  *          
86E4: 20 E5 89  1081          JSR  DISPAD1    
86E7: 20 90 B3  1082          JSR  PUT:LINE   ; display right-justified line no.
86EA: A5 D3     1083          LDA  CH         
86EC: 85 5A     1084          STA  LEFTCOL    
86EE: A9 40     1085          LDA  #$40       
86F0: 85 49     1086          STA  RUNNING    
86F2: A5 6D     1087          LDA  A5         
86F4: A6 6E     1088          LDX  A5+1       
86F6: 20 A8 8B  1089          JSR  PL         
86F9: A9 00     1090          LDA  #0         
86FB: 85 49     1091          STA  RUNNING    
86FD: 60        1092          RTS             
                1093 *
                1094 * DISPLAY IN HEX
                1095 *
86FE: 20 E1 8A  1096 DISHX    JSR  PRBYTE     
8701: 4C F7 8A  1097          JMP  PUTSP      
                1098 *
                     ************************************************
                1100 * DISPLAY ERROR
                     ************************************************
8704: 0E        1102 ERRLIT   DFB  14         ; SWITCH TO LOWER CASE
8705: 2A 2A 2A  1103          ASC  '***',BD ; '*** ERROR'
8708: BD 
8709: 86 38     1104 ERROR    STX  ERRNO      
870B: A5 49     1105          LDA  RUNNING    
870D: F0 03     1106          BEQ  ERR7       
870F: 4C A7 87  1107          JMP  ERR6       
                1108 ERR7     EQU  *          
8712: A5 1B     1109          LDA  LIST       
8714: D0 06     1110          BNE  ERR1       
8716: 20 55 81  1111          JSR  CROUT      
8719: 20 E4 86  1112          JSR  DISP       
                1113 ERR1     EQU  *          
871C: A5 17     1114          LDA  TKNADR     
871E: 38        1115          SEC             
871F: E5 6D     1116          SBC  A5         
8721: 48        1117          PHA             ; CHARS UP TO ERROR POINT 
8722: A0 05     1118          LDY  #5         
8724: A9 04     1119          LDA  #ERRLIT    
8726: A2 87     1120          LDX  #>ERRLIT   
8728: 20 93 8B  1121          JSR  PT         
872B: 68        1122          PLA             
872C: 85 5C     1123          STA  TEMP       ; BYTES TO ERROR POINT
872E: 18        1124          CLC             
872F: 65 5A     1125          ADC  LEFTCOL    
8731: E9 08     1126          SBC  #8         
8733: AA        1127          TAX             
                1128 *
                1129 * ALLOW FOR SPACE COUNTS
                1130 *
8734: A0 00     1131          LDY  #0         
8736: 8C FD 02  1132          STY  QT:TGL     
8739: 8C FE 02  1133          STY  QT:SIZE    
                1134 ERR1:A   EQU  *          
873C: C4 5C     1135          CPY  TEMP       
873E: B0 4B     1136          BGE  ERR2       ; DONE
8740: B1 6D     1137          LDA  (A5),Y     
8742: 30 14     1138          BMI  ERR1:D     ; could be reserved word
8744: C9 10     1139          CMP  #$10       ; DLE?
8746: F0 33     1140          BEQ  ERR1:B     ; YES
8748: CD 0E 80  1141          CMP  QUOT:SYM   ; quote?
874B: D0 08     1142          BNE  ERR1:C     ; no
874D: AD FD 02  1143          LDA  QT:TGL     
8750: 49 01     1144          EOR  #1         
8752: 8D FD 02  1145          STA  QT:TGL     ; flip flag
8755: C8        1146 ERR1:C   INY             ; ONTO NEXT
8756: D0 E4     1147          BNE  ERR1:A     
                1148 *
                1149 * here to allow for spaces in expanded reserved word
                1150 *
8758: 8C C9 02  1151 ERR1:D   STY  IO:Y       
875B: AC FD 02  1152          LDY  QT:TGL     
875E: D0 15     1153          BNE  ERR1:F     ; ignore if in quotes
8760: C9 B0     1154          CMP  #$B0       
8762: 90 04     1155          BLT  ERR1:E     
8764: C9 DF     1156          CMP  #$DF       
8766: 90 0D     1157          BLT  ERR1:F     ; not in range
                1158 *
8768: 8D C8 02  1159 ERR1:E   STA  IO:A       ; token
876B: 20 57 8B  1160          JSR  PC:LOOK    
876E: 18        1161          CLC             
876F: 6D FE 02  1162          ADC  QT:SIZE    
8772: 8D FE 02  1163          STA  QT:SIZE    
8775: AC C9 02  1164 ERR1:F   LDY  IO:Y       
8778: C8        1165          INY             
8779: D0 C1     1166          BNE  ERR1:A     ; done
                1167 *
                1168 *
                1169 ERR1:B   EQU  *          
877B: C8        1170          INY             
877C: B1 6D     1171          LDA  (A5),Y     ; SPACE COUNT
877E: 29 7F     1172          AND  #$7F       ; CLEAR 8-BIT
8780: 85 5D     1173          STA  TEMP+1     
8782: 8A        1174          TXA             
8783: 18        1175          CLC             
8784: 65 5D     1176          ADC  TEMP+1     
8786: AA        1177          TAX             
8787: CA        1178          DEX             
8788: CA        1179          DEX             ; ALLOW FOR DLE/COUNT
8789: D0 CA     1180          BNE  ERR1:C     
                1181 *
                1182 ERR2     EQU  *          
878B: 8A        1183          TXA             
878C: 18        1184          CLC             
878D: 6D FE 02  1185          ADC  QT:SIZE    
8790: AA        1186          TAX             
                1187 ERR3     EQU  *          
8791: 20 F7 8A  1188          JSR  PUTSP      
8794: CA        1189          DEX             
8795: D0 FA     1190          BNE  ERR3       
8797: A9 5E     1191          LDA  #'^'       
8799: 20 FB 8A  1192          JSR  PC         
879C: 20 55 81  1193          JSR  CROUT      
879F: A2 09     1194          LDX  #9         
                1195 ERR5     EQU  *          
87A1: 20 F7 8A  1196          JSR  PUTSP      
87A4: CA        1197          DEX             
87A5: D0 FA     1198          BNE  ERR5       
                1199 ERR6     EQU  *          
87A7: C6 38     1200          DEC  ERRNO      
87A9: A5 38     1201          LDA  ERRNO      
87AB: 0A        1202          ASL             
87AC: 18        1203          CLC             
87AD: 69 C9     1204          ADC  #ERRTBL    
87AF: 85 04     1205          STA  REG        
87B1: A9 87     1206          LDA  #>ERRTBL   
87B3: 69 00     1207          ADC  #0         
87B5: 85 05     1208          STA  REG+1      
87B7: A0 01     1209          LDY  #1         
87B9: B1 04     1210          LDA  (REG),Y    
87BB: AA        1211          TAX             
87BC: 88        1212          DEY             
87BD: B1 04     1213          LDA  (REG),Y    
87BF: 20 A8 8B  1214          JSR  PL         ; DISPLAY ERROR
                1215 ERRRTN   EQU  *          
87C2: A9 00     1216          LDA  #0         
87C4: 85 C6     1217          STA  QUEUE      
87C6: 6C 0B 00  1218          JMP  (ERR:RTN)  
                     ************************************************
                1220 * ERROR TABLE
                     ************************************************
                1222 ERRTBL   EQU  *          
87C9: 15 88 1D  1223          DA   ERR01,ERR02,ERR03,ERR04 
87CC: 88 20 88 23 88 
87D1: 26 88 2C  1224          DA   ERR05,ERR06,ERR07,ERR08 
87D4: 88 30 88 34 88 
87D9: 37 88 3A  1225          DA   ERR09,ERR10,ERR11,ERR12,ERR13,ERR14,ERR15,ERR16 
87DC: 88 3D 88 49 88 4C 88 50 
87E4: 88 5C 88 6E 88 
87E9: 74 88 7C  1226          DA   ERR17,ERR18,ERR19,ERR06,ERR21,ERR22,ERR23,ERR24 
87EC: 88 80 88 2C 88 83 88 A1 
87F4: 88 A4 88 AD 88 
87F9: B0 88 B7  1227          DA   ERR25,ERR26,ERR27,ERR28,ERR29,ERR30,ERR31 
87FC: 88 BC 88 BF 88 CC 88 D5 
8804: 88 DD 88 
8807: E0 88 E3  1228          DA   ERR32,ERR33,ERR34,ERR35,ERR36,ERR37,ERR38 
880A: 88 E6 88 E9 88 EF 88 04 
8812: 89 08 89 
8815: 6D 45 4D  1229 ERR01    ASC  'mEMORY',B1,0D
8818: 4F 52 59 B1 0D 
881D: B2 B4 0D  1230 ERR02    HEX  B2B40D     
8820: 3D B4 0D  1231 ERR03    ASC  '=',B4,0D
8823: B3 B4 0D  1232 ERR04    HEX  B3B40D     
8826: 2C C1     1233 ERR05    ASC  ',',C1
8828: 20 3A B4  1234          ASC  ' :',B4,0D 
882B: 0D 
882C: 42 55 47  1235 ERR06    ASC  'BUG',0D
882F: 0D 
8830: 2A 29 B4  1236 ERR07    ASC  '*)',B4,0D
8833: 0D 
8834: B7 B8 0D  1237 ERR08    HEX  B7B80D     
8837: 2E B4 0D  1238 ERR09    ASC  '.',B4,0D
883A: 3B B4 0D  1239 ERR10    ASC  ';',B4,0D
883D: 75 4E 44  1240 ERR11    ASC  'uNDECLARED',B3,0D
8840: 45 43 4C 41 52 45 44 B3 
8848: 0D 
8849: B6 B3 0D  1241 ERR12    HEX  B6B30D     
884C: 3A 3D B4  1242 ERR13    ASC  ':=',B4,0D
884F: 0D 
8850: BB B8 C0  1243 ERR14    DFB  $BB,$B8,$C0,$BE 
8853: BE 
8854: 20 4C 45  1244          ASC  ' LENGTH',0D 
8857: 4E 47 54 48 0D 
885C: BA        1245 ERR15    DFB  $BA        
885D: 20 4C 49  1246          ASC  ' LIMITS EXCEEDED',0D 
8860: 4D 49 54 53 20 45 58 43 
8868: 45 45 44 45 44 0D 
886E: 74 68 65  1247 ERR16    ASC  'then',B4,0D
8871: 6E B4 0D 
8874: 3B C1     1248 ERR17    ASC  ';',C1
8876: 20 65 6E  1249          ASC  ' end',B4,0D 
8879: 64 B4 0D 
887C: 64 6F B4  1250 ERR18    ASC  'do',B4,0D
887F: 0D 
8880: B7 C4 0D  1251 ERR19    HEX  B7C40D     
8883: 75 53 45  1252 ERR21    ASC  'uSE',C0
8886: C0 
8887: 20 50 52  1253          ASC  ' PROCEDURE',B3 
888A: 4F 43 45 44 55 52 45 B3 
8892: 20 49 4E  1254          ASC  ' IN EXPRESSION',0D 
8895: 20 45 58 50 52 45 53 53 
889D: 49 4F 4E 0D 
88A1: 29 B4 0D  1255 ERR22    ASC  ')',B4,0D
88A4: B6        1256 ERR23    DFB  $B6        
88A5: 20 46 41  1257          ASC  ' FACTOR',0D 
88A8: 43 54 4F 52 0D 
88AD: C9 BC 0D  1258 ERR24    HEX  C9BC0D     
88B0: 62 65 67  1259 ERR25    ASC  'begin',B4,0D
88B3: 69 6E B4 0D 
88B7: 22 C0 22  1260 ERR26    HEX  22C022B40D 
88BA: B4 0D 
88BC: C6 B1 0D  1261 ERR27    HEX  C6B10D     
88BF: 22 C2 22  1262 ERR28    DFB  $22,$C2,$22,$C1 
88C2: C1 
88C3: 20 64 6F  1263          ASC  ' downto',B4,0D 
88C6: 77 6E 74 6F B4 0D 
88CC: B8 BB C2  1264 ERR29    DFB  $B8,$BB,$C2 
88CF: 4F 20 42  1265          ASC  'O BIG',0D 
88D2: 49 47 0D 
88D5: CC        1266 ERR30    DFB  $CC        
88D6: 20 4F 55  1267          ASC  ' OUT',C0,D8,0D 
88D9: 54 C0 D8 0D 
88DD: 28 B4 0D  1268 ERR31    ASC  '(',B4,0D
88E0: 2C B4 0D  1269 ERR32    ASC  ',',B4,0D
88E3: 5B B4 0D  1270 ERR33    ASC  '[',B4,0D
88E6: 5D B4 0D  1271 ERR34    ASC  ']',B4,0D
88E9: D9        1272 ERR35    DFB  $D9        
88EA: 53 BC     1273          ASC  'S',BC
88EC: 45 44 0D  1274          ASC  'ED',0D
88EF: 64 41 54  1275 ERR36    ASC  'dATA',C9
88F2: 41 C9 
88F4: 20 4E 4F  1276          ASC  ' NOT RECOGNISED',0D 
88F7: 54 20 52 45 43 4F 47 4E 
88FF: 49 53 45 44 0D 
8904: C4 C8 B1  1277 ERR37    HEX  C4C8B10D   
8907: 0D 
8908: 64 55 50  1278 ERR38    ASC  'dUPLICATE',B3,0D
890B: 4C 49 43 41 54 45 B3 0D 
                1279 *
                     ************************************************
                1281 * GET A TOKEN - CHECK THAT IT
                1282 * IS THE SAME AS IN "A", IF NOT
                1283 * CALL ERROR "X"
                     ************************************************
                1285 GETCHK   EQU  *          
8913: 85 3B     1286          STA  BSAVE      
8915: 8A        1287          TXA             
8916: 48        1288          PHA             
8917: 20 21 84  1289          JSR  GTOKEN     
891A: C5 3B     1290          CMP  BSAVE      
891C: F0 05     1291          BEQ  CHKOK      
891E: 68        1292          PLA             
891F: AA        1293          TAX             
                1294 CHKNOK   EQU  *          
8920: 20 09 87  1295          JSR  ERROR      
                1296 CHKOK    EQU  *          
8923: 68        1297          PLA             
8924: 60        1298          RTS             
                     ************************************************
                1300 * CHECK TOKEN AGREES WITH "A",
                1301 * IF NOT, GIVE ERROR "X"
                     ************************************************
                1303 CHKTKN   EQU  *          
8925: C5 16     1304          CMP  TOKEN      
8927: D0 F7     1305          BNE  CHKNOK     
8929: 60        1306          RTS             
                1307 *
                     ************************************************
                1309 * GENERATE P-CODES - NO OPERANDS
                     ************************************************
                1311 GENNOP   EQU  *          
892A: A4 50     1312          LDY  SYNTAX     
892C: D0 11     1313          BNE  GEN1       
892E: 91 26     1314          STA  (PCODE),Y  
8930: 48        1315          PHA             
8931: 20 E1 89  1316          JSR  DISPAD     
8934: 68        1317          PLA             
8935: A6 31     1318          LDX  DCODE      
8937: F0 06     1319          BEQ  GEN1       
8939: 20 FE 86  1320          JSR  DISHX      
893C: 20 55 81  1321          JSR  CROUT      
                1322 GEN1     EQU  *          
893F: A9 01     1323          LDA  #1         
8941: D0 35     1324          BNE  GEN2:B     
                     ************************************************
                1326 * GENERATE P-CODES - WITH ADDRESS
                     ************************************************
                1328 GENADR   EQU  *          
8943: A4 50     1329          LDY  SYNTAX     
8945: D0 2F     1330          BNE  GEN2       
8947: 91 26     1331          STA  (PCODE),Y  
8949: 48        1332          PHA             
894A: A5 2A     1333          LDA  DISPL      
894C: C8        1334          INY             
894D: 91 26     1335          STA  (PCODE),Y  
894F: A5 2C     1336          LDA  OFFSET     
8951: C8        1337          INY             
8952: 91 26     1338          STA  (PCODE),Y  
8954: A5 2D     1339          LDA  OFFSET+1   
8956: C8        1340          INY             
8957: 91 26     1341          STA  (PCODE),Y  
8959: 20 E1 89  1342          JSR  DISPAD     
895C: 68        1343          PLA             
895D: A6 31     1344          LDX  DCODE      
895F: F0 15     1345          BEQ  GEN2       
8961: 20 FE 86  1346          JSR  DISHX      
8964: A5 2A     1347          LDA  DISPL      
8966: 20 FE 86  1348          JSR  DISHX      
8969: A5 2C     1349          LDA  OFFSET     
896B: 20 FE 86  1350          JSR  DISHX      
896E: A5 2D     1351          LDA  OFFSET+1   
8970: 20 FE 86  1352          JSR  DISHX      
8973: 20 55 81  1353          JSR  CROUT      
                1354 GEN2     EQU  *          
8976: A9 04     1355          LDA  #4         
                1356 GEN2:B   EQU  *          
8978: 18        1357          CLC             
8979: 65 26     1358          ADC  PCODE      
897B: 85 26     1359          STA  PCODE      
897D: 90 02     1360          BCC  GEN2:A     
897F: E6 27     1361          INC  PCODE+1    
                1362 GEN2:A   EQU  *          
8981: A5 50     1363          LDA  SYNTAX     
8983: D0 13     1364          BNE  GEN2:C     
8985: A5 27     1365          LDA  PCODE+1    
8987: C9 7F     1366          CMP  #>P1-$18   
8989: 90 0D     1367          BLT  GEN2:C     
898B: D0 06     1368          BNE  GEN:FULL   
898D: A5 26     1369          LDA  PCODE      
898F: C9 FB     1370          CMP  #P1-$18    
8991: 90 05     1371          BLT  GEN2:C     
8993: A2 01     1372 GEN:FULL LDX  #1         ; MEM FULL
8995: 20 09 87  1373          JSR  ERROR      
                1374 GEN2:C   EQU  *          
8998: 60        1375 DISP9    RTS             
                     ************************************************
                1377 * GENERATE P-CODES - JUMP ADDRESS
                     ************************************************
                1379 GENRJMP  EQU  *          
8999: 48        1380          PHA             
899A: A5 2E     1381          LDA  OPND       
899C: 38        1382          SEC             
899D: E5 26     1383          SBC  PCODE      
899F: 85 2E     1384          STA  OPND       
89A1: A5 2F     1385          LDA  OPND+1     
89A3: E5 27     1386          SBC  PCODE+1    
89A5: 85 2F     1387          STA  OPND+1     
89A7: 68        1388          PLA             
89A8: 4C B3 89  1389          JMP  GENJMP     
                1390 *
                1391 GENNJP   EQU  *          
89AB: A9 3C     1392          LDA  #60        ; JMP
89AD: A2 00     1393 GENNJM   LDX  #0         
89AF: 86 2E     1394          STX  OPND       
89B1: 86 2F     1395          STX  OPND+1     
                1396 *
                1397 GENJMP   EQU  *          
89B3: A4 50     1398          LDY  SYNTAX     
89B5: D0 25     1399          BNE  GEN3       
89B7: 91 26     1400          STA  (PCODE),Y  
89B9: 48        1401          PHA             
89BA: A5 2E     1402          LDA  OPND       
89BC: C8        1403          INY             
89BD: 91 26     1404          STA  (PCODE),Y  
89BF: A5 2F     1405          LDA  OPND+1     
89C1: C8        1406          INY             
89C2: 91 26     1407          STA  (PCODE),Y  
89C4: 20 E1 89  1408          JSR  DISPAD     
89C7: 68        1409          PLA             
89C8: A6 31     1410          LDX  DCODE      
89CA: F0 10     1411          BEQ  GEN3       
89CC: 20 FE 86  1412          JSR  DISHX      
89CF: A5 2E     1413          LDA  OPND       
89D1: 20 FE 86  1414          JSR  DISHX      
89D4: A5 2F     1415          LDA  OPND+1     
89D6: 20 FE 86  1416          JSR  DISHX      
89D9: 20 55 81  1417          JSR  CROUT      
                1418 GEN3     EQU  *          
89DC: A9 03     1419          LDA  #3         
89DE: 4C 78 89  1420          JMP  GEN2:B     
                     ************************************************
                1422 * DISPLAY PCODE ADDRESS
                     ************************************************
                1424 DISPAD   EQU  *          
89E1: A5 31     1425          LDA  DCODE      
89E3: F0 B3     1426          BEQ  DISP9      
                1427 DISPAD1  EQU  *          
89E5: A9 28     1428          LDA  #'('       
89E7: 20 FB 8A  1429          JSR  PC         
89EA: A5 27     1430          LDA  PCODE+1    
89EC: 20 E1 8A  1431          JSR  PRBYTE     
89EF: A5 26     1432          LDA  PCODE      
89F1: 20 E1 8A  1433          JSR  PRBYTE     
89F4: A9 29     1434          LDA  #')'       
89F6: 20 FB 8A  1435          JSR  PC         
89F9: 4C F7 8A  1436          JMP  PUTSP      
                     ************************************************
                1438 * SYMBOL TABLE STUFF
                     ************************************************
                1440 SYMPRV   EQU  0          
                1441 SYMLVL   EQU  2          
                1442 SYMTYP   EQU  3          
                1443 SYMDSP   EQU  4          
                1444 SYMARG   EQU  6          
                1445 SYMSUB   EQU  6          ; MAX SUBSCRIPT+1
                1446 SYMDAT   EQU  8          ; VARIABLE TYPE
                1447 SYMLEN   EQU  9          
                1448 SYMNAM   EQU  10         ; NAME
                1449 *
                     ************************************************
                1451 * FIXUP ADDRESSES
                     ************************************************
                1453 FIXAD    EQU  *          
89FC: A4 50     1454          LDY  SYNTAX     
89FE: D0 98     1455          BNE  DISP9      
8A00: A0 01     1456          LDY  #1         
8A02: A5 26     1457          LDA  PCODE      
8A04: 38        1458          SEC             
8A05: E5 3C     1459          SBC  WORK       
8A07: 91 3C     1460          STA  (WORK),Y   
8A09: C8        1461          INY             
8A0A: A5 27     1462          LDA  PCODE+1    
8A0C: E5 3D     1463          SBC  WORK+1     
8A0E: 91 3C     1464          STA  (WORK),Y   
8A10: A5 31     1465          LDA  DCODE      
8A12: F0 4C     1466          BEQ  PSH9       
8A14: A9 3D     1467          LDA  #FIXM1     
8A16: A2 8A     1468          LDX  #>FIXM1    
8A18: A0 08     1469          LDY  #8         
8A1A: 20 93 8B  1470          JSR  PT         
8A1D: A5 3D     1471          LDA  WORK+1     
8A1F: 20 E1 8A  1472          JSR  PRBYTE     
8A22: A5 3C     1473          LDA  WORK       
8A24: 20 FE 86  1474          JSR  DISHX      
8A27: A9 45     1475          LDA  #FIXM2     
8A29: A2 8A     1476          LDX  #>FIXM2    
8A2B: A0 09     1477          LDY  #9         
8A2D: 20 93 8B  1478          JSR  PT         
8A30: A5 27     1479          LDA  PCODE+1    
8A32: 20 E1 8A  1480          JSR  PRBYTE     
8A35: A5 26     1481          LDA  PCODE      
8A37: 20 FE 86  1482          JSR  DISHX      
8A3A: 4C 55 81  1483          JMP  CROUT      
8A3D: 6A 55 4D  1484 FIXM1    ASC  'jUMP AT '
8A40: 50 20 41 54 20 
8A45: 43 48 41  1485 FIXM2    ASC  'CHANGED',C2
8A48: 4E 47 45 44 C2 
8A4D: 20        1486          ASC  ' '        
                     ************************************************
                1488 * PUSH 'WORK' ONTO STACK
                     ************************************************
                1490 PSHWRK   EQU  *          
8A4E: 85 3B     1491          STA  BSAVE      
8A50: 68        1492          PLA             
8A51: AA        1493          TAX             
8A52: 68        1494          PLA             
8A53: A8        1495          TAY             
8A54: A5 3D     1496          LDA  WORK+1     
8A56: 48        1497          PHA             
8A57: A5 3C     1498          LDA  WORK       
8A59: 48        1499          PHA             
8A5A: 98        1500          TYA             
8A5B: 48        1501          PHA             
8A5C: 8A        1502          TXA             
8A5D: 48        1503          PHA             
8A5E: A5 3B     1504          LDA  BSAVE      
8A60: 60        1505 PSH9     RTS             
                1506 *
                     ************************************************
                1508 * PULL 'WORK' FROM STACK
                     ************************************************
                1510 PULWRK   EQU  *          
8A61: 85 3B     1511          STA  BSAVE      
8A63: 68        1512          PLA             
8A64: AA        1513          TAX             
8A65: 68        1514          PLA             
8A66: A8        1515          TAY             
8A67: 68        1516          PLA             
8A68: 85 3C     1517          STA  WORK       
8A6A: 68        1518          PLA             
8A6B: 85 3D     1519          STA  WORK+1     
8A6D: 98        1520          TYA             
8A6E: 48        1521          PHA             
8A6F: 8A        1522          TXA             
8A70: 48        1523          PHA             
8A71: A5 3B     1524          LDA  BSAVE      
8A73: 60        1525          RTS             
                1526 *
                     ************************************************
                1528 * PRINTING SUBROUTINES
                     ************************************************
                1530 PRCHAR   EQU  *          
8A74: 8E D5 02  1531          STX  XSAVE      
8A77: 48        1532          PHA             
8A78: CD 0E 80  1533          CMP  QUOT:SYM   
8A7B: D0 0A     1534          BNE  PR:NTQT    
8A7D: 48        1535          PHA             
8A7E: AD FD 02  1536          LDA  QT:TGL     
8A81: 49 01     1537          EOR  #1         
8A83: 8D FD 02  1538          STA  QT:TGL     
8A86: 68        1539          PLA             
                1540 PR:NTQT  EQU  *          
8A87: 48        1541          PHA             
8A88: 20 D2 FF  1542          JSR  COUT       
8A8B: 68        1543          PLA             
8A8C: A6 42     1544          LDX  PFLAG      ; printing?
8A8E: F0 23     1545          BEQ  PR:NPTR    
8A90: 48        1546          PHA             
8A91: A2 04     1547          LDX  #4         
8A93: 20 C9 FF  1548          JSR  CHKOUT     ; direct to printer
8A96: 68        1549          PLA             
                1550 *
                1551 * The fiddling around below is because
                1552 * the capital letters in our messages (which are really
                1553 * lowercase here) do not print properly. So if we are not
                1554 * running a program or in quote mode, then we will convert
                1555 * what we think is 'lower case' to the equivalent in
                1556 * 'shifted' upper case (8 bit on).
                1557 *
8A97: A6 49     1558          LDX  RUNNING    ; running?
8A99: E0 0C     1559          CPX  #12        
8A9B: F0 10     1560          BEQ  PR:POK     ; yes - ignore
8A9D: AE FD 02  1561          LDX  QT:TGL     ; in quotes?
8AA0: D0 0B     1562          BNE  PR:POK     ; yes - ignore
8AA2: C9 61     1563          CMP  #'a'       ; upper case (on C64)?
8AA4: 90 07     1564          BLT  PR:POK     ; nope
8AA6: C9 7B     1565          CMP  #'z'+1     
8AA8: B0 03     1566          BGE  PR:POK     ; nope
8AAA: 18        1567          CLC             
8AAB: 69 60     1568          ADC  #$60       ; 'a' (hex 61) now becomes hex C1
                1569 *
                1570 PR:POK   EQU  *          
8AAD: 20 D2 FF  1571          JSR  COUT       
8AB0: 20 CC FF  1572          JSR  CLRCHN     ; back to screen 
                1573 PR:NPTR  EQU  *          
8AB3: 20 E1 FF  1574          JSR  STOP       
8AB6: F0 1C     1575          BEQ  ABORT      ; abort list
8AB8: A5 C6     1576          LDA  QUEUE      ; keys in kbd queue?
8ABA: F0 20     1577          BEQ  PR:NOT     ; nope
8ABC: AD 77 02  1578          LDA  KBD:BUF    ; get item in queue
8ABF: C9 20     1579          CMP  #$20       ; SPACE 
8AC1: D0 19     1580          BNE  PR:NOT     
8AC3: 68        1581          PLA             
8AC4: 48        1582 PAUSE    PHA             
8AC5: 98        1583          TYA             
8AC6: 48        1584          PHA             
8AC7: 20 E4 FF  1585          JSR  GETIN      ; clear that entry
                1586 PR:WAIT  EQU  *          
8ACA: 20 E4 FF  1587          JSR  GETIN      ; wait for another
8ACD: F0 FB     1588          BEQ  PR:WAIT    
8ACF: 20 E1 FF  1589          JSR  STOP       ; stop key?
8AD2: D0 06     1590          BNE  PR:ONWD    
                1591 ABORT    EQU  *          
8AD4: 20 E4 FF  1592          JSR  GETIN      ; clear keyboard buffer
8AD7: 6C 54 00  1593          JMP  (CTRLC:RT) 
8ADA: 68        1594 PR:ONWD  PLA             
8ADB: A8        1595          TAY             
                1596 PR:NOT   EQU  *          
8ADC: 68        1597          PLA             
                1598 PRCHR:X  EQU  *          
8ADD: AE D5 02  1599          LDX  XSAVE      
8AE0: 60        1600          RTS             
                1601 *
                1602 *
                1603 *
8AE1: 48        1604 PRBYTE   PHA             
8AE2: 4A        1605          LSR             
8AE3: 4A        1606          LSR             
8AE4: 4A        1607          LSR             
8AE5: 4A        1608          LSR             
8AE6: 20 EC 8A  1609          JSR  PRHEXZ     
8AE9: 68        1610          PLA             
                1611 PRHEX    EQU  *          
8AEA: 29 0F     1612          AND  #$0F       
8AEC: 09 30     1613 PRHEXZ   ORA  #$30       
8AEE: C9 3A     1614          CMP  #$3A       
8AF0: 90 02     1615          BCC  PRHEX1     
8AF2: 69 26     1616          ADC  #$26       
8AF4: 4C 74 8A  1617 PRHEX1   JMP  PRCHAR     
                1618 *
                1619 PUTSP    EQU  *          
8AF7: A9 20     1620          LDA  #'         '
8AF9: D0 F9     1621          BNE  PRHEX1     
                1622 *
                1623 PC       EQU  *          
8AFB: 48        1624          PHA             
8AFC: 20 83 8D  1625          JSR  IOSAVE     
8AFF: 68        1626          PLA             
8B00: 10 4F     1627          BPL  PC3        
8B02: A6 49     1628          LDX  RUNNING    
8B04: E0 0C     1629          CPX  #12        
8B06: D0 05     1630          BNE  PC1        ; interpreting
8B08: AD C8 02  1631 PC9      LDA  IO:A       
8B0B: 30 44     1632          BMI  PC3        
                1633 PC1      EQU  *          
8B0D: AD FD 02  1634          LDA  QT:TGL     
8B10: D0 F6     1635          BNE  PC9        
8B12: A0 00     1636          LDY  #0         
8B14: AD C8 02  1637          LDA  IO:A       
8B17: C9 B0     1638          CMP  #$B0       
8B19: 90 62     1639          BLT  PC:RSVD    
8B1B: C9 DF     1640          CMP  #$DF       
8B1D: B0 5E     1641          BGE  PC:RSVD    
8B1F: E0 40     1642          CPX  #$40       ; in Editor? 
8B21: F0 E5     1643          BEQ  PC9        
8B23: 20 F7 8A  1644          JSR  PUTSP      
8B26: A2 D0     1645          LDX  #DICT      
8B28: 86 04     1646          STX  REG        
8B2A: A2 8B     1647          LDX  #>DICT     
8B2C: 86 05     1648          STX  REG+1      
                1649 PC6      EQU  *          
8B2E: B1 04     1650          LDA  (REG),Y    
8B30: C9 FF     1651          CMP  #$FF       
8B32: F0 1D     1652          BEQ  PC7        
8B34: AD C8 02  1653          LDA  IO:A       
8B37: D1 04     1654          CMP  (REG),Y    
8B39: F0 07     1655          BEQ  PC5        
8B3B: C8        1656          INY             
8B3C: D0 F0     1657          BNE  PC6        
8B3E: E6 05     1658          INC  REG+1      
8B40: D0 EC     1659          BNE  PC6        
                1660 PC5      EQU  *          
8B42: C8        1661          INY             
8B43: D0 02     1662          BNE  PC5:A      
8B45: E6 05     1663          INC  REG+1      
                1664 PC5:A    EQU  *          
8B47: B1 04     1665          LDA  (REG),Y    
8B49: 30 09     1666          BMI  PC2        
8B4B: 20 74 8A  1667          JSR  PRCHAR     
8B4E: 4C 42 8B  1668          JMP  PC5        
                1669 PC7      EQU  *          
                1670 PC3      EQU  *          
8B51: 20 74 8A  1671          JSR  PRCHAR     
                1672 PC2      EQU  *          
8B54: 4C 8D 8D  1673          JMP  IOREST     
                1674 *
                1675 PC:LOOK  EQU  *          ; lookup reserved word for PC and ERROR
8B57: A9 B5     1676          LDA  #RSVWRD    
8B59: 85 04     1677          STA  REG        
8B5B: A9 81     1678          LDA  #>RSVWRD   
8B5D: 85 05     1679          STA  REG+1      
8B5F: C8        1680 PC:RSVD1 INY             
8B60: B1 04     1681          LDA  (REG),Y    ; token
8B62: F0 18     1682          BEQ  PC:LOOK9   ; end
8B64: CD C8 02  1683          CMP  IO:A       
8B67: F0 10     1684          BEQ  PC:RSVD2   ; found
8B69: 88        1685          DEY             
8B6A: B1 04     1686          LDA  (REG),Y    ; length
8B6C: 18        1687          CLC             
8B6D: 69 02     1688          ADC  #2         
8B6F: 65 04     1689          ADC  REG        
8B71: 85 04     1690          STA  REG        
8B73: 90 EA     1691          BCC  PC:RSVD1   
8B75: E6 05     1692          INC  REG+1      
8B77: D0 E6     1693          BNE  PC:RSVD1   
8B79: 88        1694 PC:RSVD2 DEY             
8B7A: B1 04     1695          LDA  (REG),Y    
8B7C: 60        1696 PC:LOOK9 RTS             
                1697 *
8B7D: 20 57 8B  1698 PC:RSVD  JSR  PC:LOOK    
8B80: F0 CF     1699          BEQ  PC7        ; not found
8B82: AA        1700          TAX             
8B83: C8        1701          INY             
8B84: C8        1702          INY             
8B85: B1 04     1703 PC:RSVD3 LDA  (REG),Y    
8B87: 20 74 8A  1704          JSR  PRCHAR     
8B8A: C8        1705          INY             
8B8B: CA        1706          DEX             
8B8C: D0 F7     1707          BNE  PC:RSVD3   
8B8E: 20 F7 8A  1708          JSR  PUTSP      
8B91: F0 C1     1709          BEQ  PC2        ; done!
                1710 *
                1711 *
                1712 PT       EQU  *          
8B93: 85 06     1713          STA  REG2       
8B95: 86 07     1714          STX  REG2+1     
8B97: 98        1715          TYA             
8B98: AA        1716          TAX             
8B99: A0 00     1717          LDY  #0         
8B9B: 8C FD 02  1718          STY  QT:TGL     
                1719 PT6      EQU  *          
8B9E: B1 06     1720          LDA  (REG2),Y   
8BA0: 20 FB 8A  1721          JSR  PC         
8BA3: C8        1722          INY             
8BA4: CA        1723          DEX             
8BA5: D0 F7     1724          BNE  PT6        
8BA7: 60        1725          RTS             
                1726 *
                1727 PL       EQU  *          
8BA8: 85 06     1728          STA  REG2       
8BAA: 86 07     1729          STX  REG2+1     
8BAC: A0 00     1730          LDY  #0         
8BAE: 8C FD 02  1731          STY  QT:TGL     
                1732 PL5      EQU  *          
8BB1: B1 06     1733          LDA  (REG2),Y   
8BB3: C9 10     1734          CMP  #$10       ; DLE
8BB5: F0 09     1735          BEQ  PL5A       
8BB7: 20 FB 8A  1736          JSR  PC         
8BBA: C8        1737          INY             
8BBB: C9 0D     1738          CMP  #CR        
8BBD: D0 F2     1739          BNE  PL5        
8BBF: 60        1740          RTS             
                1741 PL5A     EQU  *          
8BC0: C8        1742          INY             
8BC1: B1 06     1743          LDA  (REG2),Y   
8BC3: 29 7F     1744          AND  #$7F       ; STRIP 8-BIT
8BC5: AA        1745          TAX             
                1746 PL5B     EQU  *          
8BC6: 20 F7 8A  1747          JSR  PUTSP      
8BC9: CA        1748          DEX             
8BCA: D0 FA     1749          BNE  PL5B       
8BCC: C8        1750          INY             
8BCD: 4C B1 8B  1751          JMP  PL5        
                1752 *
                1753 *
                1754 MSG      MAC             ; MACRO DEFINITION FOR MESSAGES
                1755          DFB  ]1         ; MESSAGE NUMBER
                1756          ASC  ]2 ; MESSAGE TEXT
                1757          EOM             ; END OF MACRO
                1758 *
                1759 DICT     MSG  $B0;'p-CODES' 
8BD0: B0        1759          DFB  $B0        ; MESSAGE NUMBER
8BD1: 70 2D 43  1759          ASC  'p-CODES' ; MESSAGE TEXT
8BD4: 4F 44 45 53 
                1759          EOM             ; END OF MACRO
                1760          MSG  $B1;'FULL' 
8BD8: B1        1760          DFB  $B1        ; MESSAGE NUMBER
8BD9: 46 55 4C  1760          ASC  'FULL' ; MESSAGE TEXT
8BDC: 4C 
                1760          EOM             ; END OF MACRO
                1761          MSG  $B2;'cONSTANT' 
8BDD: B2        1761          DFB  $B2        ; MESSAGE NUMBER
8BDE: 63 4F 4E  1761          ASC  'cONSTANT' ; MESSAGE TEXT
8BE1: 53 54 41 4E 54 
                1761          EOM             ; END OF MACRO
8BE6: D0        1762          DFB  $D0        
8BE7: 70 2E 6F  1763          ASC  'p.o. bOX 124 iVANHOE ' 
8BEA: 2E 20 62 4F 58 20 31 32 
8BF2: 34 20 69 56 41 4E 48 4F 
8BFA: 45 20 
8BFC: 33 30 37  1764          ASC  '3079 vIC aUSTRALIA',0D 
8BFF: 39 20 76 49 43 20 61 55 
8C07: 53 54 52 41 4C 49 41 0D 
                1765          MSG  $B3;'iDENTIFIER' 
8C0F: B3        1765          DFB  $B3        ; MESSAGE NUMBER
8C10: 69 44 45  1765          ASC  'iDENTIFIER' ; MESSAGE TEXT
8C13: 4E 54 49 46 49 45 52 
                1765          EOM             ; END OF MACRO
                1766          MSG  $B4;'EXPECTED' 
8C1A: B4        1766          DFB  $B4        ; MESSAGE NUMBER
8C1B: 45 58 50  1766          ASC  'EXPECTED' ; MESSAGE TEXT
8C1E: 45 43 54 45 44 
                1766          EOM             ; END OF MACRO
                1767          MSG  $B5;'MISSING' 
8C23: B5        1767          DFB  $B5        ; MESSAGE NUMBER
8C24: 4D 49 53  1767          ASC  'MISSING' ; MESSAGE TEXT
8C27: 53 49 4E 47 
                1767          EOM             ; END OF MACRO
                1768          MSG  $CF;'gAMES' 
8C2B: CF        1768          DFB  $CF        ; MESSAGE NUMBER
8C2C: 67 41 4D  1768          ASC  'gAMES' ; MESSAGE TEXT
8C2F: 45 53 
                1768          EOM             ; END OF MACRO
8C31: 0D        1769          DFB  $0D        
                1770          MSG  $B6;'iLLEGAL' 
8C32: B6        1770          DFB  $B6        ; MESSAGE NUMBER
8C33: 69 4C 4C  1770          ASC  'iLLEGAL' ; MESSAGE TEXT
8C36: 45 47 41 4C 
                1770          EOM             ; END OF MACRO
                1771          MSG  $B7;'iNCORRECT' 
8C3A: B7        1771          DFB  $B7        ; MESSAGE NUMBER
8C3B: 69 4E 43  1771          ASC  'iNCORRECT' ; MESSAGE TEXT
8C3E: 4F 52 52 45 43 54 
                1771          EOM             ; END OF MACRO
                1772          MSG  $D2;'vERSION 3.1 sER# 5001'
8C44: D2        1772          DFB  $D2        ; MESSAGE NUMBER
8C45: 76 45 52  1772          ASC  'vERSION 3.1 sER# 5001' ; MESSAGE TEXT
8C48: 53 49 4F 4E 20 33 2E 31 
8C50: 20 73 45 52 23 20 35 30 
8C58: 30 31 
                1772          EOM             ; END OF MACRO
8C5A: 0D        1773          DFB  $0D        
                1774          MSG  $B8;'STRING' 
8C5B: B8        1774          DFB  $B8        ; MESSAGE NUMBER
8C5C: 53 54 52  1774          ASC  'STRING' ; MESSAGE TEXT
8C5F: 49 4E 47 
                1774          EOM             ; END OF MACRO
8C62: B9        1775          DFB  $B9        
8C63: 64 4F 20  1776          ASC  'dO YOU WANT' 
8C66: 59 4F 55 20 57 41 4E 54 
                1777          MSG  $BA;'COMPILER' 
8C6E: BA        1777          DFB  $BA        ; MESSAGE NUMBER
8C6F: 43 4F 4D  1777          ASC  'COMPILER' ; MESSAGE TEXT
8C72: 50 49 4C 45 52 
                1777          EOM             ; END OF MACRO
                1778          MSG  $D4;'<c>OMPILE' 
8C77: D4        1778          DFB  $D4        ; MESSAGE NUMBER
8C78: 3C 63 3E  1778          ASC  '<c>OMPILE' ; MESSAGE TEXT
8C7B: 4F 4D 50 49 4C 45 
                1778          EOM             ; END OF MACRO
                1779          MSG  $BB;'LITERAL' 
8C81: BB        1779          DFB  $BB        ; MESSAGE NUMBER
8C82: 4C 49 54  1779          ASC  'LITERAL' ; MESSAGE TEXT
8C85: 45 52 41 4C 
                1779          EOM             ; END OF MACRO
                1780          MSG  $BC;'MISMATCH' 
8C89: BC        1780          DFB  $BC        ; MESSAGE NUMBER
8C8A: 4D 49 53  1780          ASC  'MISMATCH' ; MESSAGE TEXT
8C8D: 4D 41 54 43 48 
                1780          EOM             ; END OF MACRO
                1781          MSG  $D5;'<s>YNTAX' 
8C92: D5        1781          DFB  $D5        ; MESSAGE NUMBER
8C93: 3C 73 3E  1781          ASC  '<s>YNTAX' ; MESSAGE TEXT
8C96: 59 4E 54 41 58 
                1781          EOM             ; END OF MACRO
                1782          MSG  $BD;'eRROR' 
8C9B: BD        1782          DFB  $BD        ; MESSAGE NUMBER
8C9C: 65 52 52  1782          ASC  'eRROR' ; MESSAGE TEXT
8C9F: 4F 52 
                1782          EOM             ; END OF MACRO
                1783          MSG  $CE;'gAMBIT' 
8CA1: CE        1783          DFB  $CE        ; MESSAGE NUMBER
8CA2: 67 41 4D  1783          ASC  'gAMBIT' ; MESSAGE TEXT
8CA5: 42 49 54 
                1783          EOM             ; END OF MACRO
                1784          MSG  $BE;'ZERO' 
8CA8: BE        1784          DFB  $BE        ; MESSAGE NUMBER
8CA9: 5A 45 52  1784          ASC  'ZERO' ; MESSAGE TEXT
8CAC: 4F 
                1784          EOM             ; END OF MACRO
                1785          MSG  $D3;'cOPYRIGHT 1983'
8CAD: D3        1785          DFB  $D3        ; MESSAGE NUMBER
8CAE: 63 4F 50  1785          ASC  'cOPYRIGHT 1983' ; MESSAGE TEXT
8CB1: 59 52 49 47 48 54 20 31 
8CB9: 39 38 33 
                1785          EOM             ; END OF MACRO
                1786          MSG  $BF;'SOURCE FILE'
8CBC: BF        1786          DFB  $BF        ; MESSAGE NUMBER
8CBD: 53 4F 55  1786          ASC  'SOURCE FILE' ; MESSAGE TEXT
8CC0: 52 43 45 20 46 49 4C 45 
                1786          EOM             ; END OF MACRO
                1787          MSG  $D7;'<q>UIT' 
8CC8: D7        1787          DFB  $D7        ; MESSAGE NUMBER
8CC9: 3C 71 3E  1787          ASC  '<q>UIT' ; MESSAGE TEXT
8CCC: 55 49 54 
                1787          EOM             ; END OF MACRO
                1788          MSG  $C0;'OF'   
8CCF: C0        1788          DFB  $C0        ; MESSAGE NUMBER
8CD0: 4F 46     1788          ASC  'OF' ; MESSAGE TEXT
                1788          EOM             ; END OF MACRO
                1789          MSG  $C1;'OR'   
8CD2: C1        1789          DFB  $C1        ; MESSAGE NUMBER
8CD3: 4F 52     1789          ASC  'OR' ; MESSAGE TEXT
                1789          EOM             ; END OF MACRO
                1790          MSG  $C2;'TO'   
8CD5: C2        1790          DFB  $C2        ; MESSAGE NUMBER
8CD6: 54 4F     1790          ASC  'TO' ; MESSAGE TEXT
                1790          EOM             ; END OF MACRO
8CD8: D1 05 0E  1791          DFB  $D1,5,14   ; white; lowercase
8CDB: 67 2D 70  1792          ASC  'g-pASCAL'
8CDE: 41 53 43 41 4C 
                1793          MSG  $C3;'ENDED AT '
8CE3: C3        1793          DFB  $C3        ; MESSAGE NUMBER
8CE4: 45 4E 44  1793          ASC  'ENDED AT ' ; MESSAGE TEXT
8CE7: 45 44 20 41 54 20 
                1793          EOM             ; END OF MACRO
                1794          MSG  $C4;'sYMBOL' 
8CED: C4        1794          DFB  $C4        ; MESSAGE NUMBER
8CEE: 73 59 4D  1794          ASC  'sYMBOL' ; MESSAGE TEXT
8CF1: 42 4F 4C 
                1794          EOM             ; END OF MACRO
                1795          MSG  $D6;'wRITTEN BY nICK gAMMON '
8CF4: D6        1795          DFB  $D6        ; MESSAGE NUMBER
8CF5: 77 52 49  1795          ASC  'wRITTEN BY nICK gAMMON ' ; MESSAGE TEXT
8CF8: 54 54 45 4E 20 42 59 20 
8D00: 6E 49 43 4B 20 67 41 4D 
8D08: 4D 4F 4E 20 
                1795          EOM             ; END OF MACRO
8D0C: 41 4E 44  1796          ASC  'AND sUE gOBBETT',0D 
8D0F: 20 73 55 45 20 67 4F 42 
8D17: 42 45 54 54 0D 
                1797          MSG  $C6;'sTACK' 
8D1C: C6        1797          DFB  $C6        ; MESSAGE NUMBER
8D1D: 73 54 41  1797          ASC  'sTACK' ; MESSAGE TEXT
8D20: 43 4B 
                1797          EOM             ; END OF MACRO
                1798          MSG  $C7;'iNSTRUCTION' 
8D22: C7        1798          DFB  $C7        ; MESSAGE NUMBER
8D23: 69 4E 53  1798          ASC  'iNSTRUCTION' ; MESSAGE TEXT
8D26: 54 52 55 43 54 49 4F 4E 
                1798          EOM             ; END OF MACRO
                1799          MSG  $D8;'rANGE' 
8D2E: D8        1799          DFB  $D8        ; MESSAGE NUMBER
8D2F: 72 41 4E  1799          ASC  'rANGE' ; MESSAGE TEXT
8D32: 47 45 
                1799          EOM             ; END OF MACRO
                1800          MSG  $C8;'TABLE' 
8D34: C8        1800          DFB  $C8        ; MESSAGE NUMBER
8D35: 54 41 42  1800          ASC  'TABLE' ; MESSAGE TEXT
8D38: 4C 45 
                1800          EOM             ; END OF MACRO
                1801          MSG  $C9;'tYPE' 
8D3A: C9        1801          DFB  $C9        ; MESSAGE NUMBER
8D3B: 74 59 50  1801          ASC  'tYPE' ; MESSAGE TEXT
8D3E: 45 
                1801          EOM             ; END OF MACRO
                1802          MSG  $CA;'LIST' 
8D3F: CA        1802          DFB  $CA        ; MESSAGE NUMBER
8D40: 4C 49 53  1802          ASC  'LIST' ; MESSAGE TEXT
8D43: 54 
                1802          EOM             ; END OF MACRO
8D44: CB        1803          DFB  $CB        
8D45: 3F 20 79  1804          ASC  '? y/n '   
8D48: 2F 6E 20 
                1805          MSG  $CC;'nUMBER' 
8D4B: CC        1805          DFB  $CC        ; MESSAGE NUMBER
8D4C: 6E 55 4D  1805          ASC  'nUMBER' ; MESSAGE TEXT
8D4F: 42 45 52 
                1805          EOM             ; END OF MACRO
                1806          MSG  $CD;'lINE' 
8D52: CD        1806          DFB  $CD        ; MESSAGE NUMBER
8D53: 6C 49 4E  1806          ASC  'lINE' ; MESSAGE TEXT
8D56: 45 
                1806          EOM             ; END OF MACRO
                1807          MSG  $D9;'pARAMETER' 
8D57: D9        1807          DFB  $D9        ; MESSAGE NUMBER
8D58: 70 41 52  1807          ASC  'pARAMETER' ; MESSAGE TEXT
8D5B: 41 4D 45 54 45 52 
                1807          EOM             ; END OF MACRO
                1808          MSG  $DA;'<e>DIT,' 
8D61: DA        1808          DFB  $DA        ; MESSAGE NUMBER
8D62: 3C 65 3E  1808          ASC  '<e>DIT,' ; MESSAGE TEXT
8D65: 44 49 54 2C 
                1808          EOM             ; END OF MACRO
                1809          MSG  $DB;'<'    
8D69: DB        1809          DFB  $DB        ; MESSAGE NUMBER
8D6A: 3C        1809          ASC  '<' ; MESSAGE TEXT
                1809          EOM             ; END OF MACRO
8D6B: FF        1810 EDICT    DFB  $FF        
                1811 *
                1812 GETANS   EQU  *          
8D6C: 20 93 8B  1813          JSR  PT         
8D6F: 20 AD 8D  1814          JSR  RDKEY      
8D72: 29 7F     1815          AND  #$7F       
8D74: 48        1816          PHA             
8D75: C9 20     1817          CMP  #$20       
8D77: B0 02     1818          BGE  GET1       
8D79: A9 20     1819          LDA  #$20       
                1820 GET1     EQU  *          
8D7B: 20 FB 8A  1821          JSR  PC         
8D7E: 20 55 81  1822          JSR  CROUT      
8D81: 68        1823          PLA             
                1824 GETAN9   EQU  *          
8D82: 60        1825          RTS             
                1826 *
                1827 *
                1828 IOSAVE   EQU  *          
8D83: 8D C8 02  1829          STA  IO:A       
8D86: 8E CA 02  1830          STX  IO:X       
8D89: 8C C9 02  1831          STY  IO:Y       
8D8C: 60        1832          RTS             
                1833 *
                1834 IOREST   EQU  *          
8D8D: AC C9 02  1835          LDY  IO:Y       
8D90: AE CA 02  1836          LDX  IO:X       
8D93: AD C8 02  1837          LDA  IO:A       
8D96: 60        1838          RTS             
                1839 *
                1840 *---- TKNADR --> WORK
                1841 *
                1842 TKNWRK   EQU  *          
8D97: 48        1843          PHA             
8D98: A5 17     1844          LDA  TKNADR     
8D9A: 85 3C     1845          STA  WORK       
8D9C: A5 18     1846          LDA  TKNADR+1   
8D9E: 85 3D     1847          STA  WORK+1     
8DA0: 68        1848          PLA             
8DA1: 60        1849          RTS             
                1850 *
                1851 *---- WORK --> TKNADR
                1852 *
                1853 WRKTKN   EQU  *          
8DA2: 48        1854          PHA             
8DA3: A5 3C     1855          LDA  WORK       
8DA5: 85 17     1856          STA  TKNADR     
8DA7: A5 3D     1857          LDA  WORK+1     
8DA9: 85 18     1858          STA  TKNADR+1   
8DAB: 68        1859          PLA             
8DAC: 60        1860          RTS             
                1861 *
                1862 *
                1863 RDKEY    EQU  *          
8DAD: A9 00     1864          LDA  #0         
8DAF: 85 CC     1865          STA  BLNSW      ; blink cursor
8DB1: 8D 92 02  1866          STA  AUTODN     ; scroll
8DB4: 20 E4 FF  1867          JSR  GETIN      
8DB7: C9 00     1868          CMP  #0         
8DB9: F0 F2     1869          BEQ  RDKEY      ; LOOP UNTIL GOT A CHARACTER
8DBB: 48        1870          PHA             
8DBC: A9 00     1871          LDA  #0         
8DBE: 85 CF     1872          STA  BLNON      
8DC0: 68        1873          PLA             
8DC1: 85 CC     1874          STA  BLNSW      ; stop blinking
8DC3: 60        1875          RTS             
                1876 *
                1877 HOME     EQU  *          
8DC4: A9 93     1878          LDA  #147       
8DC6: 4C D2 FF  1879          JMP  COUT       
                1880 *
                1881 *
8DC9: 00        1883          DFB  0          ; END OF FILE


--End assembly, 3530 bytes, Errors: 0 

