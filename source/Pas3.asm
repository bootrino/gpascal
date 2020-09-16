                     ************************************************
                2    * PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 3
                5    * Authors: Nick Gammon & Sue Gobbett
                6    *   SYM $9000
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
                26   ENABRS   EQU  $2A1       ; RS232 enables
                27   WARM:STR EQU  $302       ; basic warm start vector
                28   CINV     EQU  $314       ; hardware interrupt vector
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
                80   LINE:CNT EQU  $2         ; 2 BYTES
                81   LINE:NO  EQU  LINE:CNT   
                82   REG      EQU  $4         ; 2 BYTES
                83   ROWL     EQU  REG        
                84   ROWH     EQU  REG+1      
                85   SRCE     EQU  REG        
                86   REG2     EQU  $6         ; 2 BYTES
                87   DEST     EQU  REG2       
                88   WX       EQU  $8         ; 2 BYTES
                89   ERR:RTN  EQU  $B         ; 2 BYTES
                90   SYMTBL   EQU  $D         
                91   TOKEN    EQU  $16        
                92   TKNADR   EQU  $17        ; 2 BYTES
                93   TKNLEN   EQU  $19        
                94   EOF      EQU  $1A        
                95   LIST     EQU  $1B        
                96   NXTCHR   EQU  $1C        ; 2 BYTES
                97   VALUE    EQU  $1E        ; 3 BYTES
                98   DIGIT    EQU  $21        
                99   NOTRSV   EQU  $22        
                100  FRAME    EQU  $23        ; 2 BYTES
                101  LEVEL    EQU  $25        
                102  PCODE    EQU  $26        
                103  P        EQU  PCODE      
                104  PNTR     EQU  PCODE      
                105  ACT:PCDA EQU  $28        ; 2 BYTES
                106  DISPL    EQU  $2A        ; 2 BYTES
                107  OFFSET   EQU  $2C        ; 2 BYTES
                108  OPND     EQU  $2E        ; 3 BYTES
                109  DCODE    EQU  $31        
                110  ENDSYM   EQU  $32        ; 2 BYTES
                111  ARG      EQU  $34        
                112  PROMPT   EQU  $35        
                113  WORKD    EQU  $36        ; 2 BYTES
                114  ERRNO    EQU  $38        
                115  RTNADR   EQU  $39        ; 2 BYTES
                116  BSAVE    EQU  $3B        
                117  WORK     EQU  $3C        ; 2 BYTES
                118  PRCITM   EQU  $3E        ; 2 BYTES
                119  DSPWRK   EQU  $40        ; 2 BYTES
                120  PFLAG    EQU  $42        
                121  T        EQU  ENDSYM     ; STACK POINTER 2 BYTES
                122  TMP:PNTR EQU  T          
                123  BASE     EQU  $45        ; 2 BYTES
                124  TO       EQU  BASE       
                125  DATA     EQU  $47        ; 2 BYTES
                126  RUNNING  EQU  $49        
                127  UPR:CASE EQU  $4A        
                128  SCE:LIM  EQU  $4B        ; 2 BYTES
                129  FUNCTION EQU  SCE:LIM    
                130  SPRITENO EQU  SCE:LIM+1  
                131  STK:USE  EQU  $4D        
                132  VOICENO  EQU  STK:USE    
                133  SYMITM   EQU  $4E        ; 2 BYTES
                134  FROM     EQU  SYMITM     
                135  SYNTAX   EQU  $50        
                136  CHK:ARY  EQU  $51        
                137  SECRET   EQU  $52        
                138  VAL:CMP  EQU  $53        
                139  CTRLC:RT EQU  $54        ; 2 BYTES
                140  END:PCD  EQU  $56        ; 2 BYTES
                141  REGB     EQU  $58        
                142  REG2B    EQU  $59        
                143  LEFTCOL  EQU  $5A        
                144  SIGN     EQU  $5B        
                145  TEMP     EQU  $5C        ; 2 BYTES
                146  CALL     EQU  $5E        ; 2 BYTES
                147  COUNT    EQU  $60        
                148  LNCNT    EQU  $61        
                149  LS       EQU  $62        
                150  PCSVD    EQU  $63        ; 2 BYTES
                151  FIRST    EQU  $65        
                152  DBGTYP   EQU  $66        
                153  DBGFLG   EQU  $67        
                154  DEFP     EQU  $68        ; 2 BYTES
                155  DEFS     EQU  $6A        ; 2 BYTES
                156  DATTYP   EQU  $6C        
                157  DOS:FLG  EQU  DATTYP     
                158  A5       EQU  $6D        ; 2 BYTES
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
                188  SYM:USE  DS   2          ; 2 BYTES
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
800F: 3A        276  DELIMIT  ASC  ':' ; FIND/REPLACE DELIMITER
8010: 04        277  PR:CHAN  DFB  4          ; PRINTER CHANNEL
8011: 08        278  DISK:CHN DFB  8          ; DISK CHANNEL
8012: 00        279           DFB  0          ; SPARE FOR NOW
                280           DEND            
                281  *
                     ************************************************
                283  * PART 1 VECTORS
                     ************************************************
                285  V1       EQU  P1         
                286  INIT     EQU  V1         
                287  GETNEXT  EQU  V1+3       
                288  COMSTL   EQU  V1+6       
                289  ISITHX   EQU  V1+9       
                290  ISITAL   EQU  V1+12      
                291  ISITNM   EQU  V1+15      
                292  CHAR     EQU  V1+18      
                293  GEN2:B   EQU  V1+21      
                294  DISHX    EQU  V1+24      
                295  ERROR    EQU  V1+27      
                296  GETCHK   EQU  V1+30      
                297  CHKTKN   EQU  V1+33      
                298  GENNOP   EQU  V1+36      
                299  GENADR   EQU  V1+39      
                300  GENNJP   EQU  V1+42      
                301  GENNJM   EQU  V1+45      
                302  TKNWRK   EQU  V1+48      
                303  PRBYTE   EQU  V1+51      
                304  GTOKEN   EQU  V1+54      
                305  SPARE2   EQU  V1+57      
                306  FIXAD    EQU  V1+60      
                307  PSHWRK   EQU  V1+63      
                308  PULWRK   EQU  V1+66      
                309  PC       EQU  V1+69      
                310  PT       EQU  V1+72      
                311  PL       EQU  V1+75      
                312  TOKEN1   EQU  V1+78      
                313  GETANS   EQU  V1+81      
                314  PUTSP    EQU  V1+84      
                315  DISPAD   EQU  V1+87      
                316  CROUT    EQU  V1+90      
                317  SHLVAL   EQU  V1+93      
                318  GET:NUM  EQU  V1+96      
                319  GET:HEX  EQU  V1+99      
                320  FND:END  EQU  V1+102     
                321  PAUSE    EQU  V1+105     
                322  HOME     EQU  V1+108     
                323  RDKEY    EQU  V1+111     
                324  GENJMP   EQU  V1+114     
                325  GENRJMP  EQU  V1+117     
                326  US       EQU  V1+120     
                327  V1:NEXT  EQU  V1+23      ; AVAILABLE
                     ************************************************
                329  * PART 2 VECTORS
                     ************************************************
                331  V2       EQU  P2         
                332  TKNJMP   EQU  V2+60      
                333  *
                334  *
                     ************************************************
                336  * PART 4 VECTORS
                     ************************************************
                338  INTERJ   EQU  P4         
                339  DIS4     EQU  P4+3       
                340  BREAK    EQU  P4+6       
                341  CHK:ERR  EQU  P4+9       ; invalid parameter in function call
                342  MAIN     EQU  P4+12      
                343  MAINP    EQU  P4+15      
                344  CHK:TOP  EQU  P4+18      
                345  TRUE2    EQU  P4+21      
                346  PULTOP   EQU  P4+24      
                347  S:PNT2   EQU  P4+27      
                348  MASKS    EQU  P4+30      ; 8 bytes
                349  XMASKS   EQU  P4+38      ; 8 bytes
                350  *
                     ************************************************
                352  * PART 5 VECTORS
                     ************************************************
                354  EDITOR   EQU  P5         
                355  GETLN    EQU  P5+3       
                356  GETLNZ   EQU  P5+6       
                357  GETLN1   EQU  P5+9       
                     ************************************************
                359  *
                360  * PART 6 VECTORS
                     ************************************************
                362  BLOCK    EQU  P6         
                363  *
                     ************************************************
                365  * PART 3 STARTS HERE
                     ************************************************
                367           ORG  P3         
                     ************************************************
                369  * PART 3 VECTORS
                     ************************************************
992E: 4C 11 9B  371           JMP  START      
9931: 4C 50 9B  372           JMP  RESTART    
9934: 4C 9E 9E  373           JMP  DSP:BIN    
9937: 4C D9 9B  374           JMP  ST:CMP     
993A: 4C E0 9B  375           JMP  ST:SYN     
993D: 4C 71 9F  376           JMP  DEBUG      
9940: 4C EE 9B  377           JMP  ST:EDI     
9943: 4C F1 9B  378           JMP  ST:FIL     
9946: 4C CF 9A  379           JMP  BELL1X     
9949: 4C 38 A0  380           JMP  MOV:SPT    
994C: 4C 2F A0  381           JMP  SPT:STAT   
994F: 4C 21 A1  382           JMP  SPRT:X     
9952: 4C 3A A1  383           JMP  SPRT:Y     
9955: 4C 45 A1  384           JMP  STOP:SPT   
9958: 4C 52 A1  385           JMP  STRT:SPT   
995B: 4C C2 A0  386           JMP  ANM:SPT    
995E: 4C D5 A2  387           JMP  LOADIT     
9961: 4C F1 A2  388           JMP  SAVEIT     
9964: 4C 50 A3  389           JMP  FREEZE:S   
9967: 4C 7B A3  390           JMP  FR:STAT    
996A: 4C 0F A3  391           JMP  X:OPEN     
996D: 4C 29 A3  392           JMP  X:CLOSE    
9970: 4C 32 A3  393           JMP  X:PUT      
9973: 4C 3E A3  394           JMP  X:GET      
                     ************************************************
                396  *
                397  * COMPILER MAINLINE
                398  *
