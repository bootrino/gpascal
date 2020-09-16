                     ************************************************
                2    * PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 6
                5    * Authors: Nick Gammon & Sue Gobbett
                6    *  SYM $9000
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
                201  ECNTR    EQU  BPOINT     
                202  EPNTR    EQU  $43        
                203  REP:FROM EQU  BPOINT+2   
                204  REP:TO   EQU  BPOINT+3   
                205  REP:LEN  EQU  BPOINT+4   
                206  PNTR:HI  EQU  BPOINT+5   
                207  IN:LGTH  EQU  BPOINT+6   
                208  LENGTH   EQU  BPOINT+7   
                209  FROM:ST  EQU  BPOINT+9   
                210  NUM:LINS EQU  BPOINT+11  
                211  ED:COM   EQU  BPOINT+13  
                212  TO:LINE  EQU  BPOINT+15  
                213  FND:FROM EQU  BPOINT+17  
                214  FND:TO   EQU  BPOINT+18  
                215  FND:POS  EQU  BPOINT+19  
                216  LASTP    DS   2          
                217  INCHAR   DS   1          
                218  IO:A     DS   1          
                219  IO:Y     DS   1          
                220  IO:X     DS   1          
                221  CURR:CHR DS   1          
                222  HEX:WK   DS   1          
                223           DS   2          
                224  STK:AVL  DS   1          
                225  STK:PAGE DS   1          
                226  STK:WRK  DS   1          
                227  STK:RT   DS   2          
                228  BEG:STK  DS   1          
                229  XSAVE    DS   1          
                230  RES      DS   3          ; 3 BYTES
                231  MCAND    DS   3          ; 3 BYTES
                232  DIVISOR  EQU  MCAND      
                233  DVDN     DS   3          ; 3 BYTES
                234  RMNDR    DS   1          
                235  TEMP1    DS   2          
                236  BIN:WRK  DS   3          
                237  ASC:WRK  DS   10         
                238  DEF:PCD  DS   1          
                239  REP:SIZE DS   1          
                240  NLN:FLAG DS   1          
                241  Q:FLAG   DS   1          
                242  FND:FLG  DS   1          
                243  FND:LEN  DS   1          
                244  UC:FLAG  DS   1          
                245  TRN:FLAG DS   1          
                246  GLB:FLAG DS   1          
                247  INT:RTN  DS   2          ; address to return to after a timer interrupt
                248  INT:TEMP DS   1          ; for interrupt service routine
                249  INT:TMP1 DS   1          
                250  INT:TMP2 DS   1          
                251  QT:TGL   DS   1          ; quote toggle
                252  QT:SIZE  DS   1          ; number of characters in reserved words
                253           DEND            
                     ************************************************
                255  *  SYMBOL TABLE DEFINES - RELATIVE TO SYMBOL TABLE ENTRY
                     ************************************************
                257  SYMPRV   EQU  0          
                258  SYMLVL   EQU  2          
                259  SYMTYP   EQU  3          
                260  SYMDSP   EQU  4          
                261  SYMARG   EQU  6          
                262  SYMSUB   EQU  6          
                263  SYMDAT   EQU  8          
                264  SYMLEN   EQU  9          
                265  SYMNAM   EQU  10         
                     ************************************************
                267  * ADDRESS CONSTANTS ETC.
                     ************************************************
                269           DUM  $8000      
                270           DS   3          
                271           DS   3          
                272           DS   3          
