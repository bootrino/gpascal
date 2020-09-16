                     ************************************************
                2    * PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 2
                5    * Authors: Nick Gammon & Sue Gobbett
                6    *  SYM $9000
                     ************************************************
                8    *
                9    P1       EQU  $8013      
                10   P2       EQU  $8DD4      
                11   P3       EQU  $992E      
                12   P4       EQU  $A380      
                13   P5       EQU  $B384      
                14   P6       EQU  $BCB8      
                15   *
                16   STACK    EQU  $100       
                17   INBUF    EQU  $33C       
                18   KBD:BUF  EQU  $277       
                19   HIMEM    EQU  $283       
                20   COLOR    EQU  $286       
                21   HIBASE   EQU  $288       
                22   AUTODN   EQU  $292       
                23   BITNUM   EQU  $298       
                24   BAUDOF   EQU  $299       
                25   RODBS    EQU  $29D       
                26   RODBE    EQU  $29E       
                27   ENABRS   EQU  $2A1       ; RS232 enables
                28   WARM:STR EQU  $302       ; basic warm start vector
                29   CINV     EQU  $314       ; hardware interrupt vector
                30   *
                31   SPACE    EQU  $20        
                32   CR       EQU  $D         
                33   FF       EQU  $C         
                34   LF       EQU  $A         
                35   MAX:STK  EQU  32         
                36   NEW:STK  EQU  $FF        
                37   *
                38   VIC      EQU  $D000      
                39   SID      EQU  $D400      
                40   CIA1     EQU  $DC00      
                41   CIA2     EQU  $DD00      
                42   DATAREG  EQU  $DD01      
                43   DDRB     EQU  $DD03      
                44   FLAG     EQU  $DD0D      
                45   BORDER   EQU  $D020      
                46   BKGND    EQU  $D021      
                47   *
                48   COUT     EQU  $FFD2      
                49   STOP     EQU  $FFE1      
                50   GETIN    EQU  $FFE4      
                51   CHKOUT   EQU  $FFC9      
                52   CLRCHN   EQU  $FFCC      
                53   UNLSN    EQU  $FFAE      
                54   UNTKL    EQU  $FFAB      
                55   CHRIN    EQU  $FFCF      
                56   CHKIN    EQU  $FFC6      
                57   PLOT     EQU  $FFF0      
                58   CHROUT   EQU  $FFD2      
                59   CINT     EQU  $FF81      
                60   IOINIT   EQU  $FF84      
                61   CLALL    EQU  $FFE7      
                62   SETMSG   EQU  $FF90      
                63   SETLFS   EQU  $FFBA      
                64   SETNAM   EQU  $FFBD      
                65   OPEN     EQU  $FFC0      
                66   LOAD     EQU  $FFD5      
                67   READST   EQU  $FFB7      
                68   SAVE     EQU  $FFD8      
                69   RAMTAS   EQU  $FF87      
                70   RESTOR   EQU  $FF8A      
                71   MEMTOP   EQU  $FF99      
                72   UNTLK    EQU  $FFAB      
                73   CLOSE    EQU  $FFC3      
                74   *
                75   *
                76            DUM  $2A7       
                77   *
                78   * PASCAL WORK AREAS
                79   *
                     ************************************************
                81   LINE:CNT EQU  $2         ; 2 BYTES
                82   LINE:NO  EQU  LINE:CNT   
                83   REG      EQU  $4         ; 2 BYTES
                84   ROWL     EQU  REG        
                85   ROWH     EQU  REG+1      
                86   SRCE     EQU  REG        
                87   REG2     EQU  $6         ; 2 BYTES
                88   DEST     EQU  REG2       
                89   WX       EQU  $8         ; 2 BYTES
                90   ERR:RTN  EQU  $B         ; 2 BYTES
                91   SYMTBL   EQU  $D         
                92   TOKEN    EQU  $16        
                93   TKNADR   EQU  $17        ; 2 BYTES
                94   TKNLEN   EQU  $19        
                95   EOF      EQU  $1A        
                96   LIST     EQU  $1B        
                97   NXTCHR   EQU  $1C        ; 2 BYTES
                98   VALUE    EQU  $1E        ; 3 BYTES
                99   DIGIT    EQU  $21        
                100  NOTRSV   EQU  $22        
                101  FRAME    EQU  $23        ; 2 BYTES
                102  LEVEL    EQU  $25        
                103  PCODE    EQU  $26        
                104  P        EQU  PCODE      
                105  PNTR     EQU  PCODE      
                106  ACT:PCDA EQU  $28        ; 2 BYTES
                107  DISPL    EQU  $2A        ; 2 BYTES
                108  OFFSET   EQU  $2C        ; 2 BYTES
                109  OPND     EQU  $2E        ; 3 BYTES
                110  DCODE    EQU  $31        
                111  ENDSYM   EQU  $32        ; 2 BYTES
                112  ARG      EQU  $34        
                113  PROMPT   EQU  $35        
                114  WORKD    EQU  $36        ; 2 BYTES
                115  ERRNO    EQU  $38        
                116  RTNADR   EQU  $39        ; 2 BYTES
                117  BSAVE    EQU  $3B        
                118  WORK     EQU  $3C        ; 2 BYTES
                119  PRCITM   EQU  $3E        ; 2 BYTES
                120  DSPWRK   EQU  $40        ; 2 BYTES
                121  PFLAG    EQU  $42        
                122  T        EQU  ENDSYM     ; STACK POINTER 2 BYTES
                123  TMP:PNTR EQU  T          
                124  BASE     EQU  $45        ; 2 BYTES
                125  TO       EQU  BASE       
                126  DATA     EQU  $47        ; 2 BYTES
                127  RUNNING  EQU  $49        
                128  UPR:CASE EQU  $4A        
                129  SCE:LIM  EQU  $4B        ; 2 BYTES
                130  FUNCTION EQU  SCE:LIM    
                131  SPRITENO EQU  SCE:LIM+1  
                132  STK:USE  EQU  $4D        
                133  VOICENO  EQU  STK:USE    
                134  SYMITM   EQU  $4E        ; 2 BYTES
                135  FROM     EQU  SYMITM     
                136  SYNTAX   EQU  $50        
                137  CHK:ARY  EQU  $51        
                138  SECRET   EQU  $52        
                139  VAL:CMP  EQU  $53        
                140  CTRLC:RT EQU  $54        ; 2 BYTES
                141  END:PCD  EQU  $56        ; 2 BYTES
                142  REGB     EQU  $58        
                143  REG2B    EQU  $59        
                144  LEFTCOL  EQU  $5A        
                145  SIGN     EQU  $5B        
                146  TEMP     EQU  $5C        ; 2 BYTES
                147  CALL     EQU  $5E        ; 2 BYTES
                148  COUNT    EQU  $60        
                149  LNCNT    EQU  $61        
                150  LS       EQU  $62        
                151  PCSVD    EQU  $63        ; 2 BYTES
                152  FIRST    EQU  $65        
                153  DBGTYP   EQU  $66        
                154  DBGFLG   EQU  $67        
                155  DEFP     EQU  $68        ; 2 BYTES
                156  DEFS     EQU  $6A        ; 2 BYTES
                157  DATTYP   EQU  $6C        
                158  DOS:FLG  EQU  DATTYP     
                159  A5       EQU  $6D        ; 2 BYTES
                160  MASK     EQU  A5         
                161  COLL:REG EQU  A5+1       
                162  ST       EQU  $90        
                163  DFLTN    EQU  $99        ; input device
                164  QUEUE    EQU  $C6        
                165  INDX     EQU  $C8        
                166  LXSP     EQU  $C9        
                167  BLNSW    EQU  $CC        
                168  BLNON    EQU  $CF        
                169  CRSW     EQU  $D0        
                170  BASL     EQU  $D1        
                171  CH       EQU  $D3        
                172  *
                173  P:STACK  EQU  $CED0      ; P-CODE STACK
                174  S:ANIMCT EQU  $CED8      ; count of frames
                175  S:ANIMPS EQU  $CEE0      ; current position
                176  S:ANIMCC EQU  $CEE8      ; current frame count
                177  S:ANIMFM EQU  $CEF0      ; no. of frames
                178  S:POINTR EQU  $CEF8      ; pointers - 16 per sprite
                179  SID:IMG  EQU  $CF7C      
                180  S:ACTIVE EQU  $CF98      
                181  S:XPOS   EQU  $CFA0      ; 3 bytes each
                182  S:YPOS   EQU  $CFB8      ; 2 bytes each
                183  S:XINC   EQU  $CFC8      ; 3 bytes each
                184  S:YINC   EQU  $CFE0      ; 2 bytes each
                185  S:COUNT  EQU  $CFF0      ; 2 bytes each
                186  *
                187  COUNT1   DS   1          
                188  COUNT2   DS   1          
                189  SYM:USE  DS   2          ; 2 BYTES
                190  SAVCUR   DS   6          ; 6 BYTES
                191  BPOINT   DS   20         
                192  CALL:P   EQU  BPOINT     
                193  CALL:A   EQU  BPOINT+1   
                194  CALL:X   EQU  BPOINT+2   
                195  CALL:Y   EQU  BPOINT+3   
                196  FNC:VAL  EQU  BPOINT+15  
                197  REMAIN   EQU  BPOINT+4   
                198  XPOSL    EQU  BPOINT+15  
                199  XPOSH    EQU  BPOINT+16  
                200  YPOS     EQU  BPOINT+17  
                201  CNTR     EQU  BPOINT+10  
                202  REP:FROM EQU  BPOINT+2   
                203  REP:TO   EQU  BPOINT+3   
                204  REP:LEN  EQU  BPOINT+4   
                205  PNTR:HI  EQU  BPOINT+5   
                206  IN:LGTH  EQU  BPOINT+6   
                207  LENGTH   EQU  BPOINT+7   
                208  FROM:ST  EQU  BPOINT+9   
                209  NUM:LINS EQU  BPOINT+11  
                210  ED:COM   EQU  BPOINT+13  
                211  TO:LINE  EQU  BPOINT+15  
                212  FND:FROM EQU  BPOINT+17  
                213  FND:TO   EQU  BPOINT+18  
                214  FND:POS  EQU  BPOINT+19  
                215  LASTP    DS   2          
                216  INCHAR   DS   1          
                217  IO:A     DS   1          
                218  IO:Y     DS   1          
                219  IO:X     DS   1          
                220  CURR:CHR DS   1          
                221  HEX:WK   DS   1          
                222           DS   2          
                223  STK:AVL  DS   1          
                224  STK:PAGE DS   1          
                225  STK:WRK  DS   1          
                226  STK:RT   DS   2          
                227  BEG:STK  DS   1          
                228  XSAVE    DS   1          
                229  RES      DS   3          ; 3 BYTES
                230  MCAND    DS   3          ; 3 BYTES
                231  DIVISOR  EQU  MCAND      
                232  DVDN     DS   3          ; 3 BYTES
                233  RMNDR    DS   1          
                234  TEMP1    DS   2          
                235  BIN:WRK  DS   3          
                236  ASC:WRK  DS   10         
                237  DEF:PCD  DS   1          
                238  REP:SIZE DS   1          
                239  NLN:FLAG DS   1          
                240  Q:FLAG   DS   1          
                241  FND:FLG  DS   1          
                242  FND:LEN  DS   1          
                243  UC:FLAG  DS   1          
                244  TRN:FLAG DS   1          
                245  GLB:FLAG DS   1          
                246  INT:RTN  DS   2          ; address to return to after a timer interrupt
                247  INT:TEMP DS   1          ; for interrupt service routine
                248  INT:TMP1 DS   1          
                249  INT:TMP2 DS   1          
                250  QT:TGL   DS   1          ; quote toggle
                251  QT:SIZE  DS   1          ; number of characters in reserved words
                252           DEND            
                     ************************************************
                254  *  SYMBOL TABLE DEFINES - RELATIVE TO SYMBOL TABLE ENTRY
                     ************************************************
                256  SYMPRV   EQU  0          
                257  SYMLVL   EQU  2          
                258  SYMTYP   EQU  3          
                259  SYMDSP   EQU  4          
                260  SYMARG   EQU  6          
                261  SYMSUB   EQU  6          
                262  SYMDAT   EQU  8          
                263  SYMLEN   EQU  9          
                264  SYMNAM   EQU  10         
                     ************************************************
                266  * ADDRESS CONSTANTS ETC.
                     ************************************************
                268           DUM  $8000      
                269           DS   3          
                270           DS   3          
                271           DS   3          