9976: B0 C3     399  ENDMSG   HEX  B0C3       
9978: D4        400  ENDMG2   DFB  $D4        
9979: 20 46 49  401           ASC  ' FINISHED: NO',BD 
997C: 4E 49 53 48 45 44 3A 20 
9984: 4E 4F BD 
9987: 53 0D     402           ASC  'S',0D
9989: 0D DB     403  FIL:MSG  DFB  $0D,$DB    
998B: 6C 3E 4F  404           ASC  'l>OAD,',DB
998E: 41 44 2C DB 
9992: 61 3E 50  405           ASC  'a>PPEND, ',DB 
9995: 50 45 4E 44 2C 20 DB 
999C: 70 3E 52  406           ASC  'p>RINT, ',DB 
999F: 49 4E 54 2C 20 DB 
99A5: 64 3E 4F  407           ASC  'd>OS,'
99A8: 53 2C 
99AA: 0D DB     408           DFB  $0D,$DB    
99AC: 73 3E 41  409           ASC  's>AVE,',DB
99AF: 56 45 2C DB 
99B3: 6E 3E 4F  410           ASC  'n>OPRINT,',DB
99B6: 50 52 49 4E 54 2C DB 
99BD: 76 3E 45  411           ASC  'v>ERIFY,',D7
99C0: 52 49 46 59 2C D7 
99C6: 2C        412           ASC  ','
99C7: 0D DA DB  413           DFB  $0D,$DA,$DB 
99CA: 63 3E 41  414           ASC  'c>ATALOG,',DB
99CD: 54 41 4C 4F 47 2C DB 
99D4: 6F 3E 42  415           ASC  'o>BJECT ? ' 
99D7: 4A 45 43 54 20 3F 20 
99DE: 0D DA D4  416  MSG1     DFB  $0D,$DA,$D4 
99E1: 2C DB     417           ASC  ',',DB
99E3: 64 3E 45  418           ASC  'd>EBUG,',DB
99E6: 42 55 47 2C DB 
99EB: 66 3E 49  419           ASC  'f>ILES,',0D
99EE: 4C 45 53 2C 0D 
99F3: DB        420           DFB  $DB        
99F4: 72 3E 55  421           ASC  'r>UN, ',D5 
99F7: 4E 2C 20 D5 
99FB: 2C 20 DB  422           ASC  ', ',DB    
99FE: 74 3E 52  423           ASC  't>RACE,',D7
9A01: 41 43 45 2C D7 
9A06: 20 3F 20  424           ASC  ' ? '      
9A09: C4 C8 C3  425  MSG4     HEX  C4C8C3     
9A0C: 6E 4F 20  426  MSG6     ASC  'nO VALID',D4 
9A0F: 56 41 4C 49 44 D4 
9A15: 20 44 4F  427           ASC  ' DONE BEFORE',0D 
9A18: 4E 45 20 42 45 46 4F 52 
9A20: 45 0D 
                428  *
                429  PRBYTECR EQU  *          
9A22: 20 46 80  430           JSR  PRBYTE     
9A25: 4C 6D 80  431           JMP  CROUT      
                432  *
                433  DOS:COLD EQU  *          
9A28: A2 00     434           LDX  #0         
9A2A: A0 A0     435           LDY  #$A0       
9A2C: 18        436           CLC             
9A2D: 20 99 FF  437           JSR  MEMTOP     ; normal Basic top of memory
9A30: A9 2F     438           LDA  #47        
9A32: 85 01     439           STA  $1         ; MAKE BASIC AVAILABLE
9A34: 6C 00 A0  440           JMP  ($A000)    
                441  *
                442  *
                443  *
9A37: A2 FF     444  COMPIL   LDX  #NEW:STK   
9A39: 9A        445           TXS             
9A3A: A2 00     446           LDX  #0         
9A3C: A0 D0     447           LDY  #$D0       ; use spare memory 
9A3E: 18        448           CLC             
9A3F: 20 99 FF  449           JSR  MEMTOP     ; set top of memory 
9A42: A9 EE     450           LDA  #ST:EDI    
9A44: 85 0B     451           STA  ERR:RTN    
9A46: A9 9B     452           LDA  #>ST:EDI   
9A48: 85 0C     453           STA  ERR:RTN+1  
9A4A: AD 84 02  454           LDA  HIMEM+1    
9A4D: 38        455           SEC             
9A4E: ED 0B 80  456           SBC  SYM:SIZE   
9A51: 85 0E     457           STA  SYMTBL+1   
9A53: AD 83 02  458           LDA  HIMEM      
9A56: 85 0D     459           STA  SYMTBL     
9A58: 8D A9 02  460           STA  SYM:USE    
9A5B: 85 32     461           STA  ENDSYM     
                462  *
                463  *
9A5D: 20 7F 80  464           JSR  HOME       
9A60: 20 13 80  465           JSR  INIT       
9A63: 20 49 80  466           JSR  GTOKEN     
9A66: A0 00     467           LDY  #0         
9A68: 84 53     468           STY  VAL:CMP    
9A6A: 98        469           TYA             
9A6B: 91 32     470           STA  (ENDSYM),Y 
9A6D: C8        471           INY             
9A6E: 91 32     472           STA  (ENDSYM),Y 
9A70: 20 B8 BC  473           JSR  BLOCK      
9A73: A9 2E     474           LDA  #'.'       
9A75: A2 09     475           LDX  #9         
9A77: 20 34 80  476           JSR  CHKTKN     
9A7A: A9 00     477           LDA  #0         
9A7C: A2 13     478           LDX  #19        
9A7E: 20 31 80  479           JSR  GETCHK     
9A81: 20 6D 80  480           JSR  CROUT      
9A84: A9 76     481           LDA  #ENDMSG    
9A86: A2 99     482           LDX  #>ENDMSG   
9A88: A0 02     483           LDY  #2         
9A8A: 20 5B 80  484           JSR  PT         
9A8D: A5 27     485           LDA  PCODE+1    
9A8F: 85 57     486           STA  END:PCD+1  
9A91: 20 46 80  487           JSR  PRBYTE     
9A94: A5 26     488           LDA  PCODE      
9A96: 85 56     489           STA  END:PCD    
9A98: 20 22 9A  490           JSR  PRBYTECR   
9A9B: A9 09     491           LDA  #MSG4      
9A9D: A2 9A     492           LDX  #>MSG4     
9A9F: A0 03     493           LDY  #3         
9AA1: 20 5B 80  494           JSR  PT         
9AA4: AD AA 02  495           LDA  SYM:USE+1  
9AA7: 20 46 80  496           JSR  PRBYTE     
9AAA: AD A9 02  497           LDA  SYM:USE    
9AAD: 20 22 9A  498           JSR  PRBYTECR   
9AB0: A9 78     499           LDA  #ENDMG2    
9AB2: A2 99     500           LDX  #>ENDMG2   
9AB4: 20 5E 80  501           JSR  PL         
9AB7: A6 50     502           LDX  SYNTAX     
9AB9: D0 03     503           BNE  END:CMP    
9ABB: E8        504           INX             
9ABC: 86 53     505           STX  VAL:CMP    
                506  END:CMP  EQU  *          
9ABE: 4C 99 9B  507           JMP  ST1        
                508  *
                509  CHK:VAL  EQU  *          
9AC1: A5 53     510           LDA  VAL:CMP    
9AC3: D0 0A     511           BNE  CHK:VAL9   
9AC5: A9 0C     512           LDA  #MSG6      
9AC7: A2 9A     513           LDX  #>MSG6     
9AC9: 20 5E 80  514           JSR  PL         
9ACC: 4C 99 9B  515           JMP  ST1        
                516  CHK:VAL9 EQU  *          
                517  BELL1X   EQU  *          ; no bell yet 
9ACF: 60        518           RTS             
                519  *
9AD0: 20 C1 9A  520  CHK:RUN  JSR  CHK:VAL    
9AD3: 4C DD 9F  521           JMP  INTERP     
                522  *
                523  *
                524  * START
                525  *
                526  MAIN:TBL EQU  *          
9AD6: 43        527           ASC  'C'
9AD7: D9 9B     528           DA   ST:CMP     
9AD9: 52        529           ASC  'R'
9ADA: E5 9B     530           DA   ST:RUN     
9ADC: 53        531           ASC  'S'
9ADD: E0 9B     532           DA   ST:SYN     
9ADF: 45        533           ASC  'E'
9AE0: EE 9B     534           DA   ST:EDI     
9AE2: 51        535           ASC  'Q'
9AE3: 0B 9C     536           DA   ST:QUI     
9AE5: 44        537           ASC  'D'
9AE6: 1B 9C     538           DA   ST:DEB     
9AE8: 54        539           ASC  'T'
9AE9: 22 9C     540           DA   ST:TRA     
9AEB: 46        541           ASC  'F'
9AEC: F1 9B     542           DA   ST:FIL     
9AEE: 00        543           DFB  $0         
                544  FIL:TBL  EQU  *          
9AEF: 45        545           ASC  'E'
9AF0: EE 9B     546           DA   ST:EDI     
9AF2: 51        547           ASC  'Q'
9AF3: 99 9B     548           DA   ST1        
9AF5: 41        549           ASC  'A'
9AF6: E8 9D     550           DA   ST:APP     
9AF8: 4C        551           ASC  'L'
9AF9: A4 9D     552           DA   ST:LOA     
9AFB: 53        553           ASC  'S'
9AFC: D1 9D     554           DA   ST:WRI     
9AFE: 56        555           ASC  'V'
9AFF: 6B 9D     556           DA   ST:VFY     
9B01: 50        557           ASC  'P'
9B02: 2B 9C     558           DA   ST:PRI     
9B04: 4E        559           ASC  'N'
9B05: 31 9C     560           DA   ST:NOP     
9B07: 4F        561           ASC  'O'
9B08: B7 9D     562           DA   ST:OBJ     
9B0A: 43        563           ASC  'C'
9B0B: E6 9C     564           DA   ST:CAT     
9B0D: 44        565           ASC  'D'
9B0E: 07 9E     566           DA   ST:DOS     
9B10: 00        567           DFB  $0         
                568  *
                569  *
                570  *
                571  *
                572  * here for cold start - initialize all C64 routines
                573  * do ram test, clear text file to null etc. etc.
                574  *
                575  START    EQU  *          