8009: 00 40     273  TS       DA   $4000      
800B: 10        274  SYM:SIZE DFB  16         
800C: 5B        275  LHB      ASC  '['
800D: 5D        276  RHB      ASC  ']'
800E: 22        277  QUOT:SYM ASC  '"' ; QUOTE SYMBOL
800F: 3A        278  DELIMIT  ASC  ':' ; FIND/REPLACE DELIMITER
8010: 04        279  PR:CHAN  DFB  4          ; PRINTER CHANNEL
8011: 08        280  DISK:CHN DFB  8          ; DISK CHANNEL
8012: 00        281           DFB  0          ; SPARE FOR NOW
                282           DEND            
                283  *
                284  *
                     ************************************************
                286  * PART 1 VECTORS
                     ************************************************
                288  V1       EQU  P1         
                289  INIT     EQU  V1         
                290  GETNEXT  EQU  V1+3       
                291  COMSTL   EQU  V1+6       
                292  ISITHX   EQU  V1+9       
                293  ISITAL   EQU  V1+12      
                294  ISITNM   EQU  V1+15      
                295  CHAR     EQU  V1+18      
                296  GEN2:B   EQU  V1+21      
                297  DISHX    EQU  V1+24      
                298  ERROR    EQU  V1+27      
                299  GETCHK   EQU  V1+30      
                300  CHKTKN   EQU  V1+33      
                301  GENNOP   EQU  V1+36      
                302  GENADR   EQU  V1+39      
                303  GENNJP   EQU  V1+42      
                304  GENNJM   EQU  V1+45      
                305  TKNWRK   EQU  V1+48      
                306  PRBYTE   EQU  V1+51      
                307  GTOKEN   EQU  V1+54      
                308  SPARE2   EQU  V1+57      
                309  FIXAD    EQU  V1+60      
                310  PSHWRK   EQU  V1+63      
                311  PULWRK   EQU  V1+66      
                312  PC       EQU  V1+69      
                313  PT       EQU  V1+72      
                314  PL       EQU  V1+75      
                315  PC8      EQU  V1+78      
                316  GETANS   EQU  V1+81      
                317  PUTSP    EQU  V1+84      
                318  DISPAD   EQU  V1+87      
                319  CROUT    EQU  V1+90      
                320  SHLVAL   EQU  V1+93      
                321  GET:NUM  EQU  V1+96      
                322  GET:HEX  EQU  V1+99      
                323  FND:END  EQU  V1+102     
                324  PAUSE    EQU  V1+105     
                325  HOME     EQU  V1+108     
                326  RDKEY    EQU  V1+111     
                327  GENJMP   EQU  V1+114     
                328  GENRJMP  EQU  V1+117     
                329           ORG  P6         
BCB8: 4C F2 BC  330           JMP  BLOCK      
                331  *
                     ************************************************
                333  * PART 2 VECTORS
                     ************************************************
                335  V2       EQU  P2         
                336  STMNT    EQU  V2         
                337  EXPRES   EQU  V2+3       
                338  CHKLHP   EQU  V2+6       
                339  CHKRHP   EQU  V2+9       
                340  CHKLHB   EQU  V2+12      
                341  CHKRHB   EQU  V2+15      
                342  LOOKUP   EQU  V2+18      
                343  CHKDUP   EQU  V2+21      
                344  CONDEC   EQU  V2+24      
                345  VARDEC   EQU  V2+27      
                346  CONST    EQU  V2+30      
                347  GETSUB   EQU  V2+33      
                348  W:STRING EQU  V2+36      
                349  WRKTKN   EQU  V2+39      
                350  SYMWRK   EQU  V2+42      
                351  WRKSYM   EQU  V2+45      
                352  PSHPCODE EQU  V2+48      
                353  CHK:STAK EQU  V2+51      
                354  SEARCH   EQU  V2+54      
                355  ADDSYM   EQU  V2+57      
                356  TKNJMP   EQU  V2+60      
                357  *
                358  *
                     ************************************************
                360  CHKGET   EQU  *          
BCBB: 20 34 80  361           JSR  CHKTKN     
BCBE: 4C 49 80  362           JMP  GTOKEN     
                363  *
                364  WRK:VAL  EQU  *          
BCC1: 48        365           PHA             
BCC2: A5 3C     366           LDA  WORK       
BCC4: 85 1E     367           STA  VALUE      
BCC6: A5 3D     368           LDA  WORK+1     
BCC8: 85 1F     369           STA  VALUE+1    
BCCA: 68        370           PLA             
BCCB: 60        371           RTS             
                372  *
                373  VAL:WRK  EQU  *          