8009: 00 40     272  TS       DA   $4000      
800B: 10        273  SYM:SIZE DFB  16         
800C: 5B        274  LHB      ASC  '['
800D: 5D        275  RHB      ASC  ']'
800E: 22        276  QUOT:SYM ASC  '"' ; QUOTE SYMBOL
800F: 3A        277  DELIMIT  ASC  ':' ; FIND/REPLACE DELIMITER
8010: 04        278  PR:CHAN  DFB  4          ; PRINTER CHANNEL
8011: 08        279  DISK:CHN DFB  8          ; DISK CHANNEL
8012: 00        280           DFB  0          ; SPARE FOR NOW
                281           DEND            
                282  *
                     ************************************************
                284  * PART 1 VECTORS
                     ************************************************
                286  V1       EQU  P1         
                287  INIT     EQU  V1         
                288  GETNEXT  EQU  V1+3       
                289  COMSTL   EQU  V1+6       
                290  ISITHX   EQU  V1+9       
                291  ISITAL   EQU  V1+12      
                292  ISITNM   EQU  V1+15      
                293  CHAR     EQU  V1+18      
                294  GEN2:B   EQU  V1+21      
                295  DISHX    EQU  V1+24      
                296  ERROR    EQU  V1+27      
                297  GETCHK   EQU  V1+30      
                298  CHKTKN   EQU  V1+33      
                299  GENNOP   EQU  V1+36      
                300  GENADR   EQU  V1+39      
                301  GENNJP   EQU  V1+42      
                302  GENNJM   EQU  V1+45      
                303  TKNWRK   EQU  V1+48      
                304  PRBYTE   EQU  V1+51      
                305  GTOKEN   EQU  V1+54      
                306  WRKTKN   EQU  V1+57      
                307  FIXAD    EQU  V1+60      
                308  PSHWRK   EQU  V1+63      
                309  PULWRK   EQU  V1+66      
                310  PC       EQU  V1+69      
                311  PT       EQU  V1+72      
                312  PL       EQU  V1+75      
                313  PC8      EQU  V1+78      
                314  GETANS   EQU  V1+81      
                315  PUTSP    EQU  V1+84      
                316  DISPAD   EQU  V1+87      
                317  CROUT    EQU  V1+90      
                318  SHLVAL   EQU  V1+93      
                319  GET:NUM  EQU  V1+96      
                320  GET:HEX  EQU  V1+99      
                321  FND:ENQ  EQU  V1+102     
                322  PAUSE    EQU  V1+105     
                323  HOME     EQU  V1+108     
                324  RDKEY    EQU  V1+111     
                325  GENJMP   EQU  V1+114     
                326  GENRJMP  EQU  V1+117     
                     ************************************************
                328  * PART 2 STARTS HERE
                     ************************************************
                330           ORG  P2         
                     ************************************************
                332  * PART 2 VECTORS
                     ************************************************
8DD4: 4C 63 93  334           JMP  STMNT      
8DD7: 4C 04 93  335           JMP  EXPRES     
8DDA: 4C 13 8E  336           JMP  CHKLHP     
8DDD: 4C 1A 8E  337           JMP  CHKRHP     
8DE0: 4C 2D 8E  338           JMP  CHKLHB     
8DE3: 4C 38 8E  339           JMP  CHKRHB     
8DE6: 4C A6 8F  340           JMP  LOOKUP     
8DE9: 4C B1 8F  341           JMP  CHKDUP     
8DEC: 4C C1 8F  342           JMP  CONDEC     
8DEF: 4C DB 90  343           JMP  VARDEC     
8DF2: 4C B4 90  344           JMP  CONST      
8DF5: 4C 24 8E  345           JMP  GETSUB     
8DF8: 4C 6E 94  346           JMP  W:STRING   
8DFB: 4C 4C 80  347           JMP  WRKTKN     
8DFE: 4C EC 8F  348           JMP  SYMWRK     
8E01: 4C F7 8F  349           JMP  WRKSYM     
8E04: 4C 02 90  350           JMP  PSHPCODE   
8E07: 4C A8 90  351           JMP  CHK:STAK   
8E0A: 4C 54 8E  352           JMP  SEARCH     
8E0D: 4C C5 8E  353           JMP  ADDSYM     
8E10: 4C 77 8F  354           JMP  TKNJMP     
                     ************************************************
                356  *
                357  * PART 6 VECTORS
                     ************************************************
                359  BLOCK    EQU  P6         
                360  *
                361  *
                362  CHKLHP   EQU  *          
8E13: A9 28     363           LDA  #'('       
8E15: A2 1F     364           LDX  #31        
8E17: 4C 31 80  365           JMP  GETCHK     
                366  *
                367  CHKRHP   EQU  *          
8E1A: A9 29     368           LDA  #')'       
8E1C: A2 16     369           LDX  #22        
8E1E: 20 34 80  370           JSR  CHKTKN     
8E21: 4C 49 80  371           JMP  GTOKEN     
                372  *
                373  GETSUB   EQU  *          
8E24: 20 2D 8E  374           JSR  CHKLHB     
8E27: 20 04 93  375           JSR  EXPRES     
8E2A: 4C 38 8E  376           JMP  CHKRHB     
                377  *
                378  CHKLHB   EQU  *          
8E2D: AD 0C 80  379           LDA  LHB        
8E30: A2 21     380           LDX  #33        
8E32: 20 31 80  381           JSR  GETCHK     
8E35: 4C 49 80  382           JMP  GTOKEN     
                383  *
                384  CHKRHB   EQU  *          
8E38: AD 0D 80  385           LDA  RHB        
8E3B: A2 22     386           LDX  #34        
8E3D: 20 34 80  387           JSR  CHKTKN     
8E40: 4C 49 80  388           JMP  GTOKEN     
                389  *
                390  GET:LEV  EQU  *          
8E43: A5 25     391           LDA  LEVEL      
8E45: A0 02     392           LDY  #SYMLVL    
8E47: 38        393           SEC             
8E48: F1 4E     394           SBC  (SYMITM),Y 
8E4A: 85 2A     395           STA  DISPL      
8E4C: 60        396           RTS             
                397  *
                398  GET:DAT  EQU  *          
8E4D: A0 08     399           LDY  #SYMDAT    
8E4F: B1 4E     400           LDA  (SYMITM),Y 
8E51: 85 6C     401           STA  DATTYP     
8E53: 60        402           RTS             
                403  *
                404  *
                     ************************************************
                406  *SEARCH SYMBOL TABLE
                     ************************************************
                408  SEARCH   EQU  *          
8E54: A5 32     409           LDA  ENDSYM     
8E56: 85 4E     410           STA  SYMITM     
8E58: A5 33     411           LDA  ENDSYM+1   
8E5A: 85 4F     412           STA  SYMITM+1   
                413  SEA1     EQU  *          
8E5C: A0 00     414           LDY  #SYMPRV    
8E5E: B1 4E     415           LDA  (SYMITM),Y 
8E60: AA        416           TAX             
8E61: C8        417           INY             
8E62: B1 4E     418           LDA  (SYMITM),Y 
8E64: 85 4F     419           STA  SYMITM+1   ; PREVIOUS LINK
8E66: 8A        420           TXA             
8E67: 85 4E     421           STA  SYMITM     
8E69: 05 4F     422           ORA  SYMITM+1   
8E6B: D0 01     423           BNE  SEA2       ; MORE TO GO
8E6D: 60        424           RTS             ; FINISHED 
                425  SEA2     EQU  *          
8E6E: A0 09     426           LDY  #SYMLEN    
8E70: B1 4E     427           LDA  (SYMITM),Y 
8E72: C5 19     428           CMP  TKNLEN     
8E74: D0 E6     429           BNE  SEA1       ; WRONG LENGTH
8E76: A5 4E     430           LDA  SYMITM     
8E78: 18        431           CLC             
8E79: 69 0A     432           ADC  #SYMNAM    
8E7B: 85 06     433           STA  DEST       
8E7D: A5 4F     434           LDA  SYMITM+1   
8E7F: 69 00     435           ADC  #0         
8E81: 85 07     436           STA  DEST+1     
8E83: A5 17     437           LDA  TKNADR     
8E85: 85 04     438           STA  SRCE       
8E87: A5 18     439           LDA  TKNADR+1   
8E89: 85 05     440           STA  SRCE+1     
8E8B: A4 19     441           LDY  TKNLEN     
8E8D: 20 19 80  442           JSR  COMSTL     
8E90: D0 CA     443           BNE  SEA1       ; NOT THAT ONE 
8E92: 20 4D 8E  444           JSR  GET:DAT    
8E95: A0 02     445           LDY  #SYMLVL    
8E97: B1 4E     446           LDA  (SYMITM),Y 
8E99: AA        447           TAX             ; LEVEL
8E9A: A0 03     448           LDY  #SYMTYP    
8E9C: B1 4E     449           LDA  (SYMITM),Y 
8E9E: 85 3B     450           STA  BSAVE      
8EA0: C9 43     451           CMP  #'C'       ; CONSTANT
8EA2: D0 13     452           BNE  SEA4       
8EA4: A0 04     453           LDY  #SYMDSP    
8EA6: B1 4E     454           LDA  (SYMITM),Y 
8EA8: 85 1E     455           STA  VALUE      
8EAA: C8        456           INY             
8EAB: B1 4E     457           LDA  (SYMITM),Y 
8EAD: 85 1F     458           STA  VALUE+1    
8EAF: C8        459           INY             
8EB0: B1 4E     460           LDA  (SYMITM),Y 
8EB2: 85 20     461           STA  VALUE+2    
8EB4: 4C C2 8E  462           JMP  SEA3       
                463  SEA4     EQU  *          ; NOT CONSTANT
8EB7: C9 56     464           CMP  #'V'       ; VARIABLE?
8EB9: F0 04     465           BEQ  SEA5       ; YES
8EBB: C9 59     466           CMP  #'Y'       ; ARGUMENT?
8EBD: D0 03     467           BNE  SEA3       ; NO
                468  SEA5     EQU  *          
8EBF: 20 15 90  469           JSR  GET:OFF    
                470  SEA3     EQU  *          
8EC2: A5 3B     471           LDA  BSAVE      
8EC4: 60        472           RTS             ; SHOULD SET 'NEQ' FLAG
                     ************************************************
                474  * ADD SYMBOL TO SYMBOL TABLE
                     ************************************************
                476  ADDSYM   EQU  *          
8EC5: A6 32     477           LDX  ENDSYM     
8EC7: 86 4E     478           STX  SYMITM     
8EC9: A6 33     479           LDX  ENDSYM+1   
8ECB: 86 4F     480           STX  SYMITM+1   
8ECD: A0 03     481           LDY  #SYMTYP    
8ECF: 91 4E     482           STA  (SYMITM),Y 
8ED1: A0 02     483           LDY  #SYMLVL    
8ED3: 48        484           PHA             
8ED4: A5 25     485           LDA  LEVEL      
8ED6: 91 4E     486           STA  (SYMITM),Y 
8ED8: A0 09     487           LDY  #SYMLEN    
8EDA: A5 19     488           LDA  TKNLEN     
8EDC: 91 4E     489           STA  (SYMITM),Y 
8EDE: A8        490           TAY             
8EDF: 88        491           DEY             
8EE0: A5 4E     492           LDA  SYMITM     
8EE2: 18        493           CLC             
8EE3: 69 0A     494           ADC  #SYMNAM    
8EE5: 85 06     495           STA  DEST       
8EE7: A5 4F     496           LDA  SYMITM+1   
8EE9: 69 00     497           ADC  #0         
8EEB: 85 07     498           STA  DEST+1     
                499  ADD1     EQU  *          
8EED: B1 17     500           LDA  (TKNADR),Y 
8EEF: C9 C1     501           CMP  #$C1       
8EF1: 90 02     502           BLT  ADD2       
8EF3: 29 7F     503           AND  #$7F       ; UPPER CASE 
                504  ADD2     EQU  *          
8EF5: 91 06     505           STA  (DEST),Y   
8EF7: 88        506           DEY             
8EF8: 10 F3     507           BPL  ADD1       
8EFA: A5 06     508           LDA  DEST       
8EFC: 18        509           CLC             
8EFD: 65 19     510           ADC  TKNLEN     
8EFF: 85 32     511           STA  ENDSYM     
8F01: A5 07     512           LDA  DEST+1     
8F03: 69 00     513           ADC  #0         
8F05: 85 33     514           STA  ENDSYM+1   
8F07: AD AA 02  515           LDA  SYM:USE+1  
8F0A: C5 33     516           CMP  ENDSYM+1   
8F0C: 90 09     517           BLT  SYM:NEW    
8F0E: D0 11     518           BNE  SYM:LOW    
8F10: AD A9 02  519           LDA  SYM:USE    
8F13: C5 32     520           CMP  ENDSYM     
8F15: B0 0A     521           BGE  SYM:LOW    
8F17: A5 32     522  SYM:NEW  LDA  ENDSYM     
8F19: 8D A9 02  523           STA  SYM:USE    
8F1C: A5 33     524           LDA  ENDSYM+1   
8F1E: 8D AA 02  525           STA  SYM:USE+1  
                526  SYM:LOW  EQU  *          