9B11: 78        576           SEI             
9B12: A2 00     577           LDX  #0         
9B14: 8E 16 D0  578           STX  VIC+$16    ; clear reset bit in VIC 
9B17: CA        579           DEX             
9B18: 9A        580           TXS             
9B19: 20 84 FF  581           JSR  IOINIT     
9B1C: EA        582           NOP             
9B1D: EA        583           NOP             
9B1E: EA        584           NOP             ; instead of JSR RAMTAS 
9B1F: 20 8A FF  585           JSR  RESTOR     
9B22: 20 81 FF  586           JSR  CINT       
9B25: 20 B7 9B  587           JSR  INITIO     
9B28: 58        588           CLI             
9B29: AD 09 80  589           LDA  TS         
9B2C: 85 04     590           STA  REG        
9B2E: AD 0A 80  591           LDA  TS+1       
9B31: 85 05     592           STA  REG+1      
9B33: A9 00     593           LDA  #0         
9B35: A8        594           TAY             
9B36: 91 04     595           STA  (REG),Y    ; NULL EDIT FILE 
9B38: 84 53     596           STY  VAL:CMP    
9B3A: AA        597           TAX             
9B3B: A0 D0     598           LDY  #$D0       ; use spare memory 
9B3D: 18        599           CLC             
9B3E: 20 99 FF  600           JSR  MEMTOP     ; set top of memory 
9B41: AD 14 03  601           LDA  CINV       
9B44: 8D F8 02  602           STA  INT:RTN    
9B47: AD 15 03  603           LDA  CINV+1     
9B4A: 8D F9 02  604           STA  INT:RTN+1  ; interrupt return address
9B4D: 4C 6B 9B  605           JMP  REST1      
                606  *
                607  RESTART  EQU  *          
9B50: 78        608           SEI             
9B51: AD F8 02  609           LDA  INT:RTN    
9B54: 8D 14 03  610           STA  CINV       
9B57: AD F9 02  611           LDA  INT:RTN+1  
9B5A: 8D 15 03  612           STA  CINV+1     
9B5D: 58        613           CLI             
9B5E: D8        614           CLD             
9B5F: A2 FF     615           LDX  #$FF       
9B61: 9A        616           TXS             ; reset stack
9B62: 20 E7 FF  617           JSR  CLALL      ; close any files run left open
9B65: 20 81 FF  618           JSR  CINT       ; reset video
9B68: 20 B7 9B  619           JSR  INITIO     
                620  *
                621  REST1    EQU  *          
9B6B: 20 66 9E  622           JSR  PROFF      
9B6E: A9 C0     623           LDA  #$C0       
9B70: 20 90 FF  624           JSR  SETMSG     
9B73: A9 00     625           LDA  #0         
9B75: 85 49     626           STA  RUNNING    
9B77: A9 06     627           LDA  #6         ; BLUE
9B79: 8D 20 D0  628           STA  BORDER     
9B7C: 8D 21 D0  629           STA  BKGND      ; BACKGROUND TO BLUE
9B7F: A9 50     630           LDA  #RESTART   
9B81: 8D 02 03  631           STA  WARM:STR   
9B84: 85 54     632           STA  CTRLC:RT   
9B86: A9 9B     633           LDA  #>RESTART  
9B88: 8D 03 03  634           STA  WARM:STR+1 
9B8B: 85 55     635           STA  CTRLC:RT+1 
9B8D: 20 7F 80  636           JSR  HOME       
9B90: A9 8B     637           LDA  #US        
9B92: A2 80     638           LDX  #>US       
9B94: A0 08     639           LDY  #8         
9B96: 20 5B 80  640           JSR  PT         
9B99: A9 DE     641  ST1      LDA  #MSG1      
9B9B: A2 99     642           LDX  #>MSG1     
9B9D: A0 2B     643           LDY  #43        
9B9F: 20 64 80  644           JSR  GETANS     
9BA2: A2 D6     645           LDX  #MAIN:TBL  
9BA4: A0 9A     646           LDY  #>MAIN:TBL 
                647  *
9BA6: 20 10 8E  648           JSR  TKNJMP     
9BA9: 4C 99 9B  649  ST1:JUMP JMP  ST1        
                650  *
                651  *
                652  ZERO:SID EQU  *          
9BAC: A0 18     653           LDY  #24        
9BAE: A9 00     654           LDA  #0         
9BB0: 99 00 D4  655  ZERO:1   STA  SID,Y      
9BB3: 88        656           DEY             
9BB4: 10 FA     657           BPL  ZERO:1     
9BB6: 60        658           RTS             
                659  *
                660  INITIO   EQU  *          
9BB7: 20 84 FF  661           JSR  IOINIT     
9BBA: 20 E7 FF  662           JSR  CLALL      
9BBD: 20 AC 9B  663           JSR  ZERO:SID   
9BC0: A9 2F     664           LDA  #47        
9BC2: 85 00     665           STA  $0         ; data direction register
9BC4: A9 2E     666           LDA  #46        
9BC6: 85 01     667           STA  $1         ; disable Basic
9BC8: A9 00     668           LDA  #0         
9BCA: 85 F8     669           STA  $F8        ; de-allocate RS232 buffers
9BCC: 85 FA     670           STA  $FA        
9BCE: 85 90     671           STA  ST         ; clear ST flag 
9BD0: 8D A1 02  672           STA  ENABRS     ; clear RS232 enables
9BD3: A9 04     673           LDA  #4         
9BD5: 8D 88 02  674           STA  HIBASE     ; normal video page
9BD8: 60        675           RTS             
                676  *
                677  ST:CMP   EQU  *          
9BD9: A9 00     678           LDA  #0         
9BDB: 85 50     679           STA  SYNTAX     
9BDD: 4C 37 9A  680           JMP  COMPIL     
                681  ST:SYN   EQU  *          
9BE0: 85 50     682           STA  SYNTAX     
9BE2: 4C 37 9A  683           JMP  COMPIL     
                684  ST:RUN   EQU  *          
9BE5: A9 00     685           LDA  #0         
9BE7: 85 67     686           STA  DBGFLG     
9BE9: 85 31     687           STA  DCODE      
9BEB: 4C D0 9A  688           JMP  CHK:RUN    
                689  ST:EDI   EQU  *          
9BEE: 4C 84 B3  690           JMP  EDITOR     
                691  ST:FIL   EQU  *          
9BF1: A2 FF     692           LDX  #$FF       
9BF3: 9A        693           TXS             ; reset stack
9BF4: A9 89     694           LDA  #FIL:MSG   
9BF6: A2 99     695           LDX  #>FIL:MSG  
9BF8: A0 55     696           LDY  #85        
9BFA: 20 64 80  697           JSR  GETANS     
9BFD: A2 EF     698           LDX  #FIL:TBL   
9BFF: A0 9A     699           LDY  #>FIL:TBL  
9C01: 85 16     700           STA  TOKEN      ; in case we want to know
9C03: 20 10 8E  701           JSR  TKNJMP     
                702  ST:FIL9  EQU  *          
9C06: 4C F1 9B  703           JMP  ST:FIL     
                704  *
9C09: D7 CB     705  QUIT:MSG DFB  $D7,$CB    
                706  ST:QUI   EQU  *          
9C0B: A9 09     707           LDA  #QUIT:MSG  
9C0D: A2 9C     708           LDX  #>QUIT:MSG 
9C0F: A0 02     709           LDY  #2         
9C11: 20 64 80  710           JSR  GETANS     
9C14: C9 59     711           CMP  #'Y'       
9C16: D0 91     712           BNE  ST1:JUMP   
9C18: 4C 28 9A  713           JMP  DOS:COLD   ; COLDSTART DOS
                714  ST:DEB   EQU  *          
9C1B: 85 67     715           STA  DBGFLG     
9C1D: 85 31     716           STA  DCODE      
9C1F: 4C D0 9A  717           JMP  CHK:RUN    
                718  ST:TRA   EQU  *          
9C22: 09 80     719           ORA  #$80       
9C24: 85 67     720           STA  DBGFLG     
9C26: 85 31     721           STA  DCODE      
9C28: 4C D0 9A  722           JMP  CHK:RUN    
                723  ST:PRI   EQU  *          
9C2B: 20 55 9E  724           JSR  PRON       
9C2E: 4C F1 9B  725           JMP  ST:FIL     
                726  ST:NOP   EQU  *          
9C31: 20 66 9E  727           JSR  PROFF      
9C34: 4C F1 9B  728           JMP  ST:FIL     
9C37: 66 49 4C  729  FILE:MSG ASC  'fILE NAME? ' 
9C3A: 45 20 4E 41 4D 45 3F 20 
9C42: DB        730  FILE:MG2 DFB  $DB        
9C43: 63 3E 41  731           ASC  'c>ASSETTE OR',DB 
9C46: 53 53 45 54 54 45 20 4F 
9C4E: 52 DB 
9C50: 64 3E 49  732           ASC  'd>ISK? '  
9C53: 53 4B 3F 20 
9C57: 63 4F 4D  733  FILE:MG3 ASC  'cOMMAND? ' 
9C5A: 4D 41 4E 44 3F 20 
                734  *
                735  GET:FILE EQU  *          
9C60: A9 42     736           LDA  #FILE:MG2  
9C62: A2 9C     737           LDX  #>FILE:MG2 
9C64: A0 15     738           LDY  #21        
9C66: 20 64 80  739           JSR  GETANS     
9C69: C9 44     740           CMP  #'D'       
9C6B: F0 07     741           BEQ  GET:FIL1   
9C6D: C9 43     742           CMP  #'C'       
9C6F: F0 08     743           BEQ  GET:FIL0   
9C71: 4C 06 9C  744           JMP  ST:FIL9    
9C74: AD 11 80  745  GET:FIL1 LDA  DISK:CHN   ; serial bus disk drive
9C77: D0 02     746           BNE  GET:FIL8   
9C79: A9 01     747  GET:FIL0 LDA  #1         ; datasette
9C7B: 85 59     748  GET:FIL8 STA  REG2B      
9C7D: A9 37     749           LDA  #FILE:MSG  
9C7F: A2 9C     750           LDX  #>FILE:MSG 
9C81: A0 0B     751           LDY  #11        
9C83: 20 5B 80  752           JSR  PT         
                753  GET:FIL2 EQU  *          
9C86: 20 8D B3  754           JSR  GETLN1     
9C89: 86 19     755           STX  TKNLEN     
9C8B: E0 00     756           CPX  #0         
9C8D: 30 16     757           BMI  GET:FIL4   
9C8F: D0 17     758           BNE  GET:FIL3   
9C91: A5 16     759           LDA  TOKEN      ; zero length ok on cassette load
9C93: C9 56     760           CMP  #'V'       
9C95: F0 08     761           BEQ  GET:FIL9   ; verify
9C97: C9 41     762           CMP  #'A'       
9C99: F0 04     763           BEQ  GET:FIL9   ; append
9C9B: C9 4C     764           CMP  #'L'       
9C9D: D0 06     765           BNE  GET:FIL4   ; not load
9C9F: A5 59     766  GET:FIL9 LDA  REG2B      
9CA1: C9 01     767           CMP  #1         ; cassette?
9CA3: F0 0E     768           BEQ  GET:FIL7   ; yes - hooray!
9CA5: 4C F1 9B  769  GET:FIL4 JMP  ST:FIL     
                770  GET:FIL3 EQU  *          ; no check on alpha file name now