BCCC: 48        374           PHA             
BCCD: A5 1E     375           LDA  VALUE      
BCCF: 85 3C     376           STA  WORK       
BCD1: A5 1F     377           LDA  VALUE+1    
BCD3: 85 3D     378           STA  WORK+1     
BCD5: 68        379           PLA             
BCD6: 60        380           RTS             
                381  *
                382  END:WRK  EQU  *          
BCD7: 48        383           PHA             
BCD8: A5 32     384           LDA  ENDSYM     
BCDA: 85 3C     385           STA  WORK       
BCDC: A5 33     386           LDA  ENDSYM+1   
BCDE: 85 3D     387           STA  WORK+1     
BCE0: 68        388           PLA             
BCE1: 60        389           RTS             
                390  *
                     ************************************************
                392  *
                393  *
                394  * BLOCK
                395  *
BCE2: 82        396  BLCKT1   DFB  $82        
BCE3: 5F BD     397           DA   BLKCNS     
BCE5: 83        398  BLCKT2   DFB  $83        
BCE6: 76 BD     399           DA   BLKVAR     
BCE8: 86        400  BLCKT3   DFB  $86        
BCE9: B5 BE     401           DA   BLKPRC     
BCEB: 87        402           DFB  $87        
BCEC: D6 BE     403           DA   BLKFNC     
BCEE: 88        404           DFB  $88        
BCEF: A4 BF     405           DA   BLKBEG     
BCF1: 00        406           DFB  0          
                407  *
                408  *
BCF2: 20 07 8E  409  BLOCK    JSR  CHK:STAK   
BCF5: A9 00     410           LDA  #0         
BCF7: 85 24     411           STA  FRAME+1    
BCF9: A9 06     412           LDA  #6         
BCFB: 85 23     413           STA  FRAME      
BCFD: A5 3E     414           LDA  PRCITM     
BCFF: 85 3C     415           STA  WORK       
BD01: A6 3F     416           LDX  PRCITM+1   
BD03: 86 3D     417           STX  WORK+1     
BD05: 05 3F     418           ORA  PRCITM+1   
BD07: F0 3A     419           BEQ  BLK1       
                420  *
                421  * HERE CHECK FOR CONSTRUCT:
                422  *
                423  * PROCEDURE ABCD;
                424  * $1234;
                425  *
                426  * WHICH IS THE METHOD OF
                427  * REFERRING TO EXTERNAL
                428  * PROCEDURES
                429  *
BD09: A5 16     430           LDA  TOKEN      
BD0B: C9 4E     431           CMP  #'N'       
BD0D: D0 20     432           BNE  BLK1A      
BD0F: A0 00     433           LDY  #0         
BD11: B1 17     434           LDA  (TKNADR),Y 
BD13: C9 24     435           CMP  #'$'       
BD15: D0 18     436           BNE  BLK1A      
BD17: A0 04     437           LDY  #SYMDSP    
BD19: A5 1E     438           LDA  VALUE      
BD1B: 91 3C     439           STA  (WORK),Y   
BD1D: C8        440           INY             
BD1E: A5 1F     441           LDA  VALUE+1    
BD20: 91 3C     442           STA  (WORK),Y   
BD22: A9 01     443           LDA  #1         ; FLAG ABSOLUTE PROCEDURE
BD24: A0 08     444           LDY  #SYMDAT    
BD26: 91 3C     445           STA  (WORK),Y   
BD28: A9 3B     446           LDA  #';'       
BD2A: A2 0A     447           LDX  #10        
BD2C: 4C 31 80  448           JMP  GETCHK     
                449  *