8F21: A5 33     527           LDA  ENDSYM+1   
8F23: CD 84 02  528           CMP  HIMEM+1    
8F26: 90 0E     529           BLT  SYM:NTFL   
8F28: D0 07     530           BNE  SYM:FULL   
8F2A: A5 32     531           LDA  ENDSYM     
8F2C: CD 83 02  532           CMP  HIMEM      
8F2F: 90 05     533           BLT  SYM:NTFL   
8F31: A2 25     534  SYM:FULL LDX  #37        
8F33: 20 2E 80  535           JSR  ERROR      
                536  SYM:NTFL EQU  *          
                537  *
8F36: 68        538           PLA             
8F37: AA        539           TAX             ; ENTRY TYPE
8F38: C9 43     540           CMP  #'C'       ; CONSTANT??
8F3A: D0 13     541           BNE  ADD4       
8F3C: A0 04     542           LDY  #SYMDSP    
8F3E: A5 1E     543           LDA  VALUE      
8F40: 91 4E     544           STA  (SYMITM),Y 
8F42: C8        545           INY             
8F43: A5 1F     546           LDA  VALUE+1    
8F45: 91 4E     547           STA  (SYMITM),Y 
8F47: C8        548           INY             
8F48: A5 20     549           LDA  VALUE+2    
8F4A: 91 4E     550           STA  (SYMITM),Y 
8F4C: 4C 6B 8F  551           JMP  ADD9       
                552  ADD4     EQU  *          
8F4F: A0 08     553           LDY  #SYMDAT    
8F51: A9 01     554           LDA  #1         
8F53: 91 4E     555           STA  (SYMITM),Y 
8F55: 8A        556           TXA             
8F56: C9 56     557           CMP  #'V'       
8F58: D0 11     558           BNE  ADD9       
8F5A: A0 05     559           LDY  #SYMDSP+1  
8F5C: A5 24     560           LDA  FRAME+1    
8F5E: 91 4E     561           STA  (SYMITM),Y 
8F60: 88        562           DEY             
8F61: A5 23     563           LDA  FRAME      
8F63: 91 4E     564           STA  (SYMITM),Y 
8F65: E6 23     565           INC  FRAME      
8F67: D0 02     566           BNE  ADD9       
8F69: E6 24     567           INC  FRAME+1    
                568  ADD9     EQU  *          
8F6B: A0 00     569           LDY  #SYMPRV    
8F6D: A5 4E     570           LDA  SYMITM     
8F6F: 91 32     571           STA  (ENDSYM),Y 
8F71: C8        572           INY             
8F72: A5 4F     573           LDA  SYMITM+1   
8F74: 91 32     574           STA  (ENDSYM),Y 
8F76: 60        575           RTS             
                576  *
                     ************************************************
                578  * JUMP ON TOKEN
                579  * X/Y = START OF TABLE
                580  * END OF TABLE IS A NULL
                581  * A = TOKEN
                     ************************************************
                583  TKNJMP   EQU  *          
8F77: 86 04     584           STX  REG        
8F79: 84 05     585           STY  REG+1      
8F7B: AA        586           TAX             
                587  JMP1     EQU  *          
8F7C: A0 00     588           LDY  #0         
8F7E: B1 04     589           LDA  (REG),Y    
8F80: D0 02     590           BNE  JMP2       
8F82: 8A        591           TXA             
8F83: 60        592           RTS             
                593  JMP2     EQU  *          
8F84: 8A        594           TXA             
8F85: D1 04     595           CMP  (REG),Y    
8F87: D0 10     596           BNE  JMP3       
8F89: 68        597           PLA             
8F8A: 68        598           PLA             ; REMOVE RETURN ADDRESS
8F8B: C8        599           INY             
8F8C: B1 04     600           LDA  (REG),Y    
8F8E: 85 06     601           STA  REG2       
8F90: C8        602           INY             
8F91: B1 04     603           LDA  (REG),Y    
8F93: 85 07     604           STA  REG2+1     
8F95: 8A        605           TXA             
8F96: 6C 06 00  606           JMP  (REG2)     
                607  JMP3     EQU  *          
8F99: A5 04     608           LDA  REG        
8F9B: 18        609           CLC             
8F9C: 69 03     610           ADC  #3         
8F9E: 85 04     611           STA  REG        
8FA0: 90 DA     612           BCC  JMP1       
8FA2: E6 05     613           INC  REG+1      
8FA4: D0 D6     614           BNE  JMP1       
                615  *
                616  LOOKUP   EQU  *          
8FA6: 20 54 8E  617           JSR  SEARCH     
8FA9: D0 05     618           BNE  LOOK1      
8FAB: A2 0B     619           LDX  #11        
8FAD: 20 2E 80  620           JSR  ERROR      
8FB0: 60        621  LOOK1    RTS             
                622  *
8FB1: 20 54 8E  623  CHKDUP   JSR  SEARCH     
8FB4: F0 0A     624           BEQ  DUP9       
8FB6: 8A        625           TXA             
8FB7: C5 25     626           CMP  LEVEL      
8FB9: D0 05     627           BNE  DUP9       
8FBB: A2 26     628           LDX  #38        
8FBD: 20 2E 80  629           JSR  ERROR      
8FC0: 60        630  DUP9     RTS             
                631  *
                632  * CONSTANT DEC
                633  *
                634  CONDEC   EQU  *          
8FC1: A9 49     635           LDA  #'I'       
8FC3: A2 04     636           LDX  #4         
8FC5: 20 34 80  637           JSR  CHKTKN     
8FC8: 20 43 80  638           JSR  TKNWRK     
8FCB: A5 19     639           LDA  TKNLEN     
8FCD: 48        640           PHA             
8FCE: A9 3D     641           LDA  #'='       
8FD0: A2 03     642           LDX  #3         
8FD2: 20 31 80  643           JSR  GETCHK     
8FD5: 20 49 80  644           JSR  GTOKEN     
8FD8: 20 B4 90  645           JSR  CONST      
8FDB: 20 4C 80  646           JSR  WRKTKN     
8FDE: 68        647           PLA             
8FDF: 85 19     648           STA  TKNLEN     
8FE1: 20 B1 8F  649           JSR  CHKDUP     
8FE4: A9 43     650           LDA  #'C'       
8FE6: 20 C5 8E  651           JSR  ADDSYM     
8FE9: 4C 49 80  652           JMP  GTOKEN     
                653  *
                654  *
                655  *--- SYMITM --> WORK
                656  *
                657  SYMWRK   EQU  *          
8FEC: 48        658           PHA             
8FED: A5 4E     659           LDA  SYMITM     
8FEF: 85 3C     660           STA  WORK       
8FF1: A5 4F     661           LDA  SYMITM+1   
8FF3: 85 3D     662           STA  WORK+1     
8FF5: 68        663           PLA             
8FF6: 60        664           RTS             
                665  * 
                666  *--- WORK --> SYMITM
                667  * 
                668  WRKSYM   EQU  *          
8FF7: 48        669           PHA             
8FF8: A5 3C     670           LDA  WORK       
8FFA: 85 4E     671           STA  SYMITM     
8FFC: A5 3D     672           LDA  WORK+1     
8FFE: 85 4F     673           STA  SYMITM+1   
9000: 68        674           PLA             
9001: 60        675           RTS             
                676  *
                677  * PUSH PCODE ONTO STACK
                678  *
                679  PSHPCODE EQU  *          
9002: 85 3B     680           STA  BSAVE      
9004: 68        681           PLA             
9005: AA        682           TAX             
9006: 68        683           PLA             
9007: A8        684           TAY             
9008: A5 27     685           LDA  PCODE+1    
900A: 48        686           PHA             
900B: A5 26     687           LDA  PCODE      
900D: 48        688           PHA             
900E: 98        689           TYA             
900F: 48        690           PHA             
9010: 8A        691           TXA             
9011: 48        692           PHA             
9012: A5 3B     693           LDA  BSAVE      
9014: 60        694           RTS             
                695  *
                696  GET:OFF  EQU  *          
9015: 48        697           PHA             
9016: A0 04     698           LDY  #SYMDSP    
9018: B1 4E     699           LDA  (SYMITM),Y 
901A: 85 2C     700           STA  OFFSET     
901C: C8        701           INY             
901D: B1 4E     702           LDA  (SYMITM),Y 
901F: 85 2D     703           STA  OFFSET+1   
9021: A0 03     704           LDY  #SYMTYP    
9023: B1 4E     705           LDA  (SYMITM),Y 
9025: C9 56     706           CMP  #'V'       
9027: F0 08     707           BEQ  GETO:1     
9029: C9 41     708           CMP  #'A'       
902B: F0 04     709           BEQ  GETO:1     
902D: C9 59     710           CMP  #'Y'       
902F: D0 0D     711           BNE  GETO:2     
                712  GETO:1   EQU  *          
9031: 38        713           SEC             
9032: A9 FD     714           LDA  #$FD       
9034: E5 2C     715           SBC  OFFSET     
9036: 85 2C     716           STA  OFFSET     
9038: A9 FF     717           LDA  #$FF       
903A: E5 2D     718           SBC  OFFSET+1   
903C: 85 2D     719           STA  OFFSET+1   
                720  GETO:2   EQU  *          
903E: 68        721           PLA             
903F: 60        722           RTS             
                723  *
                724  GETEXPR  EQU  *          
9040: 20 49 80  725           JSR  GTOKEN     
9043: 4C 04 93  726           JMP  EXPRES     
                727  *
                728  *
                729  PCD:WRKD EQU  *          
9046: 48        730           PHA             
9047: A5 26     731           LDA  PCODE      
9049: 85 36     732           STA  WORKD      
904B: A5 27     733           LDA  PCODE+1    
904D: 85 37     734           STA  WORKD+1    
904F: 68        735           PLA             
9050: 60        736           RTS             
                737  *
                738  WRK:OPND EQU  *          
9051: 48        739           PHA             
9052: A5 3C     740           LDA  WORK       
9054: 85 2E     741           STA  OPND       
9056: A5 3D     742           LDA  WORK+1     
9058: 85 2F     743           STA  OPND+1     
905A: 68        744           PLA             
905B: 60        745           RTS             
                746  *
                747  WRKD:WRK EQU  *          
905C: 48        748           PHA             
905D: A5 36     749           LDA  WORKD      
905F: 85 3C     750           STA  WORK       
9061: A5 37     751           LDA  WORKD+1    
9063: 85 3D     752           STA  WORK+1     
9065: 68        753           PLA             
9066: 60        754           RTS             
                755  *
                756  WRK:WRKD EQU  *          
9067: 48        757           PHA             
9068: A5 3C     758           LDA  WORK       
906A: 85 36     759           STA  WORKD      
906C: A5 3D     760           LDA  WORK+1     
906E: 85 37     761           STA  WORKD+1    
9070: 68        762           PLA             
9071: 60        763           RTS             
                764  *
                765  GET:COMM EQU  *          
9072: A9 2C     766           LDA  #','       
9074: A2 20     767           LDX  #32        
9076: 4C 34 80  768           JMP  CHKTKN     
                769  *
                770  GET:ITEM EQU  *          
9079: 20 72 90  771           JSR  GET:COMM   ; check for comma
907C: 4C 40 90  772           JMP  GETEXPR    
                773  *
                774  VAL:MOVE EQU  *          
907F: 48        775           PHA             
9080: 18        776           CLC             
9081: A5 1E     777           LDA  VALUE      
9083: 85 2A     778           STA  DISPL      
9085: 10 01     779           BPL  VAL:1      
9087: 38        780           SEC             
                781  VAL:1    EQU  *          
9088: A5 1F     782           LDA  VALUE+1    
908A: F0 01     783           BEQ  VAL:2      
908C: 38        784           SEC             
                785  VAL:2    EQU  *          
908D: 85 2C     786           STA  OFFSET     
908F: A5 20     787           LDA  VALUE+2    
9091: 85 2D     788           STA  OFFSET+1   
9093: F0 01     789           BEQ  VAL:3      
9095: 38        790           SEC             
                791  VAL:3    EQU  *          
9096: 90 07     792           BCC  VAL:5      
9098: A9 00     793           LDA  #0         
909A: 20 3A 80  794           JSR  GENADR     
909D: 68        795           PLA             
909E: 60        796           RTS             
                797  VAL:5    EQU  *          