9CA8: A0 13     771  GET:FILA LDY  #19        
9CAA: B9 3C 03  772  GET:FIL5 LDA  INBUF,Y    
9CAD: 99 B1 02  773           STA  BPOINT,Y   
9CB0: 88        774           DEY             
9CB1: 10 F7     775           BPL  GET:FIL5   
                776  GET:FIL7 EQU  *          
                777  *
                778  * if disk load/save etc. open error channel (15)
                779  *
9CB3: A6 59     780           LDX  REG2B      
9CB5: EC 11 80  781           CPX  DISK:CHN   ; disk?
9CB8: D0 0E     782           BNE  GET:FILB   ; nope
9CBA: A9 0F     783           LDA  #15        
9CBC: A8        784           TAY             ; error channel
9CBD: 20 BA FF  785           JSR  SETLFS     
9CC0: A9 00     786           LDA  #0         ; no command
9CC2: 20 BD FF  787           JSR  SETNAM     
9CC5: 20 C0 FF  788           JSR  OPEN       ; right - it's open
                789  *
                790  GET:FILB EQU  *          
9CC8: A9 01     791           LDA  #1         ; logical file number
9CCA: A6 59     792           LDX  REG2B      ; 1 = cassette, 8 = disk
9CCC: A0 00     793           LDY  #0         ; secondary address
9CCE: 20 BA FF  794           JSR  SETLFS     
9CD1: A5 19     795           LDA  TKNLEN     
9CD3: C9 14     796           CMP  #20        
9CD5: 90 02     797           BLT  GET:FIL6   
9CD7: A9 14     798           LDA  #20        
                799  GET:FIL6 EQU  *          
9CD9: A2 B1     800           LDX  #BPOINT    
9CDB: A0 02     801           LDY  #>BPOINT   ; temporary buffer as INBUF is tape buffer
9CDD: 4C BD FF  802           JMP  SETNAM     ; setup file name 
                803  * 
9CE0: 24        804  CATALOG  ASC  '$'
9CE1: 64 49 53  805  DISK:MSG ASC  'dISK:'
9CE4: 4B 3A 
                806  * 
                807  *
                808  ST:CAT   EQU  *          
                809  *
                810  * here for directory list
                811  *
9CE6: A9 01     812           LDA  #1         
9CE8: AE 11 80  813           LDX  DISK:CHN   
9CEB: A0 00     814           LDY  #0         ; relocated load
9CED: 84 58     815           STY  REGB       
9CEF: 20 BA FF  816           JSR  SETLFS     
9CF2: A9 01     817           LDA  #1         ; $ length
9CF4: A2 E0     818           LDX  #CATALOG   
9CF6: A0 9C     819           LDY  #>CATALOG  
9CF8: 20 BD FF  820           JSR  SETNAM     
9CFB: A9 00     821           LDA  #0         ; load
9CFD: A2 00     822           LDX  #$C000     ; use symbol table
9CFF: 86 17     823           STX  TKNADR     
9D01: A0 C0     824           LDY  #>$C000    ; for directory
9D03: 84 18     825           STY  TKNADR+1   
9D05: 20 D5 FF  826           JSR  LOAD       
9D08: B0 5E     827           BCS  ST:FILJ    ; error on load
9D0A: 20 6D 80  828           JSR  CROUT      
9D0D: 20 6D 80  829           JSR  CROUT      
9D10: A9 E1     830           LDA  #DISK:MSG  
9D12: A2 9C     831           LDX  #>DISK:MSG 
9D14: A0 05     832           LDY  #5         
9D16: 20 5B 80  833           JSR  PT         
9D19: 4C 39 9D  834           JMP  CAT:STRT   ; no sector count for first line
                835  CAT:LOOP EQU  *          
9D1C: A0 01     836           LDY  #1         
9D1E: B1 17     837           LDA  (TKNADR),Y ; end?
9D20: D0 06     838           BNE  CAT:MORE   ; no
9D22: C8        839           INY             
9D23: B1 17     840           LDA  (TKNADR),Y 
9D25: F0 41     841           BEQ  CAT:END    ; finished
9D27: 88        842           DEY             
                843  CAT:MORE EQU  *          
9D28: C8        844           INY             
9D29: C8        845           INY             ; bypass line number link
9D2A: B1 17     846           LDA  (TKNADR),Y ; no: sectors
9D2C: 85 04     847           STA  REG        
9D2E: C8        848           INY             
9D2F: B1 17     849           LDA  (TKNADR),Y ; no: sectors
9D31: 85 05     850           STA  REG+1      
9D33: 20 9E 9E  851           JSR  DSP:BIN    ; display sector count
9D36: 20 67 80  852           JSR  PUTSP      
                853  CAT:STRT EQU  *          
9D39: A0 05     854           LDY  #5         
                855  CAT:CNT  EQU  *          
9D3B: B1 17     856           LDA  (TKNADR),Y 
9D3D: F0 03     857           BEQ  CAT:CNTD   ; found end of this line
9D3F: C8        858           INY             
9D40: D0 F9     859           BNE  CAT:CNT    
                860  CAT:CNTD EQU  *          
9D42: 84 19     861           STY  TKNLEN     ; size of this entry
9D44: 98        862           TYA             
9D45: 38        863           SEC             
9D46: E9 05     864           SBC  #5         ; forget initial stuff
9D48: A8        865           TAY             ; read for PT
9D49: A5 17     866           LDA  TKNADR     
9D4B: 18        867           CLC             
9D4C: 69 05     868           ADC  #5         
9D4E: 48        869           PHA             
9D4F: A5 18     870           LDA  TKNADR+1   
9D51: 69 00     871           ADC  #0         
9D53: AA        872           TAX             
9D54: 68        873           PLA             
9D55: 20 5B 80  874           JSR  PT         ; at last! - display the info
9D58: 20 6D 80  875           JSR  CROUT      
9D5B: A5 17     876           LDA  TKNADR     
9D5D: 18        877           CLC             
9D5E: 65 19     878           ADC  TKNLEN     
9D60: 85 17     879           STA  TKNADR     
9D62: 90 B8     880           BCC  CAT:LOOP   
9D64: E6 18     881           INC  TKNADR+1   
9D66: D0 B4     882           BNE  CAT:LOOP   
                883  CAT:END  EQU  *          
9D68: 4C F1 9B  884  ST:FILJ  JMP  ST:FIL     
                885  *
                886  ST:VFY   EQU  *          
9D6B: 20 60 9C  887           JSR  GET:FILE   
9D6E: AE 09 80  888           LDX  TS         
9D71: AC 0A 80  889           LDY  TS+1       
9D74: A9 01     890           LDA  #1         
9D76: D0 39     891           BNE  ST:LOA1    
                892  *
9D78: 0D BD     893  DOS:ERR  DFB  $0D,$BD    
9D7A: 3A 20     894           ASC  ': '       
                895  *
                896  FIN:DOS  EQU  *          
9D7C: 08        897           PHP             
9D7D: 20 6D 80  898           JSR  CROUT      
9D80: 20 B7 FF  899           JSR  READST     ; check status (verify error etc:)
9D83: 29 BF     900           AND  #$BF       ; ignore end-of-file
9D85: F0 0E     901           BEQ  FIN:DOS2   ; ok
9D87: 48        902           PHA             
9D88: A9 78     903           LDA  #DOS:ERR   
9D8A: A2 9D     904           LDX  #>DOS:ERR  
9D8C: A0 04     905           LDY  #4         
9D8E: 20 5B 80  906           JSR  PT         
9D91: 68        907           PLA             
9D92: 20 22 9A  908           JSR  PRBYTECR   
                909  FIN:DOS2 EQU  *          
9D95: A5 59     910           LDA  REG2B      
9D97: CD 11 80  911           CMP  DISK:CHN   
9D9A: D0 04     912           BNE  FIN:DOS9   
9D9C: 28        913           PLP             ; back to initial carry flag
9D9D: 4C 30 9E  914           JMP  ST:ERR     ; read error channel if disk
                915  FIN:DOS9 EQU  *          
9DA0: 28        916           PLP             
9DA1: 4C F1 9B  917           JMP  ST:FIL     
                918  *
                919  ST:LOA   EQU  *          
9DA4: 20 60 9C  920           JSR  GET:FILE   
9DA7: A9 00     921           LDA  #0         
9DA9: 85 53     922           STA  VAL:CMP    
9DAB: AE 09 80  923           LDX  TS         
9DAE: AC 0A 80  924           LDY  TS+1       
9DB1: 20 D5 FF  925  ST:LOA1  JSR  LOAD       
9DB4: 4C 7C 9D  926  ST:LOA2  JMP  FIN:DOS    
                927  *
                928  *
                929  ST:OBJ   EQU  *          
9DB7: 20 C1 9A  930           JSR  CHK:VAL    
9DBA: 20 60 9C  931           JSR  GET:FILE   
9DBD: A5 28     932           LDA  ACT:PCDA   
9DBF: 85 5C     933           STA  TEMP       
9DC1: A5 29     934           LDA  ACT:PCDA+1 
9DC3: 85 5D     935           STA  TEMP+1     
9DC5: A6 56     936           LDX  END:PCD    
9DC7: A4 57     937           LDY  END:PCD+1  
9DC9: A9 5C     938  ST:OBJ1  LDA  #TEMP      
9DCB: 20 D8 FF  939           JSR  SAVE       
9DCE: 4C 7C 9D  940  ST:OBJ2  JMP  FIN:DOS    
                941  *
                942  ST:WRI   EQU  *          
9DD1: 20 60 9C  943           JSR  GET:FILE   
9DD4: 20 79 80  944           JSR  FND:END    
9DD7: AD 09 80  945           LDA  TS         
9DDA: 85 5C     946           STA  TEMP       
9DDC: AD 0A 80  947           LDA  TS+1       
9DDF: 85 5D     948           STA  TEMP+1     
9DE1: A6 26     949           LDX  P          
9DE3: A4 27     950           LDY  P+1        
9DE5: 4C C9 9D  951           JMP  ST:OBJ1    
                952  *
                953  *
                954  ST:APP   EQU  *          