BD2F: A0 04     450  BLK1A    LDY  #SYMDSP    
BD31: A5 26     451           LDA  PCODE      
BD33: 91 3C     452           STA  (WORK),Y   
BD35: C8        453           INY             
BD36: A5 27     454           LDA  PCODE+1    
BD38: 91 3C     455           STA  (WORK),Y   
BD3A: A9 00     456           LDA  #0         
BD3C: A0 08     457           LDY  #SYMDAT    
BD3E: 91 3C     458           STA  (WORK),Y   ; FLAG RELATIVE PROCEDURE
BD40: 4C 4B BD  459           JMP  BLK2       
BD43: A5 26     460  BLK1     LDA  PCODE      
BD45: 85 3C     461           STA  WORK       
BD47: A5 27     462           LDA  PCODE+1    
BD49: 85 3D     463           STA  WORK+1     
BD4B: 20 52 80  464  BLK2     JSR  PSHWRK     
BD4E: 20 3D 80  465           JSR  GENNJP     
BD51: A2 E2     466           LDX  #BLCKT1    
BD53: A0 BC     467           LDY  #>BLCKT1   
BD55: A5 16     468  BLK4     LDA  TOKEN      
BD57: 20 10 8E  469           JSR  TKNJMP     
BD5A: A2 19     470           LDX  #25        
BD5C: 20 2E 80  471           JSR  ERROR      
                472  *
                473  *
                474  * CONSTANT
                475  *
BD5F: 20 49 80  476  BLKCNS   JSR  GTOKEN     
BD62: 20 EC 8D  477  BLKCN1   JSR  CONDEC     
BD65: A9 3B     478           LDA  #';'       
BD67: A2 0A     479           LDX  #10        
BD69: 20 BB BC  480           JSR  CHKGET     
BD6C: A2 E5     481           LDX  #BLCKT2    
BD6E: A0 BC     482           LDY  #>BLCKT2   
BD70: 20 10 8E  483           JSR  TKNJMP     
BD73: 4C 62 BD  484           JMP  BLKCN1     
                485  *
                486  * VARIABLE
                487  *
BD76: A9 00     488  BLKVAR   LDA  #0         
BD78: 8D A7 02  489           STA  COUNT1     
BD7B: 20 49 80  490  BLKVR1   JSR  GTOKEN     
BD7E: 20 EF 8D  491  BLKVR6   JSR  VARDEC     
BD81: EE A7 02  492           INC  COUNT1     
BD84: 10 03     493           BPL  BLKVR7     
BD86: 4C F5 BD  494           JMP  BLKV13     ; ERROR
BD89: A5 16     495  BLKVR7   LDA  TOKEN      
BD8B: C9 2C     496           CMP  #','       
BD8D: F0 EC     497           BEQ  BLKVR1     
BD8F: A9 3A     498           LDA  #':'       
BD91: A2 05     499           LDX  #5         
BD93: 20 BB BC  500           JSR  CHKGET     
BD96: C9 84     501           CMP  #$84       ; ARRAY
BD98: F0 42     502           BEQ  BLKVR2     
BD9A: C9 FE     503           CMP  #$FE       ; INTEGER
BD9C: F0 0A     504           BEQ  BLKVR8     
BD9E: A9 A1     505           LDA  #$A1       ; CHAR
BDA0: A2 24     506           LDX  #36        
BDA2: 20 34 80  507           JSR  CHKTKN     
BDA5: 4C 9C BE  508           JMP  BLKVR3     
BDA8: 20 41 BE  509  BLKVR8   JSR  BLKVR9     
BDAB: A0 00     510  BLKV10   LDY  #SYMPRV    
BDAD: B1 3C     511           LDA  (WORK),Y   
BDAF: AA        512           TAX             
BDB0: C8        513           INY             
BDB1: B1 3C     514           LDA  (WORK),Y   
BDB3: 85 3D     515           STA  WORK+1     
BDB5: 8A        516           TXA             
BDB6: 85 3C     517           STA  WORK       ; PREVIOUS ITEM
BDB8: A0 08     518           LDY  #SYMDAT    
BDBA: A9 00     519           LDA  #0         ; INTEGER TYPE
BDBC: 91 3C     520           STA  (WORK),Y   
BDBE: A5 23     521           LDA  FRAME      
BDC0: A0 04     522           LDY  #SYMDSP    
BDC2: 91 3C     523           STA  (WORK),Y   
BDC4: C8        524           INY             
BDC5: A5 24     525           LDA  FRAME+1    
BDC7: 91 3C     526           STA  (WORK),Y   
BDC9: 18        527           CLC             
BDCA: A5 23     528           LDA  FRAME      
BDCC: 69 03     529           ADC  #3         
BDCE: 85 23     530           STA  FRAME      
BDD0: 90 02     531           BCC  BLKV10:A   
BDD2: E6 24     532           INC  FRAME+1    
                533  BLKV10:A EQU  *          