909F: A5 1E     798           LDA  VALUE      
90A1: 09 80     799           ORA  #$80       
90A3: 20 37 80  800           JSR  GENNOP     
90A6: 68        801           PLA             
90A7: 60        802           RTS             
                803  *
                804  *
                805  CHK:STAK EQU  *          
90A8: BA        806           TSX             
90A9: 8A        807           TXA             
90AA: C9 20     808           CMP  #MAX:STK   
90AC: 90 01     809           BLT  STK:FULL   
90AE: 60        810           RTS             
                811  STK:FULL EQU  *          
90AF: A2 1B     812  STK:ERR  LDX  #27        
90B1: 20 2E 80  813           JSR  ERROR      ; FULL
                814  *
                815  *
                816  * CONST
                817  *
                818  CONST    EQU  *          
90B4: A5 16     819           LDA  TOKEN      
90B6: C9 4E     820           CMP  #'N'       
90B8: F0 20     821           BEQ  CONST9     
90BA: C9 49     822           CMP  #'I'       
90BC: F0 0E     823           BEQ  CONST1     
90BE: CD 0E 80  824           CMP  QUOT:SYM   
90C1: D0 0E     825           BNE  CONST3     
90C3: A6 19     826           LDX  TKNLEN     
90C5: E0 04     827           CPX  #4         
90C7: 90 11     828           BLT  CONST9     
90C9: 4C 5A 92  829           JMP  FACERR1    ; STRING TOO BIG
90CC: 20 54 8E  830  CONST1   JSR  SEARCH     
90CF: D0 05     831           BNE  CONST2     
                832  CONST3   EQU  *          
90D1: A2 02     833           LDX  #2         
90D3: 20 2E 80  834           JSR  ERROR      
90D6: C9 43     835  CONST2   CMP  #'C'       
90D8: D0 F7     836           BNE  CONST3     
90DA: 60        837  CONST9   RTS             
                838  *
                839  * VARIABLE DEC
                840  *
90DB: A9 49     841  VARDEC   LDA  #'I'       
90DD: A2 04     842           LDX  #4         
90DF: 20 34 80  843           JSR  CHKTKN     
90E2: 20 B1 8F  844           JSR  CHKDUP     
90E5: A9 56     845           LDA  #'V'       
90E7: 20 C5 8E  846           JSR  ADDSYM     
90EA: 4C 49 80  847           JMP  GTOKEN     
                848  *
                849  * SIMPLE EXPRESSION
                850  *
                851  SIMEXP   EQU  *          
90ED: A5 16     852           LDA  TOKEN      
90EF: C9 2B     853           CMP  #'+'       
90F1: F0 04     854           BEQ  SIM1       
90F3: C9 2D     855           CMP  #'-'       
90F5: D0 48     856           BNE  SIM2       
90F7: 48        857  SIM1     PHA             
90F8: 20 49 80  858           JSR  GTOKEN     
90FB: 20 5F 91  859           JSR  TERM       
90FE: 68        860           PLA             
90FF: C9 2D     861           CMP  #'-'       
9101: D0 05     862           BNE  SIM3       
9103: A9 02     863           LDA  #2         
9105: 20 37 80  864           JSR  GENNOP     ; NEGATE
9108: A5 16     865  SIM3     LDA  TOKEN      
910A: C9 2B     866           CMP  #'+'       
910C: F0 0D     867           BEQ  SIM4       
910E: C9 2D     868           CMP  #'-'       
9110: F0 09     869           BEQ  SIM4       
9112: C9 8A     870           CMP  #$8A       ; OR
9114: F0 05     871           BEQ  SIM4       
9116: C9 A4     872           CMP  #$A4       ; XOR
9118: F0 01     873           BEQ  SIM4       
911A: 60        874           RTS             
911B: 48        875  SIM4     PHA             
911C: 20 49 80  876           JSR  GTOKEN     
911F: 20 5F 91  877           JSR  TERM       
9122: 68        878           PLA             
9123: C9 2D     879           CMP  #'-'       
9125: F0 10     880           BEQ  SIM5       
9127: C9 2B     881           CMP  #'+'       
9129: F0 10     882           BEQ  SIM6       
912B: C9 A4     883           CMP  #$A4       ; XOR 
912D: F0 16     884           BEQ  SIM8       
912F: A9 1A     885           LDA  #26        ; OR
9131: 20 37 80  886  SIM7     JSR  GENNOP     
9134: 4C 08 91  887           JMP  SIM3       
9137: A9 06     888  SIM5     LDA  #6         ; MINUS
9139: D0 F6     889           BNE  SIM7       
913B: A9 04     890  SIM6     LDA  #4         ; PLUS
913D: D0 F2     891           BNE  SIM7       
913F: 20 5F 91  892  SIM2     JSR  TERM       
9142: 4C 08 91  893           JMP  SIM3       
9145: A9 3A     894  SIM8     LDA  #58        ; XOR
9147: D0 E8     895           BNE  SIM7       
                896  *
                897  * TERM
                898  *
9149: 2A        899  TERMT1   ASC  '*'
914A: 6C 91     900           DA   TERM1      
914C: 8B        901           DFB  $8B        
914D: 6C 91     902           DA   TERM1      
914F: 2F        903           ASC  '/'
9150: 6C 91     904           DA   TERM1      
9152: 8D        905           DFB  $8D        
9153: 6C 91     906           DA   TERM1      
9155: 8C        907           DFB  $8C        
9156: 6C 91     908           DA   TERM1      
9158: 8E        909           DFB  $8E        
9159: 6C 91     910           DA   TERM1      
915B: 8F        911           DFB  $8F        
915C: 6C 91     912           DA   TERM1      
915E: 00        913           DFB  0          
                914  *
915F: 20 AD 91  915  TERM     JSR  FACTOR     
9162: A2 49     916  TERM2    LDX  #TERMT1    
9164: A0 91     917           LDY  #>TERMT1   
9166: A5 16     918           LDA  TOKEN      
9168: 20 77 8F  919           JSR  TKNJMP     
916B: 60        920           RTS             
                921  *
916C: 48        922  TERM1    PHA             
916D: 20 49 80  923           JSR  GTOKEN     
9170: 20 AD 91  924           JSR  FACTOR     
9173: 68        925           PLA             
9174: A2 97     926           LDX  #TERMT3    
9176: A0 91     927           LDY  #>TERMT3   
9178: 20 77 8F  928           JSR  TKNJMP     
                929  *
917B: A9 0A     930  TERM4    LDA  #10        
917D: 20 37 80  931  TERM3    JSR  GENNOP     
9180: 4C 62 91  932           JMP  TERM2      
9183: A9 1B     933  TERM5    LDA  #27        ; AND
9185: D0 F6     934           BNE  TERM3      
9187: A9 0B     935  TERM6    LDA  #11        ; MOD
9189: D0 F2     936           BNE  TERM3      
918B: A9 22     937  TERM7    LDA  #34        
918D: D0 EE     938           BNE  TERM3      
918F: A9 24     939  TERM8    LDA  #36        
9191: D0 EA     940           BNE  TERM3      
9193: A9 08     941  TERM9    LDA  #8         
9195: D0 E6     942           BNE  TERM3      
                943  *
9197: 8B        944  TERMT3   DFB  $8B        
9198: 7B 91     945           DA   TERM4      
919A: 2F        946           ASC  '/'
919B: 7B 91     947           DA   TERM4      
919D: 8D        948           DFB  $8D        
919E: 83 91     949           DA   TERM5      
91A0: 8C        950           DFB  $8C        
91A1: 87 91     951           DA   TERM6      
91A3: 8E        952           DFB  $8E        
91A4: 8B 91     953           DA   TERM7      
91A6: 8F        954           DFB  $8F        
91A7: 8F 91     955           DA   TERM8      
91A9: 2A        956           ASC  '*'
91AA: 93 91     957           DA   TERM9      
91AC: 00        958           DFB  0          
                959  *
                960  * FACTOR
                961  *
91AD: 20 A8 90  962  FACTOR   JSR  CHK:STAK   
91B0: A5 16     963           LDA  TOKEN      
91B2: A2 B5     964           LDX  #FACTB1    
91B4: A0 92     965           LDY  #>FACTB1   
91B6: 20 77 8F  966           JSR  TKNJMP     
91B9: A2 17     967           LDX  #23        
91BB: 20 2E 80  968           JSR  ERROR      
                969  *
91BE: 20 A6 8F  970  IDENT    JSR  LOOKUP     
91C1: C9 50     971  IDENT1   CMP  #'P'       
91C3: D0 05     972           BNE  IDENT2     
91C5: A2 15     973           LDX  #21        
91C7: 20 2E 80  974           JSR  ERROR      
91CA: C9 59     975  IDENT2   CMP  #'Y'       
91CC: D0 1D     976           BNE  IDENT3     
91CE: A9 00     977           LDA  #0         
91D0: 85 2F     978           STA  OPND+1     
91D2: A9 03     979           LDA  #3         
91D4: 85 2E     980           STA  OPND       
91D6: A0 00     981           LDY  #SYMPRV    
91D8: B1 4E     982           LDA  (SYMITM),Y 
91DA: AA        983           TAX             
91DB: C8        984           INY             
91DC: B1 4E     985           LDA  (SYMITM),Y 
91DE: 85 4F     986           STA  SYMITM+1   
91E0: 8A        987           TXA             
91E1: 85 4E     988           STA  SYMITM     
91E3: A9 3B     989           LDA  #59        
91E5: 20 85 80  990           JSR  GENJMP     
91E8: 4C 4D 96  991           JMP  FNCPRC     
                992  *
91EB: C9 41     993  IDENT3   CMP  #'A'       
91ED: F0 30     994           BEQ  IDENT4     
91EF: C9 43     995           CMP  #'C'       
91F1: D0 0E     996           BNE  IDENT5     
91F3: 20 7F 90  997           JSR  VAL:MOVE   
91F6: 4C 14 92  998           JMP  IDENT7     
                999  *
91F9: A9 0C     1000 FACAD1   LDA  #12        
91FB: 20 03 92  1001          JSR  IDENT5:A   
91FE: 4C 1A 8E  1002          JMP  CHKRHP     
                1003 *
9201: A9 2C     1004 IDENT5   LDA  #44        
9203: 48        1005 IDENT5:A PHA             
                1006 * 
9204: 86 3B     1007          STX  BSAVE      
9206: A5 25     1008          LDA  LEVEL      
9208: 38        1009          SEC             
9209: E5 3B     1010          SBC  BSAVE      
920B: 85 2A     1011          STA  DISPL      
920D: 68        1012          PLA             
920E: 18        1013 IDENT6   CLC             
920F: 65 6C     1014          ADC  DATTYP     
9211: 20 3A 80  1015          JSR  GENADR     
9214: 4C 49 80  1016 IDENT7   JMP  GTOKEN     
                1017 *
9217: A9 0E     1018 FACAD2   LDA  #14        
9219: 20 21 92  1019          JSR  IDENT4:A   
921C: 4C 1A 8E  1020          JMP  CHKRHP     
                1021 *
921F: A9 30     1022 IDENT4   LDA  #48        
9221: 48        1023 IDENT4:A PHA             
                1024 * 
9222: 20 EC 8F  1025          JSR  SYMWRK     
9225: 20 52 80  1026          JSR  PSHWRK     
9228: 20 24 8E  1027          JSR  GETSUB     
922B: 20 55 80  1028          JSR  PULWRK     
922E: 20 F7 8F  1029          JSR  WRKSYM     
9231: 20 4D 8E  1030          JSR  GET:DAT    
9234: 20 43 8E  1031          JSR  GET:LEV    
9237: 20 15 90  1032          JSR  GET:OFF    
923A: 68        1033          PLA             
923B: 18        1034          CLC             
923C: 65 6C     1035          ADC  DATTYP     
923E: 4C 3A 80  1036          JMP  GENADR     
                1037 *
                1038 * ADDRESS (IDENTIFIER) 
                1039 *
                1040 *
                1041 FACADR   EQU  *          
9241: 20 13 8E  1042          JSR  CHKLHP     
9244: 20 B6 94  1043          JSR  GET:LOOK   
9247: C9 56     1044          CMP  #'V'       
9249: F0 AE     1045          BEQ  FACAD1     
924B: C9 41     1046          CMP  #'A'       
924D: F0 C8     1047          BEQ  FACAD2     
924F: A2 17     1048          LDX  #23        
9251: 20 2E 80  1049          JSR  ERROR      
                1050 *
                1051 *