9DE8: 20 60 9C  955           JSR  GET:FILE   
9DEB: A9 00     956           LDA  #0         
9DED: 85 53     957           STA  VAL:CMP    
9DEF: 20 79 80  958           JSR  FND:END    
9DF2: A5 26     959           LDA  P          
9DF4: 38        960           SEC             
9DF5: E9 01     961           SBC  #1         
9DF7: AA        962           TAX             
9DF8: A5 27     963           LDA  P+1        
9DFA: E9 00     964           SBC  #0         
9DFC: A8        965           TAY             
9DFD: A9 00     966           LDA  #0         
9DFF: F0 B0     967           BEQ  ST:LOA1    
                968  *
9E01: 63 4F 44  969  DOS:MSG  ASC  'cODE: '   
9E04: 45 3A 20 
                970  *
                971  * DOS
                972  *
                973  ST:DOS   EQU  *          
9E07: A9 57     974           LDA  #FILE:MG3  ; 'Command?'
9E09: A2 9C     975           LDX  #>FILE:MG3 
9E0B: A0 09     976           LDY  #9         
9E0D: 20 5B 80  977           JSR  PT         
9E10: 20 8D B3  978           JSR  GETLN1     ; get response
9E13: E0 00     979           CPX  #0         
9E15: F0 3B     980           BEQ  ST:DOS9    ; nosing
9E17: 86 19     981           STX  TKNLEN     
9E19: AE 11 80  982           LDX  DISK:CHN   ; now open disk channel 15
9E1C: A9 0F     983           LDA  #15        
9E1E: A8        984           TAY             ; command channel 
9E1F: 20 BA FF  985           JSR  SETLFS     
9E22: A2 3C     986           LDX  #INBUF     
9E24: A0 03     987           LDY  #>INBUF    
9E26: A5 19     988           LDA  TKNLEN     
9E28: 20 BD FF  989           JSR  SETNAM     ; send command
9E2B: 20 C0 FF  990           JSR  OPEN       
9E2E: B0 1D     991           BCS  ST:DOS8    
                992  ST:ERR   EQU  *          
9E30: A2 0F     993           LDX  #15        
9E32: 20 C6 FF  994           JSR  CHKIN      ; read error channel
9E35: B0 16     995           BCS  ST:DOS8    
9E37: 20 8D B3  996           JSR  GETLN1     ; read it
9E3A: 20 CC FF  997           JSR  CLRCHN     ; back to keyboard 
9E3D: A9 01     998           LDA  #DOS:MSG   
9E3F: A2 9E     999           LDX  #>DOS:MSG  
9E41: A0 06     1000          LDY  #6         
9E43: 20 5B 80  1001          JSR  PT         
9E46: A9 3C     1002          LDA  #INBUF     
9E48: A2 03     1003          LDX  #>INBUF    
9E4A: 20 5E 80  1004          JSR  PL         ; display the message
9E4D: A9 0F     1005 ST:DOS8  LDA  #15        ; close command channel
9E4F: 20 C3 FF  1006          JSR  CLOSE      
9E52: 4C F1 9B  1007 ST:DOS9  JMP  ST:FIL     ; finito
                1008 *
                1009 *
                1010 PRON     EQU  *          
9E55: A9 04     1011          LDA  #4         
9E57: 85 42     1012          STA  PFLAG      
9E59: AE 10 80  1013          LDX  PR:CHAN    ; printer
9E5C: A0 00     1014          LDY  #0         ; normal mode
9E5E: 20 BA FF  1015          JSR  SETLFS     
9E61: 20 C0 FF  1016          JSR  OPEN       ; printer is unit 1
9E64: 90 1F     1017          BCC  RTS        ; open OK
                1018 *
                1019 *
                1020 *
                1021 PROFF    EQU  *          
9E66: A9 00     1022          LDA  #0         
9E68: 85 42     1023          STA  PFLAG      
9E6A: 4C E7 FF  1024          JMP  CLALL      ; close all files (incl. printer & screen )
                1025 *
                1026 *
                1027 UNPACK   EQU  *          
9E6D: 48        1028          PHA             
9E6E: 18        1029          CLC             
9E6F: 6A        1030          ROR             
9E70: 18        1031          CLC             
9E71: 6A        1032          ROR             
9E72: 18        1033          CLC             
9E73: 6A        1034          ROR             
9E74: 18        1035          CLC             
9E75: 6A        1036          ROR             
9E76: 09 30     1037          ORA  #$30       
9E78: 9D E5 02  1038          STA  ASC:WRK,X  
9E7B: E8        1039          INX             
9E7C: 68        1040          PLA             
9E7D: 29 0F     1041          AND  #$0F       
9E7F: 09 30     1042          ORA  #$30       
9E81: 9D E5 02  1043          STA  ASC:WRK,X  
9E84: E8        1044          INX             
9E85: 60        1045 RTS      RTS             
                1046 *
                1047 *
                1048 *
                1049 BIN:TBL  EQU  *          
9E86: 76 85 04  1050          HEX  76850401   
9E89: 01 
9E8A: 36 55 06  1051          HEX  36550600   
9E8D: 00 
9E8E: 96 40 00  1052          HEX  96400000   
9E91: 00 
9E92: 56 02 00  1053          HEX  56020000   
9E95: 00 
9E96: 16 00 00  1054          HEX  16000000   
9E99: 00 
9E9A: 01 00 00  1055          HEX  01000000   
9E9D: 00 
                1056 *
                1057 *
                1058 DSP:BIN  EQU  *          
9E9E: A5 04     1059          LDA  REG        
9EA0: A6 05     1060          LDX  REG+1      
9EA2: A4 58     1061          LDY  REGB       
9EA4: 10 16     1062          BPL  OUT:PLUS   
9EA6: A9 2D     1063          LDA  #'-'       
9EA8: 20 58 80  1064          JSR  PC         
9EAB: 38        1065          SEC             
9EAC: A9 00     1066          LDA  #0         
9EAE: E5 04     1067          SBC  REG        
9EB0: 48        1068          PHA             
9EB1: A9 00     1069          LDA  #0         
9EB3: E5 05     1070          SBC  REG+1      
9EB5: AA        1071          TAX             
9EB6: A9 00     1072          LDA  #0         
9EB8: E5 58     1073          SBC  REGB       
9EBA: A8        1074          TAY             
9EBB: 68        1075          PLA             
                1076 OUT:PLUS EQU  *          
9EBC: 8D E2 02  1077          STA  BIN:WRK    
9EBF: 8E E3 02  1078          STX  BIN:WRK+1  
9EC2: 8C E4 02  1079          STY  BIN:WRK+2  
9EC5: A9 F0     1080          LDA  #$F0       
9EC7: 85 06     1081          STA  REG2       
9EC9: A9 00     1082          LDA  #0         
9ECB: 85 1E     1083          STA  VALUE      
9ECD: 85 1F     1084          STA  VALUE+1    
9ECF: 85 5C     1085          STA  TEMP       
9ED1: 85 5D     1086          STA  TEMP+1     
9ED3: AA        1087          TAX             
9ED4: A0 02     1088          LDY  #2         
                1089 OUT4     EQU  *          
9ED6: B9 E2 02  1090          LDA  BIN:WRK,Y  
9ED9: 25 06     1091          AND  REG2       
9EDB: 85 07     1092          STA  REG2+1     
9EDD: F0 2F     1093          BEQ  OUT2       
9EDF: A5 06     1094          LDA  REG2       
9EE1: 10 08     1095          BPL  OUT1       
9EE3: 46 07     1096          LSR  REG2+1     
9EE5: 46 07     1097          LSR  REG2+1     
9EE7: 46 07     1098          LSR  REG2+1     
9EE9: 46 07     1099          LSR  REG2+1     
                1100 OUT1     EQU  *          
9EEB: F8        1101          SED             
9EEC: A5 5C     1102          LDA  TEMP       
9EEE: 18        1103          CLC             
9EEF: 7D 86 9E  1104          ADC  BIN:TBL,X  
9EF2: 85 5C     1105          STA  TEMP       
9EF4: A5 5D     1106          LDA  TEMP+1     
9EF6: 7D 87 9E  1107          ADC  BIN:TBL+1,X 
9EF9: 85 5D     1108          STA  TEMP+1     
9EFB: A5 1E     1109          LDA  VALUE      
9EFD: 7D 88 9E  1110          ADC  BIN:TBL+2,X 
9F00: 85 1E     1111          STA  VALUE      
9F02: A5 1F     1112          LDA  VALUE+1    
9F04: 7D 89 9E  1113          ADC  BIN:TBL+3,X 
9F07: 85 1F     1114          STA  VALUE+1    
9F09: D8        1115          CLD             
9F0A: C6 07     1116          DEC  REG2+1     
9F0C: D0 DD     1117          BNE  OUT1       
                1118 OUT2     EQU  *          
9F0E: E8        1119          INX             
9F0F: E8        1120          INX             
9F10: E8        1121          INX             
9F11: E8        1122          INX             
9F12: A5 06     1123          LDA  REG2       
9F14: 49 FF     1124          EOR  #$FF       
9F16: 85 06     1125          STA  REG2       
9F18: 10 BC     1126          BPL  OUT4       
9F1A: 88        1127          DEY             
9F1B: 10 B9     1128          BPL  OUT4       
                1129 OUT3     EQU  *          
9F1D: A2 00     1130          LDX  #0         
9F1F: A5 1F     1131          LDA  VALUE+1    
9F21: 20 6D 9E  1132          JSR  UNPACK     
9F24: A5 1E     1133          LDA  VALUE      
9F26: 20 6D 9E  1134          JSR  UNPACK     
9F29: A5 5D     1135          LDA  TEMP+1     
9F2B: 20 6D 9E  1136          JSR  UNPACK     
9F2E: A5 5C     1137          LDA  TEMP       
9F30: 20 6D 9E  1138          JSR  UNPACK     
9F33: A2 07     1139          LDX  #7         ; ZERO SUPPRESS 
9F35: A0 00     1140          LDY  #0         
9F37: B9 E5 02  1141 OUT5     LDA  ASC:WRK,Y  
9F3A: C9 30     1142          CMP  #'0'       
9F3C: D0 04     1143          BNE  OUT6       
9F3E: C8        1144          INY             
9F3F: CA        1145          DEX             
9F40: D0 F5     1146          BNE  OUT5       
9F42: B9 E5 02  1147 OUT6     LDA  ASC:WRK,Y  
9F45: 8C E2 02  1148          STY  BIN:WRK    
9F48: 8E E3 02  1149          STX  BIN:WRK+1  
9F4B: 20 58 80  1150          JSR  PC         
9F4E: AC E2 02  1151          LDY  BIN:WRK    
9F51: AE E3 02  1152          LDX  BIN:WRK+1  
9F54: C8        1153          INY             
9F55: CA        1154          DEX             
9F56: 10 EA     1155          BPL  OUT6       
9F58: 60        1156 DB9      RTS             
                1157 *
                1158 * 
                1159 *