BDD4: CE A7 02  534           DEC  COUNT1     
BDD7: D0 D2     535           BNE  BLKV10     
BDD9: 4C 9C BE  536           JMP  BLKVR3     
                537  *
                538  * ARRAY [ N ] OF ...
                539  *
BDDC: 20 E0 8D  540  BLKVR2   JSR  CHKLHB     
BDDF: 20 F2 8D  541           JSR  CONST      
BDE2: A5 20     542           LDA  VALUE+2    
BDE4: D0 0F     543           BNE  BLKV13     
BDE6: A5 1E     544           LDA  VALUE      
BDE8: 18        545           CLC             
BDE9: 69 01     546           ADC  #1         
BDEB: 85 1E     547           STA  VALUE      
BDED: A5 1F     548           LDA  VALUE+1    
BDEF: 30 04     549           BMI  BLKV13     
BDF1: 69 00     550           ADC  #0         
BDF3: 10 05     551           BPL  BLKVR4     
BDF5: A2 0F     552  BLKV13   LDX  #15        
BDF7: 20 2E 80  553           JSR  ERROR      
BDFA: 85 1F     554  BLKVR4   STA  VALUE+1    
BDFC: 20 CC BC  555           JSR  VAL:WRK    
BDFF: 20 49 80  556           JSR  GTOKEN     
BE02: 20 E3 8D  557           JSR  CHKRHB     
BE05: A9 01     558           LDA  #1         
BE07: 85 6C     559           STA  DATTYP     
BE09: A9 85     560           LDA  #$85       ; OF
BE0B: A2 1A     561           LDX  #26        
BE0D: 20 BB BC  562           JSR  CHKGET     
BE10: C9 FE     563           CMP  #$FE       ; INTEGER
BE12: D0 20     564           BNE  BLKV11     
BE14: C6 6C     565           DEC  DATTYP     
BE16: 20 C1 BC  566           JSR  WRK:VAL    
                567  *
                568  * MULTIPLY VALUE BY 3
                569  *
BE19: A5 1E     570           LDA  VALUE      
BE1B: A6 1F     571           LDX  VALUE+1    
BE1D: 06 1E     572           ASL  VALUE      
BE1F: 26 1F     573           ROL  VALUE+1    
BE21: B0 D2     574           BCS  BLKV13     
BE23: 65 1E     575           ADC  VALUE      
BE25: 85 1E     576           STA  VALUE      
BE27: 8A        577           TXA             
BE28: 65 1F     578           ADC  VALUE+1    
BE2A: B0 C9     579           BCS  BLKV13     
BE2C: 85 1F     580           STA  VALUE+1    
BE2E: 20 CC BC  581           JSR  VAL:WRK    
BE31: 4C 3B BE  582           JMP  BLKV12     
BE34: A9 A1     583  BLKV11   LDA  #$A1       ; CHAR
BE36: A2 24     584           LDX  #36        
BE38: 20 34 80  585           JSR  CHKTKN     
BE3B: 20 41 BE  586  BLKV12   JSR  BLKVR9     
BE3E: 4C 5B BE  587           JMP  BLKVR5     
                588  BLKVR9   EQU  *          