9254: A5 19     1052 FACSTR   LDA  TKNLEN     
9256: C9 04     1053          CMP  #4         
9258: 90 05     1054          BLT  FACNUM     
925A: A2 1D     1055 FACERR1  LDX  #29        ; STRING TOO BIG
925C: 20 2E 80  1056          JSR  ERROR      
                1057 FACNUM   EQU  *          
925F: 20 7F 90  1058          JSR  VAL:MOVE   
9262: 4C 14 92  1059          JMP  IDENT7     
                1060 *
9265: 20 40 90  1061 PAREN    JSR  GETEXPR    
9268: 4C 1A 8E  1062          JMP  CHKRHP     
                1063 *
926B: A9 00     1064 FACMEM   LDA  #0         
926D: 85 6C     1065          STA  DATTYP     
926F: F0 04     1066          BEQ  FACM2      
9271: A9 01     1067 FACMMC   LDA  #1         
9273: 85 6C     1068          STA  DATTYP     
9275: A5 6C     1069 FACM2    LDA  DATTYP     
9277: 48        1070          PHA             
9278: 20 24 8E  1071          JSR  GETSUB     
927B: 68        1072          PLA             
927C: 18        1073          CLC             
927D: 69 2E     1074          ADC  #46        
927F: D0 08     1075          BNE  GENNOP1    
                1076 *
9281: 20 49 80  1077 FACNOT   JSR  GTOKEN     
9284: 20 AD 91  1078          JSR  FACTOR     
9287: A9 20     1079          LDA  #32        
9289: 4C 37 80  1080 GENNOP1  JMP  GENNOP     
                1081 *
928C: 20 AB 92  1082 SPCL:FAC JSR  TKNCNV     
928F: 20 37 80  1083 FACRND1  JSR  GENNOP     
9292: 4C 49 80  1084          JMP  GTOKEN     
                1085 *
9295: A9 15     1086 S:FREEZE LDA  #$15       
9297: D0 0F     1087          BNE  WAIT1:J    
                1088 *
9299: A9 5F     1089 CLOSE:FL LDA  #$5F       
929B: D0 0B     1090          BNE  WAIT1:J    
                1091 *
929D: A9 60     1092 GET      LDA  #$60       
929F: D0 07     1093          BNE  WAIT1:J    
                1094 *
92A1: A9 61     1095 PUT      LDA  #$61       
92A3: D0 03     1096          BNE  WAIT1:J    
                1097 *
                1098 *
92A5: 20 AB 92  1099 SPC:FAC2 JSR  TKNCNV     
92A8: 4C CE 95  1100 WAIT1:J  JMP  WAIT:1     ; now get its argument
                1101 *
                1102 TKNCNV   EQU  *          
92AB: A5 16     1103          LDA  TOKEN      
92AD: 38        1104          SEC             
92AE: E9 A0     1105          SBC  #$A0       
92B0: 60        1106          RTS             
                1107 *
92B1: A9 07     1108 FACGTKY  LDA  #7         
92B3: D0 DA     1109          BNE  FACRND1    ; getkey
                1110 *
92B5: 49        1111 FACTB1   ASC  'I'
92B6: BE 91     1112          DA   IDENT      
92B8: 4E        1113          ASC  'N'
92B9: 5F 92     1114          DA   FACNUM     
92BB: 22        1115 FACTQT1  DFB  $22        ; QUOTE SYMBOL
92BC: 54 92     1116          DA   FACSTR     
92BE: 28        1117          ASC  '('
92BF: 65 92     1118          DA   PAREN      
92C1: 91        1119          DFB  $91        
92C2: 6B 92     1120          DA   FACMEM     ; MEM
92C4: 90        1121          DFB  $90        
92C5: 81 92     1122          DA   FACNOT     
92C7: A2        1123          DFB  $A2        
92C8: 71 92     1124          DA   FACMMC     ; MEMC
92CA: A9        1125          DFB  $A9        
92CB: 41 92     1126          DA   FACADR     
92CD: E6        1127          DFB  $E6        
92CE: 8C 92     1128          DA   SPCL:FAC   ; spritecollide
92D0: E7        1129          DFB  $E7        
92D1: 8C 92     1130          DA   SPCL:FAC   ; bkgndcollide
92D3: E8        1131          DFB  $E8        
92D4: 8C 92     1132          DA   SPCL:FAC   ; cursorx
92D6: E9        1133          DFB  $E9        
92D7: 8C 92     1134          DA   SPCL:FAC   ; cursory
92D9: EA        1135          DFB  $EA        
92DA: A5 92     1136          DA   SPC:FAC2   ; clock
92DC: EB        1137          DFB  $EB        
92DD: A5 92     1138          DA   SPC:FAC2   ; paddle
92DF: ED        1139          DFB  $ED        
92E0: A5 92     1140          DA   SPC:FAC2   ; joystick
92E2: EF        1141          DFB  $EF        
92E3: 8C 92     1142          DA   SPCL:FAC   ; random
92E5: F0        1143          DFB  $F0        
92E6: 8C 92     1144          DA   SPCL:FAC   ; envelope
92E8: F1        1145          DFB  $F1        
92E9: 8C 92     1146          DA   SPCL:FAC   ; scrollx
92EB: F2        1147          DFB  $F2        
92EC: 8C 92     1148          DA   SPCL:FAC   ; scrolly
92EE: F3        1149          DFB  $F3        
92EF: A5 92     1150          DA   SPC:FAC2   ; spritestatus
92F1: A7        1151          DFB  $A7        
92F2: B1 92     1152          DA   FACGTKY    ; getkey
92F4: EC        1153          DFB  $EC        
92F5: A5 92     1154          DA   SPC:FAC2   ; spritex
92F7: EE        1155          DFB  $EE        
92F8: A5 92     1156          DA   SPC:FAC2   ; spritey
92FA: F9        1157          DFB  $F9        
92FB: 8C 92     1158          DA   SPCL:FAC   ; invalid
92FD: F8        1159          DFB  $F8        
92FE: A5 92     1160          DA   SPC:FAC2   ; abs
9300: FD        1161          DFB  $FD        
9301: 8C 92     1162          DA   SPCL:FAC   ; freezestatus
9303: 00        1163          DFB  0          
                1164 *
                1165 * EXPRESSION
                1166 *
9304: 20 A8 90  1167 EXPRES   JSR  CHK:STAK   
9307: 20 ED 90  1168          JSR  SIMEXP     
930A: A5 16     1169          LDA  TOKEN      
930C: A2 14     1170          LDX  #EXPTB1    
930E: A0 93     1171          LDY  #>EXPTB1   
9310: 20 77 8F  1172          JSR  TKNJMP     
9313: 60        1173          RTS             
                1174 *
9314: 3D        1175 EXPTB1   ASC  '='
9315: 27 93     1176          DA   EXPR1      
9317: 55        1177          ASC  'U'
9318: 27 93     1178          DA   EXPR1      
931A: 3C        1179          ASC  '<'
931B: 27 93     1180          DA   EXPR1      
931D: 80        1181          DFB  $80        
931E: 27 93     1182          DA   EXPR1      
9320: 81        1183          DFB  $81        
9321: 27 93     1184          DA   EXPR1      
9323: 3E        1185          ASC  '>'
9324: 27 93     1186          DA   EXPR1      
9326: 00        1187          DFB  0          
                1188 *
9327: 48        1189 EXPR1    PHA             
9328: 20 49 80  1190          JSR  GTOKEN     
932B: 20 ED 90  1191          JSR  SIMEXP     
932E: 68        1192          PLA             
932F: A2 36     1193          LDX  #EXPTB3    
9331: A0 93     1194          LDY  #>EXPTB3   
9333: 20 77 8F  1195          JSR  TKNJMP     
                1196 *
9336: 3D        1197 EXPTB3   ASC  '='
9337: 49 93     1198          DA   EXPR2      
9339: 55        1199          ASC  'U'
933A: 4F 93     1200          DA   EXPR3      
933C: 3C        1201          ASC  '<'
933D: 53 93     1202          DA   EXPR4      
933F: 81        1203          DFB  $81        
9340: 57 93     1204          DA   EXPR5      
9342: 3E        1205          ASC  '>'
9343: 5B 93     1206          DA   EXPR6      
9345: 80        1207          DFB  $80        
9346: 5F 93     1208          DA   EXPR7      
9348: 00        1209          DFB  0          
                1210 *
9349: A9 10     1211 EXPR2    LDA  #16        
934B: 20 37 80  1212 EXPR8    JSR  GENNOP     
934E: 60        1213          RTS             
934F: A9 12     1214 EXPR3    LDA  #18        
9351: D0 F8     1215          BNE  EXPR8      
9353: A9 14     1216 EXPR4    LDA  #20        
9355: D0 F4     1217          BNE  EXPR8      
9357: A9 16     1218 EXPR5    LDA  #22        
9359: D0 F0     1219          BNE  EXPR8      
935B: A9 18     1220 EXPR6    LDA  #24        
935D: D0 EC     1221          BNE  EXPR8      
935F: A9 19     1222 EXPR7    LDA  #25        
9361: D0 E8     1223          BNE  EXPR8      
                1224 *
                1225 * STATEMENT
                1226 *
9363: 20 A8 90  1227 STMNT    JSR  CHK:STAK   
9366: A5 16     1228          LDA  TOKEN      
9368: A2 70     1229          LDX  #STMNT1    
936A: A0 93     1230          LDY  #>STMNT1   
936C: 20 77 8F  1231          JSR  TKNJMP     
936F: 60        1232          RTS             
                1233 *
9370: 49        1234 STMNT1   ASC  'I'
9371: DD 93     1235          DA   ASSIGN     
9373: 92        1236          DFB  $92        
9374: DE 96     1237          DA   IF         
9376: 9A        1238          DFB  $9A        
9377: 51 98     1239          DA   FOR        
9379: 96        1240          DFB  $96        
937A: 58 97     1241          DA   WHILE      
937C: 95        1242          DFB  $95        
937D: 8A 97     1243          DA   CASE       
937F: 98        1244          DFB  $98        
9380: 34 97     1245          DA   REPEAT     
9382: 88        1246          DFB  $88        
9383: 1E 97     1247          DA   BEG        
9385: 9E        1248          DFB  $9E        
9386: C0 94     1249          DA   READ       
9388: 9D        1250          DFB  $9D        
9389: 5B 94     1251          DA   WRITE      
938B: 91        1252          DFB  $91        
938C: 25 96     1253          DA   MEM        
938E: 9F        1254          DFB  $9F        
938F: 40 96     1255          DA   CALLSB     
9391: A2        1256          DFB  $A2        
9392: 2A 96     1257          DA   MEMC       
9394: A3        1258          DFB  $A3        
9395: 68 95     1259          DA   CURSOR     
9397: A5        1260          DFB  $A5        
9398: E5 95     1261          DA   DEF:SPRT   
939A: A6        1262          DFB  $A6        
939B: 16 96     1263          DA   HPLOT      
939D: AA        1264          DFB  $AA        
939E: CC 95     1265          DA   WAIT       
93A0: 81        1266          DFB  $81        
93A1: 9D 92     1267          DA   GET        
93A3: AD        1268          DFB  $AD        
93A4: 95 92     1269          DA   S:FREEZE   ; freezesprite (n)
93A6: AE        1270          DFB  $AE        
93A7: 99 92     1271          DA   CLOSE:FL   
93A9: AF        1272          DFB  $AF        
93AA: A1 92     1273          DA   PUT        
93AC: DF        1274          DFB  $DF        
93AD: 7B 95     1275          DA   SPRITE     
93AF: E0        1276          DFB  $E0        
93B0: 7B 95     1277          DA   MVE:SPRT   
93B2: E1        1278          DFB  $E1        
93B3: 7B 95     1279          DA   VOICE      
93B5: E2        1280          DFB  $E2        
93B6: 7B 95     1281          DA   GRAPHICS   
93B8: E3        1282          DFB  $E3        
93B9: 7B 95     1283          DA   SOUND      
93BB: E4        1284          DFB  $E4        
93BC: C5 95     1285          DA   SETCLOCK   
93BE: E5        1286          DFB  $E5        
93BF: D8 95     1287          DA   SCROLL     
93C1: A8        1288          DFB  $A8        
93C2: 63 95     1289          DA   CLEAR      
93C4: F4        1290          DFB  $F4        
93C5: 7B 95     1291          DA   MVE:SPRT   ; movesprite (6 args)
93C7: F5        1292          DFB  $F5        
93C8: A5 92     1293          DA   SPC:FAC2   ; stopsprite
93CA: F6        1294          DFB  $F6        
93CB: A5 92     1295          DA   SPC:FAC2   ; startsprite
93CD: F7        1296          DFB  $F7        
93CE: DE 95     1297          DA   ANIM:SPT   
93D0: FA        1298          DFB  $FA        
93D1: 36 94     1299          DA   LOAD:FIL   
93D3: FB        1300          DFB  $FB        
93D4: 36 94     1301          DA   SAVE:FIL   
93D6: FC        1302          DFB  $FC        
93D7: 36 94     1303          DA   OPEN:FIL   
93D9: FF        1304          DFB  $FF        
93DA: 4C 94     1305          DA   WRITELN    
93DC: 00        1306          DFB  0          
                1307 *
                1308 * ASSIGNMENT
                1309 *