9F59: 20 73 54  1160 DM1      ASC  ' sTACK: ' 
9F5C: 41 43 4B 3A 20 
9F61: 20 62 41  1161 DM2      ASC  ' bASE:  ' 
9F64: 53 45 3A 20 20 
9F69: 72 55 4E  1162 DM4      ASC  'rUNNING',0D
9F6C: 4E 49 4E 47 0D 
                1163 *
                1164 DEBUG    EQU  *          
9F71: 20 6A 80  1165 DB11     JSR  DISPAD     
9F74: A5 26     1166          LDA  P          
9F76: 85 3C     1167          STA  WORK       
9F78: A5 27     1168          LDA  P+1        
9F7A: 85 3D     1169          STA  WORK+1     
9F7C: A2 04     1170          LDX  #4         
9F7E: 20 83 A3  1171          JSR  DIS4       
9F81: 20 6D 80  1172          JSR  CROUT      
9F84: A6 67     1173          LDX  DBGFLG     
9F86: 30 D0     1174          BMI  DB9        ; TRACE ONLY
9F88: A9 59     1175          LDA  #DM1       
9F8A: A2 9F     1176          LDX  #>DM1      
9F8C: A0 08     1177          LDY  #8         
9F8E: 20 5B 80  1178          JSR  PT         
9F91: A5 33     1179          LDA  T+1        
9F93: 20 46 80  1180          JSR  PRBYTE     
9F96: A5 32     1181          LDA  T          
9F98: 20 2B 80  1182          JSR  DISHX      
9F9B: A9 3D     1183          LDA  #'='       
9F9D: 20 58 80  1184          JSR  PC         
9FA0: A5 32     1185          LDA  T          
9FA2: 85 3C     1186          STA  WORK       
9FA4: A5 33     1187          LDA  T+1        
9FA6: 85 3D     1188          STA  WORK+1     
9FA8: A2 08     1189          LDX  #8         
9FAA: 20 83 A3  1190          JSR  DIS4       
9FAD: 20 6D 80  1191          JSR  CROUT      
9FB0: A9 61     1192          LDA  #DM2       
9FB2: A2 9F     1193          LDX  #>DM2      
9FB4: A0 08     1194          LDY  #8         
9FB6: 20 5B 80  1195          JSR  PT         
9FB9: A5 46     1196          LDA  BASE+1     
9FBB: 20 46 80  1197          JSR  PRBYTE     
9FBE: A5 45     1198          LDA  BASE       
9FC0: 20 2B 80  1199          JSR  DISHX      
9FC3: A9 3D     1200          LDA  #'='       
9FC5: 20 58 80  1201          JSR  PC         
9FC8: A5 45     1202          LDA  BASE       
9FCA: 38        1203          SEC             
9FCB: E9 06     1204          SBC  #6         
9FCD: 85 3C     1205          STA  WORK       
9FCF: A5 46     1206          LDA  BASE+1     
9FD1: E9 00     1207          SBC  #0         
9FD3: 85 3D     1208          STA  WORK+1     
9FD5: A2 06     1209          LDX  #6         
9FD7: 20 83 A3  1210          JSR  DIS4       
9FDA: 4C 6D 80  1211          JMP  CROUT      
                1212 *
                1213 *
                1214 * INTERPRETER INITIALIZATION
                1215 *
                1216 INTERP   EQU  *          
9FDD: 08        1217          PHP             
9FDE: 68        1218          PLA             
9FDF: 8D B1 02  1219          STA  CALL:P     
9FE2: A5 28     1220          LDA  ACT:PCDA   
9FE4: 85 26     1221          STA  P          
9FE6: A5 29     1222          LDA  ACT:PCDA+1 
9FE8: 85 27     1223          STA  P+1        
9FEA: A9 86     1224          LDA  #BREAK     
9FEC: 85 0B     1225          STA  ERR:RTN    
9FEE: 85 54     1226          STA  CTRLC:RT   
9FF0: A9 A3     1227          LDA  #>BREAK    
9FF2: 85 0C     1228          STA  ERR:RTN+1  
9FF4: 85 55     1229          STA  CTRLC:RT+1 
9FF6: A9 69     1230          LDA  #DM4       
9FF8: A2 9F     1231          LDX  #>DM4      
9FFA: 20 5E 80  1232          JSR  PL         
9FFD: A0 0C     1233          LDY  #12        
9FFF: 84 49     1234          STY  RUNNING    
A001: A9 D0     1235          LDA  #P:STACK   
A003: 85 32     1236          STA  T          
A005: 85 45     1237          STA  BASE       
A007: A9 CE     1238          LDA  #>P:STACK  
A009: 85 33     1239          STA  T+1        
A00B: 85 46     1240          STA  BASE+1     
A00D: A9 00     1241          LDA  #0         
A00F: 85 6C     1242          STA  DOS:FLG    
A011: 85 6E     1243          STA  COLL:REG   
A013: 85 6D     1244          STA  MASK       
A015: A0 07     1245          LDY  #7         
A017: 99 98 CF  1246 INTER:LP STA  S:ACTIVE,Y 
A01A: 99 D8 CE  1247          STA  S:ANIMCT,Y 
A01D: 88        1248          DEY             
A01E: 10 F7     1249          BPL  INTER:LP   
                1250 *
                1251 * now process our sprite table on timer interrupts
                1252 *
A020: 78        1253          SEI             
A021: A9 57     1254          LDA  #TIMER:IN  
A023: 8D 14 03  1255          STA  CINV       
A026: A9 A1     1256          LDA  #>TIMER:IN 
A028: 8D 15 03  1257          STA  CINV+1     
A02B: 58        1258          CLI             
A02C: 4C 80 A3  1259          JMP  INTERJ     
                1260 *
                1261 *
                1262 SPT:STAT EQU  *          
A02F: 20 95 A2  1263          JSR  GET:SPT    
A032: BD 98 CF  1264          LDA  S:ACTIVE,X 
A035: 4C 95 A3  1265          JMP  TRUE2      
                1266 *
                1267 MOV:SPT  EQU  *          
A038: 20 98 A3  1268          JSR  PULTOP     
A03B: 8D BB 02  1269          STA  BPOINT+10  
A03E: 8E BC 02  1270          STX  BPOINT+11  ; moves
A041: 20 98 A3  1271          JSR  PULTOP     
A044: 8D BD 02  1272          STA  BPOINT+12  
A047: 8E BE 02  1273          STX  BPOINT+13  ; yinc
A04A: 20 98 A3  1274          JSR  PULTOP     
A04D: 8D BF 02  1275          STA  BPOINT+14  
A050: 8E C0 02  1276          STX  BPOINT+15  ; xinc 
A053: 8C C1 02  1277          STY  BPOINT+16  
A056: 20 98 A3  1278          JSR  PULTOP     
A059: 8D C2 02  1279          STA  BPOINT+17  ; y pos 
A05C: 20 98 A3  1280          JSR  PULTOP     
A05F: 8D C3 02  1281          STA  BPOINT+18  
A062: 8E C4 02  1282          STX  BPOINT+19  ; x pos 
A065: 20 95 A2  1283          JSR  GET:SPT    
A068: 78        1284          SEI             
A069: AD BB 02  1285          LDA  BPOINT+10  
A06C: 9D F0 CF  1286          STA  S:COUNT,X  
A06F: AD BC 02  1287          LDA  BPOINT+11  
A072: 9D F8 CF  1288          STA  S:COUNT+8,X 
A075: AD BD 02  1289          LDA  BPOINT+12  
A078: 9D E0 CF  1290          STA  S:YINC,X   
A07B: AD BE 02  1291          LDA  BPOINT+13  
A07E: 9D E8 CF  1292          STA  S:YINC+8,X 
A081: AD BF 02  1293          LDA  BPOINT+14  
A084: 9D C8 CF  1294          STA  S:XINC,X   
A087: AD C0 02  1295          LDA  BPOINT+15  
A08A: 9D D0 CF  1296          STA  S:XINC+8,X 
A08D: AD C1 02  1297          LDA  BPOINT+16  
A090: 9D D8 CF  1298          STA  S:XINC+16,X 
A093: AD C2 02  1299          LDA  BPOINT+17  
A096: 9D C0 CF  1300          STA  S:YPOS+8,X 
A099: AD C3 02  1301          LDA  BPOINT+18  
A09C: 9D A8 CF  1302          STA  S:XPOS+8,X 
A09F: AD C4 02  1303          LDA  BPOINT+19  
A0A2: 9D B0 CF  1304          STA  S:XPOS+16,X 
A0A5: A9 00     1305          LDA  #0         
A0A7: 9D B8 CF  1306          STA  S:YPOS,X   
A0AA: 9D A0 CF  1307          STA  S:XPOS,X   
A0AD: A9 01     1308          LDA  #1         
A0AF: 9D 98 CF  1309          STA  S:ACTIVE,X 
A0B2: 20 6C A2  1310          JSR  POS:SPRT   
A0B5: BD 9E A3  1311          LDA  MASKS,X    
A0B8: 0D 15 D0  1312          ORA  VIC+$15    ; activate it
A0BB: 8D 15 D0  1313          STA  VIC+$15    
A0BE: 58        1314          CLI             
A0BF: 4C 8C A3  1315          JMP  MAIN       
                1316 *
                1317 ANM:SPT  EQU  *          
A0C2: A9 10     1318          LDA  #16        
A0C4: 8D B1 02  1319          STA  BPOINT     ; pointer count
                1320 ANM:1    EQU  *          
A0C7: 20 98 A3  1321          JSR  PULTOP     ; get pointer
A0CA: AC B1 02  1322          LDY  BPOINT     
A0CD: 99 B1 02  1323          STA  BPOINT,Y   
A0D0: CE B1 02  1324          DEC  BPOINT     
A0D3: D0 F2     1325          BNE  ANM:1      ; more
A0D5: A9 FE     1326          LDA  #254       
A0D7: 20 92 A3  1327          JSR  CHK:TOP    ; frames per pointer
A0DA: A8        1328          TAY             
A0DB: C8        1329          INY             ; back to supplied value
A0DC: 8C C3 02  1330          STY  BPOINT+18  ; frame change count
A0DF: 20 95 A2  1331          JSR  GET:SPT    
A0E2: 8D C4 02  1332          STA  BPOINT+19  ; sprite
A0E5: E8        1333          INX             
A0E6: 8A        1334          TXA             ; next one (so we can work backwards)
A0E7: 0A        1335          ASL             
A0E8: 0A        1336          ASL             
A0E9: 0A        1337          ASL             
A0EA: 0A        1338          ASL             ; times 16
A0EB: A8        1339          TAY             
A0EC: A2 10     1340          LDX  #16        ; pointer count
A0EE: 78        1341          SEI             
                1342 ANM:3    EQU  *          