BE41: A5 23     589           LDA  FRAME      
BE43: 38        590           SEC             
BE44: ED A7 02  591           SBC  COUNT1     
BE47: 85 23     592           STA  FRAME      
BE49: A5 24     593           LDA  FRAME+1    
BE4B: E9 00     594           SBC  #0         
BE4D: 85 24     595           STA  FRAME+1    
BE4F: 20 C1 BC  596           JSR  WRK:VAL    
BE52: A5 32     597           LDA  ENDSYM     
BE54: 85 3C     598           STA  WORK       
BE56: A5 33     599           LDA  ENDSYM+1   
BE58: 85 3D     600           STA  WORK+1     
BE5A: 60        601           RTS             
BE5B: A0 00     602  BLKVR5   LDY  #SYMPRV    
BE5D: B1 3C     603           LDA  (WORK),Y   
BE5F: AA        604           TAX             
BE60: C8        605           INY             
BE61: B1 3C     606           LDA  (WORK),Y   
BE63: 85 3D     607           STA  WORK+1     
BE65: 8A        608           TXA             
BE66: 85 3C     609           STA  WORK       ; PREVIOUS ITEM 
BE68: A0 03     610           LDY  #SYMTYP    
BE6A: A9 41     611           LDA  #'A'       
BE6C: 91 3C     612           STA  (WORK),Y   
BE6E: A0 04     613           LDY  #SYMDSP    
BE70: A5 23     614           LDA  FRAME      
BE72: 91 3C     615           STA  (WORK),Y   
BE74: C8        616           INY             
BE75: A5 24     617           LDA  FRAME+1    
BE77: 91 3C     618           STA  (WORK),Y   
BE79: A5 1E     619           LDA  VALUE      
BE7B: 18        620           CLC             
BE7C: 65 23     621           ADC  FRAME      
BE7E: 85 23     622           STA  FRAME      
BE80: A5 1F     623           LDA  VALUE+1    
BE82: 65 24     624           ADC  FRAME+1    
BE84: 85 24     625           STA  FRAME+1    
BE86: A0 08     626           LDY  #SYMDAT    
BE88: A5 6C     627           LDA  DATTYP     
BE8A: 91 3C     628           STA  (WORK),Y   
BE8C: A0 06     629           LDY  #SYMSUB    
BE8E: A5 1E     630           LDA  VALUE      
BE90: 91 3C     631           STA  (WORK),Y   
BE92: A5 1F     632           LDA  VALUE+1    
BE94: C8        633           INY             
BE95: 91 3C     634           STA  (WORK),Y   
BE97: CE A7 02  635           DEC  COUNT1     
BE9A: D0 BF     636           BNE  BLKVR5     
BE9C: A9 3B     637  BLKVR3   LDA  #';'       
BE9E: A2 0A     638           LDX  #10        
BEA0: 20 31 80  639           JSR  GETCHK     
BEA3: 20 49 80  640           JSR  GTOKEN     
BEA6: A2 E8     641           LDX  #BLCKT3    
BEA8: A0 BC     642           LDY  #>BLCKT3   
BEAA: 20 10 8E  643           JSR  TKNJMP     
BEAD: A9 00     644           LDA  #0         
BEAF: 8D A7 02  645           STA  COUNT1     
BEB2: 4C 7E BD  646           JMP  BLKVR6     
                647  *
                648  * PROCEDURE DECLARATION
                649  *
BEB5: A9 49     650  BLKPRC   LDA  #'I'       
BEB7: A2 04     651           LDX  #4         
BEB9: 20 31 80  652           JSR  GETCHK     
BEBC: A9 00     653           LDA  #0         
BEBE: 8D A7 02  654           STA  COUNT1     
BEC1: 20 E9 8D  655           JSR  CHKDUP     
BEC4: A9 50     656           LDA  #'P'       
BEC6: 20 0D 8E  657           JSR  ADDSYM     
BEC9: E6 25     658           INC  LEVEL      
BECB: A5 4E     659           LDA  SYMITM     
BECD: 85 3E     660           STA  PRCITM     
BECF: A5 4F     661           LDA  SYMITM+1   
BED1: 85 3F     662           STA  PRCITM+1   
BED3: 4C F9 BE  663           JMP  BLKPR1     
                664  *
                665  * FUNCTION DECLARATION
                666  *