93DD: 20 A6 8F  1310 ASSIGN   JSR  LOOKUP     
93E0: A2 EC     1311 ASS1     LDX  #ASSTB1    
93E2: A0 93     1312          LDY  #>ASSTB1   
93E4: 20 77 8F  1313          JSR  TKNJMP     
93E7: A2 18     1314          LDX  #24        
93E9: 20 2E 80  1315          JSR  ERROR      
                1316 *
93EC: 41        1317 ASSTB1   ASC  'A'
93ED: F9 93     1318          DA   ASSARR     
93EF: 56        1319          ASC  'V'
93F0: 0B 94     1320          DA   ASSVAR     
93F2: 59        1321          ASC  'Y'
93F3: 0B 94     1322          DA   ASSVAR     
93F5: 50        1323          ASC  'P'
93F6: 4D 96     1324          DA   FNCPRC     
93F8: 00        1325          DFB  0          
                1326 *
93F9: 20 EC 8F  1327 ASSARR   JSR  SYMWRK     
93FC: 20 52 80  1328          JSR  PSHWRK     
93FF: A9 36     1329          LDA  #54        
9401: 18        1330          CLC             
9402: 65 6C     1331          ADC  DATTYP     
9404: 48        1332          PHA             
9405: 20 24 8E  1333          JSR  GETSUB     
9408: 4C 1A 94  1334          JMP  ASS2       
                1335 *
940B: 20 EC 8F  1336 ASSVAR   JSR  SYMWRK     
940E: 20 52 80  1337          JSR  PSHWRK     
9411: A9 32     1338          LDA  #50        
9413: 18        1339          CLC             
9414: 65 6C     1340          ADC  DATTYP     
9416: 48        1341          PHA             
9417: 20 49 80  1342          JSR  GTOKEN     
941A: A9 41     1343 ASS2     LDA  #'A'       
941C: A2 0D     1344          LDX  #13        
941E: 20 34 80  1345          JSR  CHKTKN     
9421: 20 40 90  1346          JSR  GETEXPR    
9424: 68        1347          PLA             
9425: 20 55 80  1348          JSR  PULWRK     
9428: 20 F7 8F  1349          JSR  WRKSYM     
942B: 48        1350          PHA             
942C: 20 43 8E  1351          JSR  GET:LEV    
942F: 20 15 90  1352          JSR  GET:OFF    
9432: 68        1353          PLA             
9433: 4C 3A 80  1354          JMP  GENADR     
                1355 *
                1356 * LOAD/SAVE
                1357 *
                1358 OPEN:FIL EQU  *          
                1359 LOAD:FIL EQU  *          
                1360 SAVE:FIL EQU  *          
9436: 20 B3 95  1361          JSR  ARGS3      
9439: 48        1362          PHA             
943A: 20 72 90  1363          JSR  GET:COMM   
943D: AD 0E 80  1364          LDA  QUOT:SYM   
9440: A2 08     1365          LDX  #8         ; " expected
9442: 20 31 80  1366          JSR  GETCHK     
9445: 68        1367          PLA             
9446: 20 6E 94  1368          JSR  W:STRING   
9449: 4C 1A 8E  1369          JMP  CHKRHP     
                1370 *
                1371 *
                1372 * WRITELN
                1373 *