A0EF: BD B1 02  1343          LDA  BPOINT,X   
A0F2: F0 03     1344          BEQ  ANM:2      ; not used
A0F4: EE B1 02  1345          INC  BPOINT     ; count used ones 
                1346 ANM:2    EQU  *          
A0F7: 88        1347          DEY             
A0F8: 99 F8 CE  1348          STA  S:POINTR,Y 
A0FB: CA        1349          DEX             
A0FC: D0 F1     1350          BNE  ANM:3      ; more
A0FE: AC C4 02  1351          LDY  BPOINT+19  ; sprite
A101: AD B1 02  1352          LDA  BPOINT     ; used count
A104: 99 F0 CE  1353          STA  S:ANIMFM,Y 
A107: AD C3 02  1354          LDA  BPOINT+18  ; frame count
A10A: 99 D8 CE  1355          STA  S:ANIMCT,Y 
A10D: A9 00     1356          LDA  #0         
A10F: 99 E0 CE  1357          STA  S:ANIMPS,Y 
A112: 99 E8 CE  1358          STA  S:ANIMCC,Y 
A115: 58        1359          CLI             
A116: 84 4C     1360          STY  SPRITENO   
A118: AD B2 02  1361          LDA  BPOINT+1   ; first pointer
A11B: 8D C0 02  1362          STA  FNC:VAL    
A11E: 4C 9B A3  1363          JMP  S:PNT2     ; now point to first
                1364 *
                1365 SPRT:X   EQU  *          
A121: 20 95 A2  1366          JSR  GET:SPT    
A124: 0A        1367          ASL             
A125: A8        1368          TAY             
A126: B9 00 D0  1369          LDA  VIC,Y      ; Low byte
A129: 85 04     1370          STA  REG        
A12B: AD 10 D0  1371          LDA  VIC+$10    
A12E: 3D 9E A3  1372          AND  MASKS,X    ; high bit
A131: F0 02     1373          BEQ  SPRT:X1    ; off
A133: A9 01     1374          LDA  #1         ; mark on
A135: 85 05     1375 SPRT:X1  STA  REG+1      
A137: 4C 8F A3  1376          JMP  MAINP      ; push result
                1377 *
                1378 SPRT:Y   EQU  *          
A13A: 20 95 A2  1379          JSR  GET:SPT    
A13D: 0A        1380          ASL             
A13E: A8        1381          TAY             
A13F: B9 01 D0  1382          LDA  VIC+1,Y    
A142: 4C 95 A3  1383          JMP  TRUE2      ; result
                1384 *
                1385 STOP:SPT EQU  *          
A145: A9 00     1386          LDA  #0         
A147: 48        1387          PHA             
                1388 CHNG:SPT EQU  *          
A148: 20 95 A2  1389          JSR  GET:SPT    
A14B: 68        1390          PLA             ; get new status
A14C: 9D 98 CF  1391          STA  S:ACTIVE,X ; mark inactive/active
A14F: 4C 8C A3  1392          JMP  MAIN       
                1393 *
                1394 STRT:SPT EQU  *          
A152: A9 01     1395          LDA  #1         
A154: 48        1396          PHA             
A155: D0 F1     1397          BNE  CHNG:SPT   
                1398 *
                1399 TIMER:IN EQU  *          ; here for timer interrupts
                1400 *
                1401 * first look for collisions
                1402 *
A157: AD 19 D0  1403          LDA  VIC+25     ; interrupt register
A15A: 29 84     1404          AND  #$84       ; sprite-sprite collision?
A15C: C9 84     1405          CMP  #$84       
A15E: D0 35     1406          BNE  TIMER2     ; nope - normal interrupt
A160: 8D 19 D0  1407          STA  VIC+25     ; re-enable
A163: AD 1E D0  1408          LDA  VIC+30     ; collision register
A166: AA        1409          TAX             ; save it
A167: 25 6D     1410          AND  MASK       
A169: F0 24     1411          BEQ  FORGET     ; wrong sprite - forget interrupt
A16B: 86 6E     1412          STX  COLL:REG   ; save interrupt register
A16D: A2 01     1413          LDX  #1         
A16F: 8E FA 02  1414          STX  INT:TEMP   
A172: CA        1415          DEX             
A173: A5 6E     1416 TIM:COL1 LDA  COLL:REG   
A175: 2D FA 02  1417          AND  INT:TEMP   ; this sprite involved?
A178: F0 05     1418          BEQ  TIM:COL2   ; no
A17A: A9 00     1419          LDA  #0         
A17C: 9D 98 CF  1420          STA  S:ACTIVE,X ; yes - stop it
A17F: E8        1421 TIM:COL2 INX             ; next sprite
A180: 0E FA 02  1422          ASL  INT:TEMP   ; next mask
A183: D0 EE     1423          BNE  TIM:COL1   ; more to go
A185: 85 6D     1424          STA  MASK       ; stop further tests
A187: AD 1A D0  1425          LDA  VIC+26     
A18A: 29 FB     1426          AND  #$FB       ; stop interrupts
A18C: 8D 1A D0  1427          STA  VIC+26     
A18F: 68        1428 FORGET   PLA             
A190: A8        1429          TAY             
A191: 68        1430          PLA             
A192: AA        1431          TAX             
A193: 68        1432          PLA             
A194: 40        1433          RTI             ; off we go
                1434 *
                1435 TIMER2   EQU  *          ; here for non-collision interrupts
A195: D8        1436          CLD             
A196: A2 00     1437          LDX  #0         
A198: BD 98 CF  1438 TIMER:CK LDA  S:ACTIVE,X ; sprite active?
A19B: D0 08     1439          BNE  TIMER:AC   ; yes
A19D: E8        1440 TIMER:NX INX             
A19E: E0 08     1441          CPX  #8         
A1A0: D0 F6     1442          BNE  TIMER:CK   ; more to go
A1A2: 6C F8 02  1443          JMP  (INT:RTN)  
                1444 *
                1445 TIMER:AC EQU  *          ; here for active one
A1A5: 18        1446          CLC             
A1A6: BD C8 CF  1447          LDA  S:XINC,X   
A1A9: 7D A0 CF  1448          ADC  S:XPOS,X   
A1AC: 9D A0 CF  1449          STA  S:XPOS,X   
A1AF: BD D0 CF  1450          LDA  S:XINC+8,X 
A1B2: 7D A8 CF  1451          ADC  S:XPOS+8,X 
A1B5: 9D A8 CF  1452          STA  S:XPOS+8,X 
A1B8: BD D8 CF  1453          LDA  S:XINC+16,X 
A1BB: 7D B0 CF  1454          ADC  S:XPOS+16,X 
A1BE: 9D B0 CF  1455          STA  S:XPOS+16,X 
A1C1: 18        1456          CLC             
A1C2: BD E0 CF  1457          LDA  S:YINC,X   
A1C5: 7D B8 CF  1458          ADC  S:YPOS,X   
A1C8: 9D B8 CF  1459          STA  S:YPOS,X   
A1CB: BD E8 CF  1460          LDA  S:YINC+8,X 
A1CE: 7D C0 CF  1461          ADC  S:YPOS+8,X 
A1D1: 9D C0 CF  1462          STA  S:YPOS+8,X 
A1D4: 38        1463          SEC             
A1D5: BD F0 CF  1464          LDA  S:COUNT,X  
A1D8: E9 01     1465          SBC  #1         
A1DA: 9D F0 CF  1466          STA  S:COUNT,X  
A1DD: BD F8 CF  1467          LDA  S:COUNT+8,X 
A1E0: E9 00     1468          SBC  #0         
A1E2: 9D F8 CF  1469          STA  S:COUNT+8,X 
A1E5: 10 05     1470          BPL  TIMER:ON   
A1E7: A9 00     1471          LDA  #0         ; finished with this oe
A1E9: 9D 98 CF  1472          STA  S:ACTIVE,X ; turn it off
                1473 TIMER:ON EQU  *          
A1EC: 20 6C A2  1474          JSR  POS:SPRT   
A1EF: BD D8 CE  1475          LDA  S:ANIMCT,X 
A1F2: F0 75     1476          BEQ  NO:ANIM    
                1477 *
                1478 * now animate the pointers
                1479 *
A1F4: BC E8 CE  1480          LDY  S:ANIMCC,X ; current frame count
A1F7: C8        1481          INY             
A1F8: 98        1482          TYA             
A1F9: DD D8 CE  1483          CMP  S:ANIMCT,X ; reached limit?
A1FC: B0 05     1484          BGE  NEW:FRAM   ; yes
A1FE: 9D E8 CE  1485          STA  S:ANIMCC,X ; no - save it
A201: 90 66     1486          BLT  NO:ANIM    ; that's all
                1487 NEW:FRAM EQU  *          
A203: A9 00     1488          LDA  #0         
A205: 9D E8 CE  1489          STA  S:ANIMCC,X ; back to start
A208: BC E0 CE  1490          LDY  S:ANIMPS,X ; which position next?
A20B: C8        1491          INY             
A20C: 98        1492          TYA             
A20D: DD F0 CE  1493          CMP  S:ANIMFM,X ; limit?
A210: 90 02     1494          BLT  ANIM:OK    ; no
A212: A9 00     1495          LDA  #0         ; YES 
                1496 ANIM:OK  EQU  *          
A214: 9D E0 CE  1497          STA  S:ANIMPS,X ; save current position
A217: 8A        1498          TXA             ; sprite
A218: 0A        1499          ASL             
A219: 0A        1500          ASL             
A21A: 0A        1501          ASL             
A21B: 0A        1502          ASL             ; times 16
A21C: 1D E0 CE  1503          ORA  S:ANIMPS,X ; plus frame number
A21F: A8        1504          TAY             
A220: B9 F8 CE  1505          LDA  S:POINTR,Y ; get pointer
A223: 8D FA 02  1506          STA  INT:TEMP   
                1507 *
                1508 * now point the sprite
                1509 *