BED6: A9 49     667  BLKFNC   LDA  #'I'       
BED8: A2 04     668           LDX  #4         
BEDA: 20 31 80  669           JSR  GETCHK     
BEDD: 20 E9 8D  670           JSR  CHKDUP     
BEE0: A9 46     671           LDA  #'F'       
BEE2: 20 0D 8E  672           JSR  ADDSYM     
BEE5: E6 25     673           INC  LEVEL      
BEE7: A9 01     674           LDA  #1         
BEE9: 8D A7 02  675           STA  COUNT1     
BEEC: A5 4E     676           LDA  SYMITM     
BEEE: 85 3E     677           STA  PRCITM     
BEF0: A5 4F     678           LDA  SYMITM+1   
BEF2: 85 3F     679           STA  PRCITM+1   
BEF4: A9 59     680           LDA  #'Y'       
BEF6: 20 0D 8E  681           JSR  ADDSYM     
                682  *
                683  * PROCEDURE AND FUNCTION COMMON CODE
                684  *
BEF9: AD A7 02  685  BLKPR1   LDA  COUNT1     
BEFC: 8D A8 02  686           STA  COUNT2     
BEFF: 20 D7 BC  687           JSR  END:WRK    
BF02: 20 52 80  688           JSR  PSHWRK     
BF05: A5 23     689           LDA  FRAME      
BF07: 85 3C     690           STA  WORK       
BF09: A5 24     691           LDA  FRAME+1    
BF0B: 85 3D     692           STA  WORK+1     
BF0D: 20 52 80  693           JSR  PSHWRK     
BF10: 20 49 80  694           JSR  GTOKEN     
BF13: C9 28     695           CMP  #'('       
BF15: D0 17     696           BNE  BLKPR2     
BF17: 20 49 80  697  BLKPR3   JSR  GTOKEN     
BF1A: 20 EF 8D  698           JSR  VARDEC     
BF1D: EE A7 02  699           INC  COUNT1     
BF20: 10 03     700           BPL  BLKPR6     
BF22: 4C F5 BD  701           JMP  BLKV13     
BF25: A5 16     702  BLKPR6   LDA  TOKEN      
BF27: C9 2C     703           CMP  #','       
BF29: F0 EC     704           BEQ  BLKPR3     
BF2B: 20 DD 8D  705           JSR  CHKRHP     
BF2E: A5 3E     706  BLKPR2   LDA  PRCITM     
BF30: 85 3C     707           STA  WORK       
BF32: A5 3F     708           LDA  PRCITM+1   
BF34: 85 3D     709           STA  WORK+1     
BF36: A0 06     710           LDY  #SYMARG    
BF38: AD A7 02  711           LDA  COUNT1     
BF3B: 38        712           SEC             
BF3C: ED A8 02  713           SBC  COUNT2     
BF3F: 91 3C     714           STA  (WORK),Y   
BF41: A9 3B     715           LDA  #';'       
BF43: A2 0A     716           LDX  #10        
BF45: 20 34 80  717           JSR  CHKTKN     
BF48: AD A7 02  718           LDA  COUNT1     
BF4B: F0 2B     719           BEQ  BLKPR4     
BF4D: 20 D7 BC  720           JSR  END:WRK    
BF50: A2 FD     721           LDX  #$FD       
BF52: A0 00     722  BLKPR5   LDY  #SYMPRV    
BF54: B1 3C     723           LDA  (WORK),Y   
BF56: 48        724           PHA             
BF57: C8        725           INY             
BF58: B1 3C     726           LDA  (WORK),Y   
BF5A: 85 3D     727           STA  WORK+1     
BF5C: 68        728           PLA             
BF5D: 85 3C     729           STA  WORK       
BF5F: A0 08     730           LDY  #SYMDAT    
BF61: A9 00     731           LDA  #0         
BF63: 91 3C     732           STA  (WORK),Y   
BF65: A0 04     733           LDY  #SYMDSP    
BF67: 8A        734           TXA             
BF68: 91 3C     735           STA  (WORK),Y   
BF6A: 38        736           SEC             
BF6B: E9 03     737           SBC  #3         
BF6D: AA        738           TAX             
BF6E: A9 FF     739           LDA  #$FF       
BF70: C8        740           INY             
BF71: 91 3C     741           STA  (WORK),Y   
BF73: CE A7 02  742           DEC  COUNT1     
BF76: D0 DA     743           BNE  BLKPR5     
BF78: 20 49 80  744  BLKPR4   JSR  GTOKEN     
BF7B: 20 F2 BC  745           JSR  BLOCK      
BF7E: C6 25     746           DEC  LEVEL      
BF80: 20 55 80  747           JSR  PULWRK     
BF83: A5 3C     748           LDA  WORK       
BF85: 85 23     749           STA  FRAME      
BF87: A5 3D     750           LDA  WORK+1     
BF89: 85 24     751           STA  FRAME+1    
BF8B: 20 55 80  752           JSR  PULWRK     
BF8E: A5 3C     753           LDA  WORK       
BF90: 85 32     754           STA  ENDSYM     
BF92: A5 3D     755           LDA  WORK+1     
BF94: 85 33     756           STA  ENDSYM+1   
BF96: A9 3B     757           LDA  #';'       
BF98: A2 0A     758           LDX  #10        
BF9A: 20 BB BC  759           JSR  CHKGET     
BF9D: A2 E8     760           LDX  #BLCKT3    
BF9F: A0 BC     761           LDY  #>BLCKT3   
BFA1: 4C 55 BD  762           JMP  BLK4       
                763  *
                764  * BEGIN (COMPOUND STATEMENT)
                765  *