944C: 20 49 80  1374 WRITELN  JSR  GTOKEN     ; SEE IF ( PRESENT 
944F: C9 28     1375          CMP  #'('       
9451: D0 03     1376          BNE  WRITELN9   ; NOPE
9453: 20 5E 94  1377          JSR  WRIT9      
                1378 WRITELN9 EQU  *          
9456: A9 5E     1379          LDA  #$5E       ; OUTPUT C/R 
9458: 4C 37 80  1380          JMP  GENNOP     
                1381 *
                1382 *
                1383 * WRITE
                1384 *
945B: 20 13 8E  1385 WRITE    JSR  CHKLHP     
945E: 20 49 80  1386 WRIT9    JSR  GTOKEN     
9461: CD 0E 80  1387          CMP  QUOT:SYM   
9464: D0 2B     1388          BNE  WRIT1      
9466: A9 23     1389          LDA  #35        
9468: 20 6E 94  1390          JSR  W:STRING   
946B: 4C A1 94  1391          JMP  WRIT5      
                1392 *
                1393 W:STRING EQU  *          
946E: 20 37 80  1394          JSR  GENNOP     
9471: A5 19     1395          LDA  TKNLEN     
9473: 20 37 80  1396          JSR  GENNOP     
9476: A0 00     1397          LDY  #0         
9478: B1 17     1398 WRIT2    LDA  (TKNADR),Y 
947A: CD 0E 80  1399          CMP  QUOT:SYM   
947D: D0 01     1400          BNE  WRIT10     
947F: C8        1401          INY             
9480: C8        1402 WRIT10   INY             
9481: AA        1403          TAX             ; save A temporarily
9482: 98        1404          TYA             ; save Y on stack
9483: 48        1405          PHA             
9484: 8A        1406          TXA             
9485: 20 37 80  1407          JSR  GENNOP     
9488: 68        1408          PLA             
9489: A8        1409          TAY             
948A: C6 19     1410          DEC  TKNLEN     
948C: D0 EA     1411          BNE  WRIT2      
948E: 4C 49 80  1412          JMP  GTOKEN     
                1413 *
                1414 WRIT1    EQU  *          ; here if not string
9491: C9 AB     1415          CMP  #$AB       ; CHR?
9493: F0 15     1416          BEQ  W:CHR      ; yes
9495: C9 AC     1417          CMP  #$AC       ; HEX?
9497: F0 19     1418          BEQ  W:HEX      ; yes
9499: 20 04 93  1419          JSR  EXPRES     ; just ordinary number - get it
949C: A9 1E     1420          LDA  #30        ; output number
949E: 20 37 80  1421          JSR  GENNOP     
94A1: A5 16     1422 WRIT5    LDA  TOKEN      
94A3: C9 2C     1423          CMP  #','       
94A5: F0 B7     1424          BEQ  WRIT9      
94A7: 4C 1A 8E  1425          JMP  CHKRHP     
                1426 *
                1427 * here for write (chr(x))
                1428 *
                1429 W:CHR    EQU  *          
94AA: A9 1F     1430          LDA  #31        ; output character
                1431 W:CHR1   EQU  *          
94AC: 20 CE 95  1432          JSR  WAIT:1     ; process expression in parentheses
94AF: 4C A1 94  1433          JMP  WRIT5      ; back for next item
                1434 *
                1435 * here for write (hex(x))
                1436 *
                1437 W:HEX    EQU  *          
94B2: A9 21     1438          LDA  #33        ; output hex
94B4: D0 F6     1439          BNE  W:CHR1     
                1440 *
                1441 *
                1442 *
                1443 * GET NEXT TOKEN - MUST BE IDENTIFIER
                1444 * THEN LOOK IT UP IN SYMBOL TABLE
                1445 *
94B6: A9 49     1446 GET:LOOK LDA  #'I'       
94B8: A2 04     1447          LDX  #4         
94BA: 20 31 80  1448          JSR  GETCHK     
94BD: 4C A6 8F  1449          JMP  LOOKUP     
                1450 *
                1451 *
                1452 * READ
                1453 *
94C0: 20 13 8E  1454 READ     JSR  CHKLHP     
94C3: 20 B6 94  1455 READ8    JSR  GET:LOOK   
94C6: 20 EC 8F  1456 READ2    JSR  SYMWRK     
94C9: 20 52 80  1457          JSR  PSHWRK     
94CC: A2 00     1458          LDX  #0         
94CE: 8E A7 02  1459          STX  COUNT1     
94D1: C9 41     1460          CMP  #'A'       
94D3: F0 4D     1461          BEQ  READ3      
94D5: C9 56     1462          CMP  #'V'       
94D7: F0 05     1463          BEQ  READ9      
94D9: A2 0C     1464          LDX  #12        
94DB: 20 2E 80  1465          JSR  ERROR      
94DE: 20 49 80  1466 READ9    JSR  GTOKEN     
94E1: 48        1467 READ11   PHA             
94E2: A9 1C     1468          LDA  #28        
94E4: 18        1469          CLC             
94E5: 65 6C     1470          ADC  DATTYP     
94E7: AA        1471          TAX             
94E8: 68        1472          PLA             
94E9: C9 24     1473 READ4    CMP  #'$'       
94EB: D0 09     1474          BNE  READ6      
94ED: A2 17     1475          LDX  #23        
94EF: 8A        1476 READ5    TXA             
94F0: 48        1477          PHA             
94F1: 20 49 80  1478          JSR  GTOKEN     
94F4: 68        1479          PLA             
94F5: AA        1480          TAX             
94F6: 8A        1481 READ6    TXA             
94F7: 20 37 80  1482          JSR  GENNOP     
94FA: 20 55 80  1483          JSR  PULWRK     
94FD: 20 F7 8F  1484          JSR  WRKSYM     
9500: 20 4D 8E  1485          JSR  GET:DAT    
9503: 20 43 8E  1486 READ10   JSR  GET:LEV    
9506: 20 15 90  1487          JSR  GET:OFF    
9509: A9 32     1488          LDA  #50        
950B: AE A7 02  1489          LDX  COUNT1     
950E: F0 02     1490          BEQ  READ7      
9510: A9 36     1491          LDA  #54        
9512: 18        1492 READ7    CLC             
9513: 65 6C     1493          ADC  DATTYP     
9515: 20 3A 80  1494          JSR  GENADR     
9518: A5 16     1495 READ7:A  LDA  TOKEN      
951A: C9 2C     1496          CMP  #','       
951C: F0 A5     1497          BEQ  READ8      
951E: 20 1A 8E  1498          JSR  CHKRHP     
9521: 60        1499          RTS             
9522: A5 6C     1500 READ3    LDA  DATTYP     
9524: 48        1501          PHA             
9525: 20 49 80  1502          JSR  GTOKEN     
9528: CD 0C 80  1503          CMP  LHB        
952B: F0 25     1504          BEQ  READ3:A    
952D: 68        1505          PLA             
952E: 85 6C     1506          STA  DATTYP     
9530: D0 05     1507          BNE  READ3:B    
9532: A2 18     1508          LDX  #24        
9534: 20 2E 80  1509          JSR  ERROR      
9537: 20 55 80  1510 READ3:B  JSR  PULWRK     
953A: 20 F7 8F  1511          JSR  WRKSYM     
953D: A9 25     1512          LDA  #37        ; READ STRING 
953F: 20 37 80  1513          JSR  GENNOP     
9542: 20 43 8E  1514          JSR  GET:LEV    
9545: 20 15 90  1515          JSR  GET:OFF    
9548: A0 06     1516          LDY  #SYMSUB    
954A: B1 4E     1517          LDA  (SYMITM),Y 
954C: 20 3A 80  1518          JSR  GENADR     ; A = LENGTH
954F: 4C 18 95  1519          JMP  READ7:A    
                1520 *
9552: 20 40 90  1521 READ3:A  JSR  GETEXPR    
9555: 20 38 8E  1522          JSR  CHKRHB     
9558: EE A7 02  1523          INC  COUNT1     
955B: 68        1524          PLA             
955C: 85 6C     1525          STA  DATTYP     
955E: A5 16     1526          LDA  TOKEN      
9560: 4C E1 94  1527          JMP  READ11     
                1528 *
                1529 * CLEAR
                1530 *
9563: A9 09     1531 CLEAR    LDA  #9         
9565: 4C DA 95  1532          JMP  SCROLL:1   
                1533 *
                1534 *
                1535 * CURSOR
                1536 *
9568: A9 13     1537 CURSOR   LDA  #19        
956A: 48        1538          PHA             
                1539 *
                1540 *
956B: 20 13 8E  1541 TWO:OP   JSR  CHKLHP     
956E: 20 40 90  1542          JSR  GETEXPR    
9571: 20 79 90  1543 ONE:OP2  JSR  GET:ITEM   
9574: 20 1A 8E  1544 ONE:OP   JSR  CHKRHP     
9577: 68        1545          PLA             
9578: 4C 37 80  1546          JMP  GENNOP     
                1547 *
                1548 * GRAPHICS/SOUND/SPRITE/MOVESPRITE/VOICE
                1549 *
                1550 GRAPHICS EQU  *          
                1551 SOUND    EQU  *          
                1552 SPRITE   EQU  *          
                1553 MVE:SPRT EQU  *          
                1554 VOICE    EQU  *          
957B: 20 AB 92  1555          JSR  TKNCNV     
957E: 48        1556          PHA             ; SAVE FOR LATER
957F: 20 13 8E  1557          JSR  CHKLHP     
                1558 VOICE:1  EQU  *          
9582: 20 40 90  1559          JSR  GETEXPR    
9585: 20 79 90  1560          JSR  GET:ITEM   
9588: 68        1561          PLA             
9589: 48        1562          PHA             
958A: C9 54     1563          CMP  #$54       ; 6-arg move sprite 
958C: F0 0A     1564          BEQ  VOICE:3    
958E: C9 42     1565          CMP  #$42       ; graphics
9590: B0 12     1566          BGE  VOICE:2    ; only 2 arguments wanted
9592: 20 79 90  1567          JSR  GET:ITEM   
9595: 4C A4 95  1568          JMP  VOICE:2    
                1569 VOICE:3  EQU  *          ; want 4 more args
9598: 20 79 90  1570          JSR  GET:ITEM   
959B: 20 79 90  1571          JSR  GET:ITEM   
959E: 20 79 90  1572          JSR  GET:ITEM   
95A1: 20 79 90  1573          JSR  GET:ITEM   
                1574 VOICE:2  EQU  *          
95A4: 68        1575          PLA             
95A5: 48        1576          PHA             
95A6: 20 37 80  1577          JSR  GENNOP     
95A9: A5 16     1578          LDA  TOKEN      
95AB: C9 2C     1579          CMP  #','       
95AD: F0 D3     1580          BEQ  VOICE:1    ; another 3
95AF: 68        1581          PLA             
95B0: 4C 1A 8E  1582          JMP  CHKRHP     
                1583 *
                1584 * Process 3 arguments
                1585 *
                1586 ARGS3    EQU  *          
95B3: 20 AB 92  1587          JSR  TKNCNV     
95B6: 48        1588          PHA             
95B7: 20 13 8E  1589          JSR  CHKLHP     
95BA: 20 40 90  1590          JSR  GETEXPR    
95BD: 20 79 90  1591          JSR  GET:ITEM   
95C0: 20 79 90  1592          JSR  GET:ITEM   
95C3: 68        1593          PLA             
95C4: 60        1594          RTS             
                1595 * 
                1596 * SETCLOCK ( hours, mins, secs, 10ths. )
                1597 * 
                1598 SETCLOCK EQU  *          
95C5: 20 B3 95  1599          JSR  ARGS3      
95C8: 48        1600          PHA             
95C9: 4C 71 95  1601          JMP  ONE:OP2    
                1602 *
95CC: A9 39     1603 WAIT     LDA  #57        
95CE: 48        1604 WAIT:1   PHA             
95CF: 20 13 8E  1605          JSR  CHKLHP     
95D2: 20 40 90  1606          JSR  GETEXPR    
95D5: 4C 74 95  1607          JMP  ONE:OP     
                1608 *
                1609 * SCROLL
                1610 *
                1611 SCROLL   EQU  *          
95D8: A9 45     1612          LDA  #69        
95DA: 48        1613 SCROLL:1 PHA             
95DB: 4C 6B 95  1614          JMP  TWO:OP     
                1615 *
                1616 ANIM:SPT EQU  *          
95DE: A9 57     1617          LDA  #$57       
95E0: 48        1618          PHA             
95E1: A9 11     1619          LDA  #17        ; count plus 16 pointers
95E3: D0 05     1620          BNE  DEF:SPT2   
                1621 *
                1622 *
                1623 * DEFINESPRITE
                1624 *
                1625 DEF:SPRT EQU  *          
95E5: A9 01     1626          LDA  #1         ; PCODE
95E7: 48        1627          PHA             
95E8: A9 15     1628          LDA  #21        ; row count
95EA: 48        1629 DEF:SPT2 PHA             
95EB: 20 13 8E  1630          JSR  CHKLHP     
95EE: 20 40 90  1631          JSR  GETEXPR    ; sprite pointer
95F1: 20 79 90  1632 DEF:1    JSR  GET:ITEM   ; next row
95F4: 68        1633          PLA             
95F5: AA        1634          TAX             
95F6: CA        1635          DEX             ; one less row
95F7: F0 16     1636          BEQ  DEF:8      ; zero? none left
95F9: 8A        1637          TXA             
95FA: 48        1638          PHA             
95FB: A5 16     1639          LDA  TOKEN      
95FD: C9 2C     1640          CMP  #','       
95FF: F0 F0     1641          BEQ  DEF:1      ; more supplied
                1642 *
                1643 * no more supplied - zero out rest
                1644 *
9601: A9 80     1645 DEF:2    LDA  #$80       ; load zero pcode
9603: 20 37 80  1646          JSR  GENNOP     
9606: 68        1647          PLA             
9607: AA        1648          TAX             
9608: CA        1649          DEX             
9609: F0 04     1650          BEQ  DEF:8      ; all done
960B: 8A        1651          TXA             
960C: 48        1652          PHA             
960D: D0 F2     1653          BNE  DEF:2      ; do another
960F: 20 1A 8E  1654 DEF:8    JSR  CHKRHP     
9612: 68        1655          PLA             ; pcode for define/animate sprite
9613: 4C 37 80  1656 GENNOP2  JMP  GENNOP     
                1657 *
                1658 *
                1659 * HPLOT
                1660 *
9616: 20 13 8E  1661 HPLOT    JSR  CHKLHP     
9619: 20 40 90  1662          JSR  GETEXPR    ; colour
961C: A9 03     1663          LDA  #3         
961E: 48        1664          PHA             
961F: 20 79 90  1665          JSR  GET:ITEM   
9622: 4C 71 95  1666          JMP  ONE:OP2    
                1667 *
                1668 *
                1669 * MEM
                1670 *
9625: A9 00     1671 MEM      LDA  #0         
9627: 48        1672          PHA             
9628: F0 03     1673          BEQ  MEM2       
962A: A9 01     1674 MEMC     LDA  #1         
962C: 48        1675          PHA             
962D: 20 24 8E  1676 MEM2     JSR  GETSUB     
9630: A9 41     1677          LDA  #'A'       
9632: A2 0D     1678          LDX  #13        
9634: 20 34 80  1679          JSR  CHKTKN     
9637: 20 40 90  1680          JSR  GETEXPR    
963A: 68        1681          PLA             
963B: 18        1682          CLC             
963C: 69 34     1683          ADC  #52        
963E: D0 D3     1684          BNE  GENNOP2    
                1685 *
                1686 * CALL ABSOLUTE ADDRESS
                1687 *
9640: 20 13 8E  1688 CALLSB   JSR  CHKLHP     
9643: 20 40 90  1689          JSR  GETEXPR    
9646: 20 1A 8E  1690          JSR  CHKRHP     
9649: A9 2B     1691          LDA  #43        
964B: D0 C6     1692          BNE  GENNOP2    
                1693 *
                1694 * FUNCTION OR PROCEDURE CALL
                1695 *
964D: A9 00     1696 FNCPRC   LDA  #0         
964F: 8D A7 02  1697          STA  COUNT1     
9652: A0 06     1698          LDY  #SYMARG    
9654: B1 4E     1699          LDA  (SYMITM),Y 
9656: F0 37     1700          BEQ  FNC1       
9658: 20 13 8E  1701          JSR  CHKLHP     
965B: AD A7 02  1702 FNC2     LDA  COUNT1     
965E: 48        1703          PHA             
965F: 20 EC 8F  1704          JSR  SYMWRK     
9662: 20 52 80  1705          JSR  PSHWRK     
9665: 20 40 90  1706          JSR  GETEXPR    
9668: 20 55 80  1707          JSR  PULWRK     
966B: 20 F7 8F  1708          JSR  WRKSYM     
966E: 68        1709          PLA             
966F: 8D A7 02  1710          STA  COUNT1     
9672: EE A7 02  1711          INC  COUNT1     
9675: A5 16     1712          LDA  TOKEN      
9677: C9 2C     1713          CMP  #','       
9679: F0 E0     1714          BEQ  FNC2       
967B: AD A7 02  1715          LDA  COUNT1     
967E: A0 06     1716          LDY  #SYMARG    
9680: D1 4E     1717          CMP  (SYMITM),Y 
9682: F0 05     1718          BEQ  FNC3       
9684: A2 23     1719          LDX  #35        
9686: 20 2E 80  1720          JSR  ERROR      
9689: 20 1A 8E  1721 FNC3     JSR  CHKRHP     
968C: 4C 92 96  1722          JMP  FNC5       
968F: 20 49 80  1723 FNC1     JSR  GTOKEN     
9692: 20 43 8E  1724 FNC5     JSR  GET:LEV    
9695: 20 15 90  1725          JSR  GET:OFF    
9698: A0 08     1726          LDY  #SYMDAT    
969A: B1 4E     1727          LDA  (SYMITM),Y 
969C: D0 11     1728          BNE  FNC5A      
969E: A5 2C     1729          LDA  OFFSET     
96A0: 38        1730          SEC             
96A1: E5 26     1731          SBC  PCODE      
96A3: 85 2C     1732          STA  OFFSET     
96A5: A5 2D     1733          LDA  OFFSET+1   
96A7: E5 27     1734          SBC  PCODE+1    
96A9: 85 2D     1735          STA  OFFSET+1   
96AB: A9 27     1736          LDA  #39        
96AD: D0 02     1737          BNE  FNC5B      
96AF: A9 38     1738 FNC5A    LDA  #56        
96B1: 20 3A 80  1739 FNC5B    JSR  GENADR     
96B4: AD A7 02  1740          LDA  COUNT1     
96B7: F0 1F     1741          BEQ  FNC4       
96B9: AD A7 02  1742          LDA  COUNT1     ; TIMES 3
96BC: 0A        1743          ASL             
96BD: B0 1A     1744          BCS  FNC6       
96BF: 6D A7 02  1745          ADC  COUNT1     
96C2: 8D A7 02  1746          STA  COUNT1     
96C5: B0 12     1747          BCS  FNC6       
96C7: A9 00     1748          LDA  #0         
96C9: 38        1749          SEC             
96CA: ED A7 02  1750          SBC  COUNT1     
96CD: 85 2E     1751          STA  OPND       
96CF: A9 FF     1752          LDA  #$FF       
96D1: 85 2F     1753          STA  OPND+1     
96D3: A9 3B     1754          LDA  #59        
96D5: 20 85 80  1755          JSR  GENJMP     
96D8: 60        1756 FNC4     RTS             
96D9: A2 0F     1757 FNC6     LDX  #15        
96DB: 20 2E 80  1758          JSR  ERROR      
                1759 *
                1760 *
                1761 * IF
                1762 *
96DE: 20 40 90  1763 IF       JSR  GETEXPR    
96E1: A9 93     1764          LDA  #$93       
96E3: A2 10     1765          LDX  #16        
96E5: 20 34 80  1766          JSR  CHKTKN     
96E8: 20 49 80  1767          JSR  GTOKEN     
96EB: 20 02 90  1768          JSR  PSHPCODE   
96EE: A9 3D     1769          LDA  #61        
96F0: 20 40 80  1770          JSR  GENNJM     
96F3: 20 63 93  1771          JSR  STMNT      
96F6: A5 16     1772          LDA  TOKEN      
96F8: C9 94     1773          CMP  #$94       ; ELSE
96FA: F0 07     1774          BEQ  IF1        
96FC: 20 55 80  1775 IF2      JSR  PULWRK     
96FF: 20 4F 80  1776          JSR  FIXAD      
9702: 60        1777          RTS             
9703: 20 55 80  1778 IF1      JSR  PULWRK     ; HERE FOR ELSE
9706: 20 67 90  1779          JSR  WRK:WRKD   
9709: 20 02 90  1780          JSR  PSHPCODE   
970C: 20 3D 80  1781          JSR  GENNJP     
970F: 20 5C 90  1782          JSR  WRKD:WRK   
9712: 20 4F 80  1783          JSR  FIXAD      
9715: 20 49 80  1784          JSR  GTOKEN     
9718: 20 63 93  1785          JSR  STMNT      
971B: 4C FC 96  1786          JMP  IF2        
                1787 *
                1788 * BEGIN
                1789 *
971E: 20 49 80  1790 BEG      JSR  GTOKEN     
9721: 20 63 93  1791          JSR  STMNT      
9724: A5 16     1792          LDA  TOKEN      
9726: C9 3B     1793          CMP  #';'       
9728: F0 F4     1794          BEQ  BEG        
972A: A9 89     1795          LDA  #$89       ; END
972C: A2 11     1796          LDX  #17        
972E: 20 34 80  1797          JSR  CHKTKN     
9731: 4C 49 80  1798          JMP  GTOKEN     
                1799 *
                1800 * REPEAT
                1801 *
9734: 20 02 90  1802 REPEAT   JSR  PSHPCODE   
9737: 20 49 80  1803 REP1     JSR  GTOKEN     
973A: 20 63 93  1804          JSR  STMNT      
973D: A5 16     1805          LDA  TOKEN      
973F: C9 3B     1806          CMP  #';'       
9741: F0 F4     1807          BEQ  REP1       
9743: A9 99     1808          LDA  #$99       
9745: A2 0A     1809          LDX  #10        
9747: 20 34 80  1810          JSR  CHKTKN     
974A: 20 40 90  1811          JSR  GETEXPR    
974D: 20 55 80  1812          JSR  PULWRK     
9750: 20 51 90  1813          JSR  WRK:OPND   
9753: A9 3D     1814          LDA  #61        
9755: 4C 88 80  1815          JMP  GENRJMP    
                1816 *
                1817 * WHILE
                1818 *
9758: 20 02 90  1819 WHILE    JSR  PSHPCODE   
975B: 20 40 90  1820          JSR  GETEXPR    
975E: 20 02 90  1821          JSR  PSHPCODE   
9761: A9 3D     1822          LDA  #61        
9763: 20 40 80  1823          JSR  GENNJM     
9766: A9 97     1824          LDA  #$97       
9768: A2 12     1825          LDX  #18        
976A: 20 34 80  1826          JSR  CHKTKN     
976D: 20 49 80  1827          JSR  GTOKEN     
9770: 20 63 93  1828          JSR  STMNT      
9773: 20 55 80  1829          JSR  PULWRK     
9776: 20 67 90  1830          JSR  WRK:WRKD   
9779: 20 55 80  1831          JSR  PULWRK     
977C: 20 51 90  1832          JSR  WRK:OPND   
977F: A9 3C     1833          LDA  #60        
9781: 20 88 80  1834          JSR  GENRJMP    
9784: 20 5C 90  1835          JSR  WRKD:WRK   
9787: 4C 4F 80  1836          JMP  FIXAD      
                1837 *
                1838 * CASE
                1839 *
978A: 20 40 90  1840 CASE     JSR  GETEXPR    
978D: A9 85     1841          LDA  #$85       ; OF
978F: A2 19     1842          LDX  #25        
9791: 20 34 80  1843          JSR  CHKTKN     
9794: A9 01     1844          LDA  #1         
9796: 8D A7 02  1845          STA  COUNT1     
9799: A9 00     1846 CASE7    LDA  #0         
979B: 8D A8 02  1847          STA  COUNT2     
                1848 CASE2    EQU  *          
979E: A9 2A     1849          LDA  #42        ; make copy of selector
97A0: 20 37 80  1850          JSR  GENNOP     
97A3: 20 40 90  1851          JSR  GETEXPR    ; next expression to compare
97A6: A9 10     1852          LDA  #16        
97A8: 20 37 80  1853          JSR  GENNOP     
97AB: A5 16     1854          LDA  TOKEN      
97AD: C9 3A     1855          CMP  #':'       
97AF: F0 15     1856          BEQ  CASE1      
97B1: A9 2C     1857          LDA  #','       
97B3: A2 05     1858          LDX  #5         
97B5: 20 34 80  1859          JSR  CHKTKN     
97B8: 20 02 90  1860          JSR  PSHPCODE   
97BB: A9 3E     1861          LDA  #62        
97BD: 20 40 80  1862          JSR  GENNJM     
97C0: EE A8 02  1863          INC  COUNT2     
97C3: 4C 9E 97  1864          JMP  CASE2      
97C6: 20 46 90  1865 CASE1    JSR  PCD:WRKD   
97C9: A9 3D     1866          LDA  #61        
97CB: 20 40 80  1867          JSR  GENNJM     
97CE: AD A8 02  1868          LDA  COUNT2     
97D1: F0 0B     1869          BEQ  CASE3      
97D3: 20 55 80  1870 CASE4    JSR  PULWRK     
97D6: 20 4F 80  1871          JSR  FIXAD      
97D9: CE A8 02  1872          DEC  COUNT2     
97DC: D0 F5     1873          BNE  CASE4      
97DE: 20 5C 90  1874 CASE3    JSR  WRKD:WRK   
97E1: 20 52 80  1875          JSR  PSHWRK     
97E4: 20 49 80  1876          JSR  GTOKEN     
97E7: AD A7 02  1877          LDA  COUNT1     
97EA: 48        1878          PHA             
97EB: 20 63 93  1879          JSR  STMNT      
97EE: 68        1880          PLA             
97EF: 8D A7 02  1881          STA  COUNT1     
97F2: A5 16     1882          LDA  TOKEN      
97F4: C9 94     1883          CMP  #$94       ; ELSE
97F6: F0 1C     1884          BEQ  CASE5      
97F8: C9 3B     1885          CMP  #';'       
97FA: D0 38     1886          BNE  CASE6      
97FC: 20 46 90  1887          JSR  PCD:WRKD   
97FF: 20 3D 80  1888          JSR  GENNJP     
9802: 20 55 80  1889          JSR  PULWRK     
9805: 20 4F 80  1890          JSR  FIXAD      
9808: 20 5C 90  1891          JSR  WRKD:WRK   
980B: 20 52 80  1892          JSR  PSHWRK     
980E: EE A7 02  1893          INC  COUNT1     
9811: 4C 99 97  1894          JMP  CASE7      
9814: 20 46 90  1895 CASE5    JSR  PCD:WRKD   
9817: 20 3D 80  1896          JSR  GENNJP     
981A: 20 55 80  1897          JSR  PULWRK     
981D: 20 4F 80  1898          JSR  FIXAD      
9820: 20 5C 90  1899          JSR  WRKD:WRK   
9823: 20 52 80  1900          JSR  PSHWRK     
9826: 20 49 80  1901          JSR  GTOKEN     
9829: AD A7 02  1902          LDA  COUNT1     
982C: 48        1903          PHA             
982D: 20 63 93  1904          JSR  STMNT      
9830: 68        1905          PLA             
9831: 8D A7 02  1906          STA  COUNT1     
9834: A9 89     1907 CASE6    LDA  #$89       ; END
9836: A2 11     1908          LDX  #17        
9838: 20 34 80  1909          JSR  CHKTKN     
983B: AD A7 02  1910          LDA  COUNT1     
983E: F0 0B     1911          BEQ  CASE8      
9840: 20 55 80  1912 CASE9    JSR  PULWRK     
9843: 20 4F 80  1913          JSR  FIXAD      
9846: CE A7 02  1914          DEC  COUNT1     
9849: D0 F5     1915          BNE  CASE9      
984B: 20 1F 99  1916 CASE8    JSR  FOR6       
984E: 4C 49 80  1917          JMP  GTOKEN     
                1918 *
                1919 * FOR
                1920 *
9851: A9 49     1921 FOR      LDA  #'I'       
9853: A2 04     1922          LDX  #4         
9855: 20 31 80  1923          JSR  GETCHK     
9858: 20 A6 8F  1924          JSR  LOOKUP     
985B: C9 56     1925 FOR1     CMP  #'V'       
985D: F0 09     1926          BEQ  FOR2       
985F: C9 59     1927          CMP  #'Y'       
9861: F0 05     1928          BEQ  FOR2       
9863: A2 0C     1929          LDX  #12        
9865: 20 2E 80  1930          JSR  ERROR      
9868: 20 0B 94  1931 FOR2     JSR  ASSVAR     
986B: 20 EC 8F  1932          JSR  SYMWRK     
986E: A9 00     1933          LDA  #0         
9870: 8D A7 02  1934          STA  COUNT1     
9873: A5 16     1935          LDA  TOKEN      
9875: C9 9B     1936          CMP  #$9B       ; TO
9877: F0 0A     1937          BEQ  FOR3       
9879: A9 9C     1938          LDA  #$9C       ; DOWNTO
987B: A2 1C     1939          LDX  #28        
987D: 20 34 80  1940          JSR  CHKTKN     
9880: CE A7 02  1941          DEC  COUNT1     
9883: AD A7 02  1942 FOR3     LDA  COUNT1     
9886: 48        1943          PHA             
9887: 20 52 80  1944          JSR  PSHWRK     
988A: 20 40 90  1945          JSR  GETEXPR    
988D: 20 55 80  1946          JSR  PULWRK     
9890: 20 F7 8F  1947          JSR  WRKSYM     
9893: 68        1948          PLA             
9894: 8D A7 02  1949          STA  COUNT1     
9897: 20 02 90  1950          JSR  PSHPCODE   
989A: A9 2A     1951          LDA  #42        
989C: 20 37 80  1952          JSR  GENNOP     
989F: 20 43 8E  1953          JSR  GET:LEV    
98A2: 20 15 90  1954          JSR  GET:OFF    
98A5: 20 4D 8E  1955          JSR  GET:DAT    
98A8: 18        1956          CLC             
98A9: 69 2C     1957          ADC  #44        
98AB: 20 3A 80  1958          JSR  GENADR     
98AE: A9 16     1959          LDA  #22        ; UP (GEQ)
98B0: AE A7 02  1960          LDX  COUNT1     
98B3: F0 02     1961          BEQ  FOR4       
98B5: A9 19     1962          LDA  #25        ; DOWN (LEQ) 
98B7: 20 37 80  1963 FOR4     JSR  GENNOP     
98BA: 20 02 90  1964          JSR  PSHPCODE   
98BD: A9 3D     1965          LDA  #61        
98BF: 20 40 80  1966          JSR  GENNJM     
98C2: AD A7 02  1967          LDA  COUNT1     
98C5: 48        1968          PHA             
98C6: 20 EC 8F  1969          JSR  SYMWRK     
98C9: 20 52 80  1970          JSR  PSHWRK     
98CC: A9 97     1971          LDA  #$97       
98CE: A2 12     1972          LDX  #18        
98D0: 20 34 80  1973          JSR  CHKTKN     
98D3: 20 49 80  1974          JSR  GTOKEN     
98D6: 20 63 93  1975          JSR  STMNT      
98D9: 20 55 80  1976          JSR  PULWRK     
98DC: 20 F7 8F  1977          JSR  WRKSYM     
98DF: 20 43 8E  1978          JSR  GET:LEV    
98E2: 20 4D 8E  1979          JSR  GET:DAT    
98E5: 20 15 90  1980          JSR  GET:OFF    
98E8: A5 6C     1981          LDA  DATTYP     
98EA: 18        1982          CLC             
98EB: 69 2C     1983          ADC  #44        
98ED: 20 3A 80  1984          JSR  GENADR     
98F0: 68        1985          PLA             
98F1: 8D A7 02  1986          STA  COUNT1     
98F4: A9 26     1987          LDA  #38        
98F6: AE A7 02  1988          LDX  COUNT1     
98F9: F0 02     1989          BEQ  FOR5       
98FB: A9 28     1990          LDA  #40        ; DEC
98FD: 20 37 80  1991 FOR5     JSR  GENNOP     
9900: A9 32     1992          LDA  #50        
9902: 18        1993          CLC             
9903: 65 6C     1994          ADC  DATTYP     
9905: 20 3A 80  1995          JSR  GENADR     
9908: 20 55 80  1996          JSR  PULWRK     
990B: 20 67 90  1997          JSR  WRK:WRKD   
990E: 20 55 80  1998          JSR  PULWRK     
9911: 20 51 90  1999          JSR  WRK:OPND   
9914: A9 3C     2000          LDA  #60        
9916: 20 88 80  2001          JSR  GENRJMP    
9919: 20 5C 90  2002          JSR  WRKD:WRK   
991C: 20 4F 80  2003          JSR  FIXAD      
991F: A9 FF     2004 FOR6     LDA  #$FF       
9921: 85 2F     2005          STA  OPND+1     
9923: A9 FD     2006          LDA  #$FD       
9925: 85 2E     2007          STA  OPND       
9927: A9 3B     2008          LDA  #59        
9929: 4C 85 80  2009          JMP  GENJMP     
992C: 00        2011          BRK             


--End assembly, 2905 bytes, Errors: 0 