A226: AD 02 DD  1510          LDA  CIA2+2     
A229: 48        1511          PHA             
A22A: 29 FC     1512          AND  #$FC       
A22C: 8D 02 DD  1513          STA  CIA2+2     
A22F: AD 00 DD  1514          LDA  CIA2       
A232: 29 03     1515          AND  #3         
A234: 49 FF     1516          EOR  #$FF       
A236: 0A        1517          ASL             
A237: 0A        1518          ASL             
A238: 0A        1519          ASL             
A239: 0A        1520          ASL             
A23A: 0A        1521          ASL             
A23B: 0A        1522          ASL             
A23C: 8D FC 02  1523          STA  INT:TMP2   ; bank
A23F: 68        1524          PLA             
A240: 8D 02 DD  1525          STA  CIA2+2     
A243: A5 04     1526          LDA  REG        
A245: 48        1527          PHA             
A246: A5 05     1528          LDA  REG+1      
A248: 48        1529          PHA             
A249: AD 18 D0  1530          LDA  VIC+$18    
A24C: 29 F0     1531          AND  #$F0       ; video base
A24E: 4A        1532          LSR             
A24F: 4A        1533          LSR             
A250: 18        1534          CLC             
A251: 69 03     1535          ADC  #3         
A253: 6D FC 02  1536          ADC  INT:TMP2   ; add bank
A256: 85 05     1537          STA  REG+1      
A258: A9 F8     1538          LDA  #$F8       
A25A: 85 04     1539          STA  REG        
A25C: 8A        1540          TXA             ; sprite
A25D: A8        1541          TAY             
A25E: AD FA 02  1542          LDA  INT:TEMP   ; pointer
A261: 91 04     1543          STA  (REG),Y    
A263: 68        1544          PLA             
A264: 85 05     1545          STA  REG+1      
A266: 68        1546          PLA             
A267: 85 04     1547          STA  REG        
A269: 4C 9D A1  1548 NO:ANIM  JMP  TIMER:NX   
                1549 *
                1550 POS:SPRT EQU  *          
A26C: BD B0 CF  1551          LDA  S:XPOS+16,X 
A26F: 29 01     1552          AND  #1         
A271: F0 03     1553          BEQ  POS:1      ; high-order zero
A273: BD 9E A3  1554          LDA  MASKS,X    
A276: 8D FA 02  1555 POS:1    STA  INT:TEMP   
A279: BD A6 A3  1556          LDA  XMASKS,X   
A27C: 2D 10 D0  1557          AND  VIC+$10    
A27F: 0D FA 02  1558          ORA  INT:TEMP   
A282: 8D 10 D0  1559          STA  VIC+$10    
A285: 8A        1560          TXA             
A286: 0A        1561          ASL             
A287: A8        1562          TAY             
A288: BD A8 CF  1563          LDA  S:XPOS+8,X 
A28B: 99 00 D0  1564          STA  VIC,Y      
A28E: BD C0 CF  1565          LDA  S:YPOS+8,X 
A291: 99 01 D0  1566          STA  VIC+1,Y    
A294: 60        1567          RTS             
                1568 *
                1569 GET:SPT  EQU  *          
A295: A9 07     1570          LDA  #7         
A297: 20 92 A3  1571          JSR  CHK:TOP    
A29A: AA        1572          TAX             
A29B: 60        1573          RTS             
                1574 *
                1575 LOA:SVE  EQU  *          ; get ready for load/save
A29C: 20 98 A3  1576          JSR  PULTOP     ; load/verify flag
A29F: 85 4B     1577          STA  SCE:LIM    
A2A1: 86 4C     1578          STX  SCE:LIM+1  
A2A3: 20 98 A3  1579          JSR  PULTOP     
A2A6: 85 5C     1580          STA  TEMP       ; address to load/save
A2A8: 86 5D     1581          STX  TEMP+1     
A2AA: 20 98 A3  1582          JSR  PULTOP     ; device number
A2AD: AA        1583          TAX             ; device
A2AE: A9 01     1584          LDA  #1         ; file 1 
A2B0: A0 00     1585          LDY  #0         
A2B2: 20 BA FF  1586 LOA:SVE1 JSR  SETLFS     
A2B5: A0 00     1587          LDY  #0         
A2B7: B1 26     1588          LDA  (P),Y      ; length of name 
A2B9: 48        1589          PHA             
A2BA: A5 26     1590          LDA  P          ; address of name
A2BC: 18        1591          CLC             
A2BD: 69 01     1592          ADC  #1         
A2BF: AA        1593          TAX             
A2C0: A5 27     1594          LDA  P+1        
A2C2: 69 00     1595          ADC  #0         
A2C4: A8        1596          TAY             
A2C5: 68        1597          PLA             ; size of name
A2C6: 20 BD FF  1598          JSR  SETNAM     
A2C9: 18        1599          CLC             
A2CA: 69 01     1600          ADC  #1         ; bypass length
A2CC: 65 26     1601          ADC  P          
A2CE: 85 26     1602          STA  P          
A2D0: 90 02     1603          BCC  LOADIT1    
A2D2: E6 27     1604          INC  P+1        
                1605 LOADIT1  EQU  *          
A2D4: 60        1606          RTS             
                1607 *
                1608 LOADIT   EQU  *          
A2D5: 20 9C A2  1609          JSR  LOA:SVE    
A2D8: A5 4B     1610          LDA  SCE:LIM    ; load/verify flag
A2DA: A6 5C     1611          LDX  TEMP       
A2DC: A4 5D     1612          LDY  TEMP+1     ; address 
A2DE: 20 D5 FF  1613          JSR  LOAD       
A2E1: 8E B3 02  1614          STX  CALL:X     
A2E4: 8C B4 02  1615          STY  CALL:Y     
A2E7: B0 03     1616 LOADIT2  BCS  LOADIT3    ; error in accumulator
A2E9: 20 B7 FF  1617 LOADIT4  JSR  READST     ; otherwise check READST 
                1618 LOADIT3  EQU  *          
A2EC: 85 6C     1619          STA  DOS:FLG    
A2EE: 4C 8C A3  1620          JMP  MAIN       ; done
                1621 *
                1622 SAVEIT   EQU  *          
A2F1: 20 9C A2  1623          JSR  LOA:SVE    
A2F4: A6 4B     1624          LDX  SCE:LIM    
A2F6: A4 4C     1625          LDY  SCE:LIM+1  
A2F8: C4 5D     1626          CPY  TEMP+1     ; end less than start?
A2FA: 90 10     1627          BLT  SAVE:ERR   ; yes - oops
A2FC: D0 06     1628          BNE  SAVE:OK    ; not equal - must be greater (OK)
A2FE: E4 5C     1629          CPX  TEMP       ; high order same - is low order less than start?
A300: 90 0A     1630          BLT  SAVE:ERR   ; yes - oops
A302: F0 08     1631          BEQ  SAVE:ERR   ; even same is no good
                1632 SAVE:OK  EQU  *          
A304: A9 5C     1633          LDA  #TEMP      
A306: 20 D8 FF  1634          JSR  SAVE       
A309: 4C E7 A2  1635          JMP  LOADIT2    
                1636 *
A30C: 4C 89 A3  1637 SAVE:ERR JMP  CHK:ERR    ; start address >= end address
                1638 *
                1639 X:OPEN   EQU  *          ; OPEN A FILE
A30F: 20 98 A3  1640          JSR  PULTOP     ; secondary address
A312: 85 5C     1641          STA  TEMP       
A314: 20 98 A3  1642          JSR  PULTOP     ; device
A317: 85 5D     1643          STA  TEMP+1     
A319: 20 98 A3  1644          JSR  PULTOP     ; unit
A31C: A6 5D     1645          LDX  TEMP+1     ; device
A31E: A4 5C     1646          LDY  TEMP       ; secondary address
A320: 20 B2 A2  1647          JSR  LOA:SVE1   ; now SETLFS and process file name
A323: 20 C0 FF  1648          JSR  OPEN       ; now open the file
A326: 4C E7 A2  1649          JMP  LOADIT2    ; and see the result
                1650 *
                1651 X:CLOSE  EQU  *          ; CLOSE A FILE
A329: 20 98 A3  1652          JSR  PULTOP     ; file number
A32C: 20 C3 FF  1653          JSR  CLOSE      
A32F: 4C E7 A2  1654          JMP  LOADIT2    ; and see the result
                1655 *
                1656 X:PUT    EQU  *          
A332: 20 98 A3  1657          JSR  PULTOP     ; file number
A335: AA        1658          TAX             ; zero (clear channel?) 
A336: F0 12     1659          BEQ  X:PUT0     
A338: 20 C9 FF  1660          JSR  CHKOUT     
A33B: 4C E7 A2  1661          JMP  LOADIT2    ; result
                1662 *
                1663 X:GET    EQU  *          
A33E: 20 98 A3  1664          JSR  PULTOP     ; file number 
A341: AA        1665          TAX             ; zero (clear channel?) 
A342: F0 06     1666          BEQ  X:GET0     
A344: 20 C6 FF  1667          JSR  CHKIN      
A347: 4C E7 A2  1668          JMP  LOADIT2    ; result 
                1669 *
                1670 X:GET0   EQU  *          
                1671 X:PUT0   EQU  *          
A34A: 20 CC FF  1672          JSR  CLRCHN     ; clear channels
A34D: 4C 8C A3  1673          JMP  MAIN       
                1674 * 
                1675 *
                1676 *
                1677 FREEZE:S EQU  *          
A350: 78        1678          SEI             
A351: 84 6E     1679          STY  COLL:REG   ; no collision yet
A353: AD 19 D0  1680          LDA  VIC+25     
A356: 29 84     1681          AND  #$84       ; clear any pending interrupts
A358: 8D 19 D0  1682          STA  VIC+25     
A35B: AD 1E D0  1683          LDA  VIC+30     ; clear any current collisions
A35E: 20 98 A3  1684          JSR  PULTOP     ; mask
A361: 85 6D     1685          STA  MASK       
A363: C9 00     1686          CMP  #0         ; none?
A365: F0 0C     1687          BEQ  FREEZE1    ; yes - disable interrupts
A367: AD 1A D0  1688          LDA  VIC+26     
A36A: 09 04     1689          ORA  #4         ; enable interrupts
A36C: 8D 1A D0  1690 FREEZE2  STA  VIC+26     
A36F: 58        1691          CLI             
A370: 4C 8C A3  1692          JMP  MAIN       
                1693 *
A373: AD 1A D0  1694 FREEZE1  LDA  VIC+26     
A376: 29 FB     1695          AND  #$FB       
A378: 4C 6C A3  1696          JMP  FREEZE2    
                1697 *
                1698 FR:STAT  EQU  *          
A37B: A5 6E     1699          LDA  COLL:REG   
A37D: 4C 95 A3  1700          JMP  TRUE2      
                1701 *
                1702 *
A380: 00        1704          BRK             


--End assembly, 2643 bytes, Errors: 0 