BFA4: 20 49 80  766  BLKBEG   JSR  GTOKEN     
BFA7: 20 55 80  767           JSR  PULWRK     
BFAA: A5 25     768           LDA  LEVEL      
BFAC: D0 06     769           BNE  BLKB1      
BFAE: 20 4F 80  770  BLKB3    JSR  FIXAD      
BFB1: 4C D0 BF  771           JMP  BLKB2      
BFB4: 20 01 8E  772  BLKB1    JSR  WRKSYM     
BFB7: A0 04     773           LDY  #SYMDSP    
BFB9: B1 4E     774           LDA  (SYMITM),Y 
BFBB: 85 3C     775           STA  WORK       
BFBD: C8        776           INY             
BFBE: B1 4E     777           LDA  (SYMITM),Y 
BFC0: 85 3D     778           STA  WORK+1     
BFC2: A0 04     779           LDY  #SYMDSP    
BFC4: A5 26     780           LDA  PCODE      
BFC6: 91 4E     781           STA  (SYMITM),Y 
BFC8: A5 27     782           LDA  PCODE+1    
BFCA: C8        783           INY             
BFCB: 91 4E     784           STA  (SYMITM),Y 
BFCD: 4C AE BF  785           JMP  BLKB3      
BFD0: A5 23     786  BLKB2    LDA  FRAME      
BFD2: 85 2E     787           STA  OPND       
BFD4: A5 24     788           LDA  FRAME+1    
BFD6: 85 2F     789           STA  OPND+1     
BFD8: A9 3B     790           LDA  #59        
BFDA: 20 85 80  791           JSR  GENJMP     
BFDD: 20 D4 8D  792  BLKB5    JSR  STMNT      
BFE0: A5 16     793           LDA  TOKEN      
BFE2: C9 3B     794           CMP  #';'       
BFE4: D0 06     795           BNE  BLKB4      
BFE6: 20 49 80  796           JSR  GTOKEN     
BFE9: 4C DD BF  797           JMP  BLKB5      
BFEC: A9 89     798  BLKB4    LDA  #$89       ; END
BFEE: A2 11     799           LDX  #17        
BFF0: 20 BB BC  800           JSR  CHKGET     
BFF3: A9 29     801           LDA  #41        
BFF5: A6 25     802           LDX  LEVEL      
BFF7: D0 02     803           BNE  BLKB6      
BFF9: A9 11     804           LDA  #17        ; STOP 
                805  TEST1    EQU  *          
BFFB: 4C 37 80  806  BLKB6    JMP  GENNOP     
                807  *
BFFE: 00        809           BRK             


--End assembly, 839 bytes, Errors: 0 
