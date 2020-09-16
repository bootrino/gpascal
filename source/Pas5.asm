                     ************************************************
                2    * PASCAL COMPILER
                3    * for Commodore 64
                4    * PART 5
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
                123  EPNTR    EQU  $43        
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
                202  ECNTR    EQU  BPOINT     
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
                306  SEARCH   EQU  V1+51      
                307  ADDSYM   EQU  V1+54      
                308  SPARE2   EQU  V1+57      
                309  FIXAD    EQU  V1+60      
                310  PSHWRK   EQU  V1+63      
                311  PULWRK   EQU  V1+66      
                312  PC       EQU  V1+69      
                313  PT       EQU  V1+72      
                314  PL       EQU  V1+75      
                315  TOKEN1   EQU  V1+78      
                316  GETANS   EQU  V1+81      
                317  PUTSP    EQU  V1+84      
                318  DISPAD   EQU  V1+87      
                319  CROUT    EQU  V1+90      
                320  SHLVAL   EQU  V1+93      
                321  GET:NUM  EQU  V1+96      
                322  GET:HEX  EQU  V1+99      
                323  FND:ENQ  EQU  V1+102     
                324  PAUSE    EQU  V1+105     
                325  HOME     EQU  V1+108     
                326  RDKEY    EQU  V1+111     
                     ************************************************
                328  * PART 2 VECTORS
                     ************************************************
                330  V2       EQU  P2         
                331  TKNJMP   EQU  V2+60      
                332  *
                     ************************************************
                334  * PART 3 VECTORS
                     ************************************************
                336  V3       EQU  P3         
                337  START    EQU  V3         
                338  RESTART  EQU  V3+3       
                339  DSP:BIN  EQU  V3+6       
                340  ST:CMP   EQU  V3+9       
                341  ST:SYN   EQU  V3+12      
                342  DEBUG    EQU  V3+15      
                343  ST:EDI   EQU  V3+18      
                344  ST:FIL   EQU  V3+21      
                345  BELL1X   EQU  V3+24      
                     ************************************************
                347  * PART 4 VECTORS
                     ************************************************
                349  INTERJ   EQU  P4         
                     ************************************************
                351  * PART 5 STARTS HERE
                     ************************************************
                353           ORG  P5         
                354  *
                     ************************************************
                356  * TEXT EDITOR
                357  *
                     ************************************************
B384: 4C 6B B4  359           JMP  EDITOR     
B387: 4C 76 BC  360           JMP  GETLN      
B38A: 4C 76 BC  361           JMP  GETLNZ     
B38D: 4C 76 BC  362           JMP  GETLN1     
B390: 4C 26 BA  363           JMP  PUT:LINE   
B393: B6 CC 0D  364  GT:NO:EM DFB  $B6,$CC,$0D 
B396: 70 41 52  365  GET:ERR1 ASC  'pARDON? (',C9 
B399: 44 4F 4E 3F 20 28 C9 
B3A0: 20 68 20  366           ASC  ' h FOR HELP )',0D 
B3A3: 46 4F 52 20 48 45 4C 50 
B3AB: 20 29 0D 
B3AE: B6 D8 0D  367  DEL:ERR1 DFB  $B6,$D8,$0D 
B3B1: BF B1 0D  368  FULL:ERR DFB  $BF,$B1,$0D 
B3B4: 20 4D 4F  369  MOD:QN1  ASC  ' MODIFY ' 
B3B7: 44 49 46 59 20 
B3BC: 20 44 45  370  DEL:QN1  ASC  ' DELETE ' 
B3BF: 4C 45 54 45 20 
B3C4: 20 4C 49  371  DEL:QN2  ASC  ' LINES',CB 
B3C7: 4E 45 53 CB 
B3CB: 20 64 45  372  DEL      ASC  ' dELETED',0D 
B3CE: 4C 45 54 45 44 0D 
B3D4: 0D        373  HELP:1   DFB  $0D        
B3D5: 74 48 45  374  HELP:2   ASC  'tHE COMMANDS ARE :',0D 
B3D8: 20 43 4F 4D 4D 41 4E 44 
B3E0: 53 20 41 52 45 20 3A 0D 
B3E8: 0D        375  HELP:3   DFB  $0D        
B3E9: D4 0D     376  HELP:4   DFB  $D4,$0D    
B3EB: DB        377  HELP:5   DFB  $DB        
B3EC: 64 3E 45  378           ASC  'd>ELETE',CD,CC,D8,0D
B3EF: 4C 45 54 45 CD CC D8 0D 
B3F7: DB        379  HELP:5A  DFB  $DB        
B3F8: 66 3E 49  380           ASC  'f>IND  ',CD,CC,D8 
B3FB: 4E 44 20 20 CD CC D8 
B402: 20 2E B8  381           ASC  ' .',B8    
B405: 20 2E 0D  382           ASC  ' .',0D    
B408: DB        383  HELP:6   DFB  $DB        
B409: 69 3E 4E  384           ASC  'i>NSERT',CD,CC,0D
B40C: 53 45 52 54 CD CC 0D 
B413: DB        385  HELP:7   DFB  $DB        
B414: 6C 3E 49  386           ASC  'l>IST  ',CD,CC,D8,0D 
B417: 53 54 20 20 CD CC D8 0D 
B41F: DB        387  HELP:8   DFB  $DB        
B420: 6D 3E 4F  388           ASC  'm>ODIFY',CD,CC,D8,0D
B423: 44 49 46 59 CD CC D8 0D 
B42B: D7 0D     389  HELP:9   DFB  $D7,$0D    
B42D: DB        390  HELP:9A  DFB  $DB        
B42E: 72 3E 45  391           ASC  'r>EPLACE',CD,CC,D8
B431: 50 4C 41 43 45 CD CC D8 
B439: 20 2E 4F  392           ASC  ' .OLD.NEW.',0D 
B43C: 4C 44 2E 4E 45 57 2E 0D 
B444: D5 0D     393  HELP:10  DFB  $D5,$0D    
B446: B7 B8 0D  394  FND:ERR1 HEX  B7B80D     
                395  *
                396  * Editor jump table
                397  *
                398  ED:TBL   EQU  *          
B449: 51        399           ASC  'Q'
B44A: 69 BC     400           DA   WRAP       
B44C: 49        401           ASC  'I'
B44D: F0 B4     402           DA   INSERT     
B44F: 48        403           ASC  'H'
B450: B2 B4     404           DA   HELP       
B452: 4D        405           ASC  'M'
B453: BA B6     406           DA   MODIFY     
B455: 44        407           ASC  'D'
B456: DA B6     408           DA   DELETE     
B458: 4C        409           ASC  'L'
B459: 73 B7     410           DA   LISTLNS    
B45B: 46        411           ASC  'F'
B45C: 73 B7     412           DA   LISTLNS    
B45E: 52        413           ASC  'R'
B45F: 73 B7     414           DA   LISTLNS    
B461: 4E        415           ASC  'N'
B462: AA B4     416           DA   NLIST      
B464: 43        417           ASC  'C'
B465: 37 99     418           DA   ST:CMP     
B467: 53        419           ASC  'S'
B468: 3A 99     420           DA   ST:SYN     
B46A: 00        421           DFB  0          
                422  *
                423  EDITOR   EQU  *          
B46B: A9 40     424           LDA  #ST:EDI    
B46D: 85 54     425           STA  CTRLC:RT   
B46F: A9 99     426           LDA  #>ST:EDI   
B471: 85 55     427           STA  CTRLC:RT+1 
                428  *
                429  GET:COM  EQU  *          
B473: A2 FF     430           LDX  #$FF       
B475: 9A        431           TXS             
B476: 20 6D 80  432           JSR  CROUT      
B479: 20 7F B4  433           JSR  GET:C1     
B47C: 4C 73 B4  434           JMP  GET:COM    ; back for next command
                     ************************************************
                436  GET:C1   EQU  *          
B47F: A9 80     437           LDA  #$80       
B481: 85 49     438           STA  RUNNING    
B483: A9 00     439           LDA  #0         
B485: 8D F1 02  440           STA  NLN:FLAG   
B488: A9 3A     441           LDA  #':'       
B48A: 20 D2 FF  442           JSR  COUT       ; editor prompt
B48D: 20 CF B4  443           JSR  GET:LINE   
B490: E0 00     444           CPX  #0         
B492: F0 EB     445           BEQ  GET:C1     
B494: AD 3C 03  446           LDA  INBUF      
B497: 29 7F     447           AND  #$7F       
B499: 8D BE 02  448           STA  ED:COM     
B49C: A2 49     449           LDX  #ED:TBL    
B49E: A0 B4     450           LDY  #>ED:TBL   
B4A0: 20 10 8E  451           JSR  TKNJMP     
B4A3: A9 96     452           LDA  #GET:ERR1  
B4A5: A2 B3     453           LDX  #>GET:ERR1 
B4A7: 4C 5E 80  454           JMP  PL         
                455  *
                456  NLIST    EQU  *          
B4AA: A9 01     457           LDA  #1         
B4AC: 8D F1 02  458           STA  NLN:FLAG   
B4AF: 4C 73 B7  459           JMP  LISTLNS    
                460  *
                461  *
                462  HELP     EQU  *          
                     ************************************************
B4B2: A9 0C     464           LDA  #12        
B4B4: 8D B1 02  465           STA  ECNTR      
B4B7: A9 D4     466           LDA  #HELP:1    
B4B9: A2 B3     467           LDX  #>HELP:1   
                468  PRT:HELP EQU  *          
B4BB: 20 5E 80  469           JSR  PL         
B4BE: 98        470           TYA             
B4BF: 18        471           CLC             
B4C0: 65 06     472           ADC  REG2       
B4C2: A8        473           TAY             
B4C3: A5 07     474           LDA  REG2+1     
B4C5: 69 00     475           ADC  #0         
B4C7: AA        476           TAX             
B4C8: 98        477           TYA             
B4C9: CE B1 02  478           DEC  ECNTR      
B4CC: D0 ED     479           BNE  PRT:HELP   
B4CE: 60        480           RTS             
                481  *
                482  * read input line - tokenize - count chars to c/r
                483  *
                484  GET:LINE EQU  *          
B4CF: 20 76 BC  485           JSR  GETLN1     
B4D2: AD 3C 03  486           LDA  INBUF      
B4D5: C9 A0     487           CMP  #"         " ; if first char on line shift/space remember it
B4D7: 08        488           PHP             ; save processor flags
                489  * 
                490  * now tidy input line for automatic tokenisation
                491  * 
B4D8: A9 3C     492           LDA  #INBUF     
B4DA: A2 03     493           LDX  #>INBUF    
B4DC: 20 29 BB  494           JSR  TIDY:ENT   ; off we go
B4DF: A2 00     495           LDX  #0         
B4E1: BD 3C 03  496  GET:LIN9 LDA  INBUF,X    ; count up to c/r
B4E4: C9 0D     497           CMP  #$0D       
B4E6: F0 03     498           BEQ  GET:LIN8   ; found it
B4E8: E8        499           INX             
B4E9: D0 F6     500           BNE  GET:LIN9   ; try again
B4EB: 8E B7 02  501  GET:LIN8 STX  IN:LGTH    ; save length
B4EE: 28        502           PLP             ; back to result of earlier comparison
B4EF: 60        503           RTS             
                504  *
                505  *
                506  INSERT   EQU  *          
                     ************************************************
                508  IN:2     EQU  *          
B4F0: A0 00     509           LDY  #0         
B4F2: 20 8F B5  510           JSR  GET:NO     
B4F5: 90 01     511           BCC  IN:5       
B4F7: 60        512           RTS             
                513  IN:5     EQU  *          
B4F8: 20 CE B5  514           JSR  FIND:LN    
                515  IN:10    EQU  *          
B4FB: 20 1B BA  516           JSR  PT:LN:NO   
B4FE: 20 CF B4  517           JSR  GET:LINE   
B501: F0 05     518           BEQ  IN:11      ; stay in input mode if shift/space
B503: E0 00     519           CPX  #0         
B505: D0 01     520           BNE  IN:11      
B507: 60        521           RTS             
                522  IN:11    EQU  *          
B508: 20 3E B5  523           JSR  INST:TXT   
                524  * MOVE LINE FROM INPUT
                525  * BUFFER INTO TEXT
B50B: A9 3C     526           LDA  #INBUF     
B50D: 85 45     527           STA  TO         
B50F: A9 03     528           LDA  #>INBUF    
B511: 85 46     529           STA  TO+1       
B513: A9 00     530           LDA  #0         
B515: 8D B9 02  531           STA  LENGTH+1   
B518: AD B7 02  532           LDA  IN:LGTH    
B51B: 8D B8 02  533           STA  LENGTH     
B51E: F0 03     534           BEQ  IN:22      ; zero length - no move
B520: 20 32 B6  535           JSR  MV:TXT:L   
                536  IN:22    EQU  *          
B523: A5 26     537           LDA  PNTR       
B525: 18        538           CLC             
B526: 6D B8 02  539           ADC  LENGTH     
B529: 85 26     540           STA  PNTR       
B52B: A5 27     541           LDA  PNTR+1     
B52D: 6D B9 02  542           ADC  LENGTH+1   
B530: 85 27     543           STA  PNTR+1     
B532: A9 0D     544           LDA  #CR        
B534: A0 00     545           LDY  #0         
B536: 91 26     546           STA  (PNTR),Y   
B538: 20 B3 B6  547           JSR  INC:PNTR   
B53B: 4C FB B4  548           JMP  IN:10      
                549  *
                550  *
                551  INST:TXT EQU  *          
                552  * MAKE ROOM IN TEXT 
B53E: A5 26     553           LDA  PNTR       
B540: 85 4E     554           STA  FROM       
B542: 8D BA 02  555           STA  FROM:ST    
B545: 85 43     556           STA  EPNTR      
B547: A5 27     557           LDA  PNTR+1     
B549: 85 4F     558           STA  FROM+1     
B54B: 8D BB 02  559           STA  FROM:ST+1  
B54E: 85 44     560           STA  EPNTR+1    
B550: 20 0B B6  561           JSR  FIND:END   
B553: A5 4E     562           LDA  FROM       
B555: 18        563           CLC             
B556: 6D B7 02  564           ADC  IN:LGTH    
B559: 85 45     565           STA  TO         
B55B: A5 4F     566           LDA  FROM+1     
B55D: 69 00     567           ADC  #0         
B55F: 85 46     568           STA  TO+1       
                569  * SOURCE TOO BIG ? 
B561: 18        570           CLC             
B562: A5 45     571           LDA  TO         
B564: 6D B8 02  572           ADC  LENGTH     
B567: 85 43     573           STA  EPNTR      
B569: A5 46     574           LDA  TO+1       
B56B: 6D B9 02  575           ADC  LENGTH+1   
B56E: 85 43     576           STA  EPNTR      
B570: C9 7F     577           CMP  #>P1-$18   ; start of G-Pascal
B572: 90 0A     578           BLT  IN:13      
B574: A9 B1     579           LDA  #FULL:ERR  
B576: A2 B3     580           LDX  #>FULL:ERR 
B578: 20 5E 80  581           JSR  PL         
B57B: 4C 73 B4  582           JMP  GET:COM    
                583  IN:13    EQU  *          
B57E: 20 3F BC  584           JSR  INC:TO     
B581: 20 57 B6  585           JSR  MV:TXT:R   
B584: AD BA 02  586           LDA  FROM:ST    
B587: 85 4E     587           STA  FROM       
B589: AD BB 02  588           LDA  FROM:ST+1  
B58C: 85 4F     589           STA  FROM+1     
B58E: 60        590           RTS             
                591  *
                592  *
                593  GET:NO   EQU  *          
                     ************************************************
                595  * RETURNS THE
                596  * NUMBER IN VALUE
B58F: C8        597           INY             
B590: CC B7 02  598           CPY  IN:LGTH    
B593: D0 08     599           BNE  GET:NO:2   
B595: A0 00     600           LDY  #0         
B597: 84 1E     601           STY  VALUE      
B599: 84 1F     602           STY  VALUE+1    
B59B: 18        603           CLC             
B59C: 60        604           RTS             
                605  GET:NO:2 EQU  *          
B59D: B9 3C 03  606           LDA  INBUF,Y    
B5A0: C9 20     607           CMP  #'         '
B5A2: F0 EB     608           BEQ  GET:NO     
B5A4: 20 22 80  609           JSR  ISITNM     
B5A7: 90 09     610           BCC  GET:NO:5   
                611  GT:NO:ER EQU  *          
B5A9: A9 93     612           LDA  #GT:NO:EM  
B5AB: A2 B3     613           LDX  #>GT:NO:EM 
B5AD: 20 5E 80  614           JSR  PL         
B5B0: 38        615           SEC             
B5B1: 60        616           RTS             
                617  GET:NO:5 EQU  *          
B5B2: 84 26     618           STY  PNTR       
B5B4: 48        619           PHA             
B5B5: 98        620           TYA             
B5B6: 18        621           CLC             
B5B7: 69 3C     622           ADC  #INBUF     
B5B9: 85 1C     623           STA  NXTCHR     
B5BB: A9 00     624           LDA  #0         
B5BD: 85 5B     625           STA  SIGN       
B5BF: 69 03     626           ADC  #>INBUF    
B5C1: 85 1D     627           STA  NXTCHR+1   
B5C3: 68        628           PLA             
B5C4: 20 73 80  629           JSR  GET:NUM    
B5C7: B0 E0     630           BCS  GT:NO:ER   
B5C9: A5 20     631           LDA  VALUE+2    
B5CB: D0 DC     632           BNE  GT:NO:ER   
B5CD: 60        633           RTS             
                634  *
                635  FIND:LN  EQU  *          
                     ************************************************
B5CE: AD 09 80  637           LDA  TS         
B5D1: 85 26     638           STA  PNTR       
B5D3: AD 0A 80  639           LDA  TS+1       
B5D6: 85 27     640           STA  PNTR+1     
B5D8: A0 00     641           LDY  #0         
B5DA: A2 00     642           LDX  #0         
B5DC: 84 02     643           STY  LINE:NO    
B5DE: 84 03     644           STY  LINE:NO+1  
B5E0: A5 1E     645           LDA  VALUE      
B5E2: D0 08     646           BNE  FL:5       
B5E4: A5 1F     647           LDA  VALUE+1    
B5E6: D0 04     648           BNE  FL:5       
B5E8: 60        649           RTS             
                650  FL:LOOP  EQU  *          
B5E9: 20 B3 B6  651           JSR  INC:PNTR   
                652  FL:5     EQU  *          
B5EC: B1 26     653           LDA  (PNTR),Y   
B5EE: D0 03     654           BNE  FL:10      
B5F0: 86 02     655           STX  LINE:NO    
B5F2: 60        656           RTS             
                657  FL:10    EQU  *          
B5F3: C9 0D     658           CMP  #CR        
B5F5: D0 F2     659           BNE  FL:LOOP    
B5F7: E8        660           INX             
B5F8: D0 02     661           BNE  FL:15      
B5FA: E6 03     662           INC  LINE:NO+1  
                663  FL:15    EQU  *          
B5FC: E4 1E     664           CPX  VALUE      
B5FE: D0 E9     665           BNE  FL:LOOP    
B600: A5 03     666           LDA  LINE:NO+1  
B602: C5 1F     667           CMP  VALUE+1    
B604: D0 E3     668           BNE  FL:LOOP    
B606: 86 02     669           STX  LINE:NO    
B608: 4C B3 B6  670           JMP  INC:PNTR   
                671  *
                672  FIND:END EQU  *          
                673  * RETURNS LENGTH OF TEXT
                674  * FROM 'POINTER' TO END
                675  * OF FILE IN 'LENGTH'
B60B: A2 01     676           LDX  #1         
B60D: 8E B1 02  677           STX  ECNTR      
B610: A0 00     678           LDY  #0         
B612: 8C B2 02  679           STY  ECNTR+1    
B615: B1 43     680  FE:5     LDA  (EPNTR),Y  
B617: D0 0A     681           BNE  FE:10      
B619: 8E B8 02  682           STX  LENGTH     
B61C: AE B2 02  683           LDX  ECNTR+1    
B61F: 8E B9 02  684           STX  LENGTH+1   
B622: 60        685           RTS             
B623: E8        686  FE:10    INX             
B624: D0 03     687           BNE  FE:15      
B626: EE B2 02  688           INC  ECNTR+1    
                689  FE:15    EQU  *          
B629: E6 43     690           INC  EPNTR      
B62B: D0 E8     691           BNE  FE:5       
B62D: E6 44     692           INC  EPNTR+1    
B62F: 4C 15 B6  693           JMP  FE:5       
                694  *
                695  MV:TXT:L EQU  *          
                696  * NOTE: MOVING TEXT
                697  * FROM 'TO' TO 'FROM'
                698  * POSITIONS
B632: 20 9F B6  699           JSR  ZRO:CNTR   
B635: B1 45     700  MV:5     LDA  (TO),Y     
B637: 91 4E     701           STA  (FROM),Y   
B639: 20 AA B6  702           JSR  INC:ECNTR  
B63C: AD B1 02  703           LDA  ECNTR      
B63F: CD B8 02  704           CMP  LENGTH     
B642: D0 09     705           BNE  MV:10      
B644: AD B2 02  706           LDA  ECNTR+1    
B647: CD B9 02  707           CMP  LENGTH+1   
B64A: D0 01     708           BNE  MV:10      
B64C: 60        709           RTS             
                710  MV:10    EQU  *          
B64D: C8        711           INY             
B64E: D0 E5     712           BNE  MV:5       
B650: E6 4F     713           INC  FROM+1     
B652: E6 46     714           INC  TO+1       
B654: 4C 35 B6  715           JMP  MV:5       
                716  MV:TXT:R EQU  *          
                717  * NOTE TO > FROM
                718  * Y ZEROED IN ZRO:CNTR
B657: 20 9F B6  719           JSR  ZRO:CNTR   
B65A: A5 4E     720           LDA  FROM       
B65C: 18        721           CLC             
B65D: 6D B8 02  722           ADC  LENGTH     
B660: 85 4E     723           STA  FROM       
B662: A5 4F     724           LDA  FROM+1     
B664: 6D B9 02  725           ADC  LENGTH+1   
B667: 85 4F     726           STA  FROM+1     
B669: A5 45     727           LDA  TO         
B66B: 18        728           CLC             
B66C: 6D B8 02  729           ADC  LENGTH     
B66F: 85 45     730           STA  TO         
B671: A5 46     731           LDA  TO+1       
B673: 6D B9 02  732           ADC  LENGTH+1   
B676: 85 46     733           STA  TO+1       
B678: 4C 93 B6  734           JMP  MVR:10     
B67B: B1 4E     735  MVR:5    LDA  (FROM),Y   
B67D: 91 45     736           STA  (TO),Y     
B67F: 20 AA B6  737           JSR  INC:ECNTR  
B682: AD B1 02  738           LDA  ECNTR      
B685: CD B8 02  739           CMP  LENGTH     
B688: D0 09     740           BNE  MVR:10     
B68A: AD B2 02  741           LDA  ECNTR+1    
B68D: CD B9 02  742           CMP  LENGTH+1   
B690: D0 01     743           BNE  MVR:10     
B692: 60        744           RTS             
                745  MVR:10   EQU  *          
B693: 88        746           DEY             
B694: C0 FF     747           CPY  #$FF       
B696: D0 E3     748           BNE  MVR:5      
B698: C6 4F     749           DEC  FROM+1     
B69A: C6 46     750           DEC  TO+1       
B69C: 4C 7B B6  751           JMP  MVR:5      
                752  *
                753  ZRO:CNTR EQU  *          
                     ************************************************
B69F: A0 00     755           LDY  #0         
B6A1: 8C B1 02  756           STY  ECNTR      
B6A4: 8C B2 02  757           STY  ECNTR+1    
B6A7: 84 53     758           STY  VAL:CMP    
B6A9: 60        759           RTS             
                760  *
                761  INC:ECNTR EQU  *          
                     ************************************************
B6AA: EE B1 02  763           INC  ECNTR      
B6AD: D0 03     764           BNE  INC:C:5    
B6AF: EE B2 02  765           INC  ECNTR+1    
                766  INC:C:5  EQU  *          
B6B2: 60        767           RTS             
                768  *
                769  INC:PNTR EQU  *          
                     ************************************************
B6B3: E6 26     771           INC  PNTR       
B6B5: D0 02     772           BNE  INC:5      
B6B7: E6 27     773           INC  PNTR+1     
B6B9: 60        774  INC:5    RTS             
                775  *
                776  MODIFY   EQU  *          
                     ************************************************
B6BA: 20 73 B7  778           JSR  LISTLNS    
B6BD: 90 01     779           BCC  MOD:10     
B6BF: 60        780           RTS             
                781  MOD:10   EQU  *          
B6C0: 20 DA B6  782           JSR  DELETE     
B6C3: A0 00     783           LDY  #0         
B6C5: 20 8F B5  784           JSR  GET:NO     
B6C8: C6 1E     785           DEC  VALUE      
B6CA: A5 1E     786           LDA  VALUE      
B6CC: C9 FF     787           CMP  #$FF       
B6CE: D0 02     788           BNE  MOD:20     
B6D0: C6 1F     789           DEC  VALUE+1    
                790  MOD:20   EQU  *          
B6D2: A9 49     791           LDA  #'I'       ; FOOL INSERT
B6D4: 8D BE 02  792           STA  ED:COM     
B6D7: 4C F8 B4  793           JMP  IN:5       
                794  *
                795  DELETE   EQU  *          
                     ************************************************
B6DA: 20 5D BA  797           JSR  GETRANGE   
B6DD: 90 01     798           BCC  DEL:20     
B6DF: 60        799           RTS             
                800  DEL:20   EQU  *          
B6E0: 20 53 BC  801           JSR  DEC:FROM   
B6E3: 20 D3 BA  802           JSR  FRM:ADDR   
B6E6: A5 02     803           LDA  LINE:NO    
B6E8: 85 5C     804           STA  TEMP       
B6EA: A5 03     805           LDA  LINE:NO+1  
B6EC: 85 5D     806           STA  TEMP+1     
B6EE: 20 BF BA  807           JSR  TO:ADDR    
B6F1: A5 26     808           LDA  PNTR       
B6F3: 85 43     809           STA  EPNTR      
B6F5: A5 27     810           LDA  PNTR+1     
B6F7: 85 44     811           STA  EPNTR+1    
B6F9: 20 0B B6  812           JSR  FIND:END   
B6FC: A5 02     813           LDA  LINE:NO    
B6FE: 38        814           SEC             
B6FF: E5 5C     815           SBC  TEMP       
B701: 8D BC 02  816           STA  NUM:LINS   
B704: A5 03     817           LDA  LINE:NO+1  
B706: E5 5D     818           SBC  TEMP+1     
B708: 8D BD 02  819           STA  NUM:LINS+1 
B70B: AD BC 02  820           LDA  NUM:LINS   
B70E: C9 05     821           CMP  #5         
B710: B0 05     822           BGE  DEL:45     
B712: AD BD 02  823           LDA  NUM:LINS+1 
B715: F0 33     824           BEQ  DEL:55     
                825  DEL:45   EQU  *          
B717: A9 B9     826           LDA  #$B9       
B719: 20 58 80  827           JSR  PC         
B71C: A9 C2     828           LDA  #$C2       
B71E: 20 58 80  829           JSR  PC         
B721: AD BE 02  830           LDA  ED:COM     
B724: C9 4D     831           CMP  #'M'       
B726: F0 06     832           BEQ  DEL:50     
B728: A9 BC     833           LDA  #DEL:QN1   
B72A: A2 B3     834           LDX  #>DEL:QN1  
B72C: D0 04     835           BNE  DEL:52     
                836  DEL:50   EQU  *          
B72E: A9 B4     837           LDA  #MOD:QN1   
B730: A2 B3     838           LDX  #>MOD:QN1  
                839  DEL:52   EQU  *          
B732: A0 08     840           LDY  #$8        
B734: 20 5B 80  841           JSR  PT         
B737: 20 62 B7  842           JSR  PUT:NO     
B73A: A9 C4     843           LDA  #DEL:QN2   
B73C: A2 B3     844           LDX  #>DEL:QN2  
B73E: A0 07     845           LDY  #7         
B740: 20 64 80  846           JSR  GETANS     
B743: C9 59     847           CMP  #'Y'       
B745: F0 03     848           BEQ  DEL:55     
B747: 4C 73 B4  849           JMP  GET:COM    
                850  DEL:55   EQU  *          
B74A: 20 32 B6  851           JSR  MV:TXT:L   
B74D: AD BE 02  852           LDA  ED:COM     
B750: C9 4D     853           CMP  #'M'       
B752: D0 01     854           BNE  DEL:60     
B754: 60        855           RTS             
                856  DEL:60   EQU  *          
B755: 20 6D 80  857           JSR  CROUT      
B758: 20 62 B7  858           JSR  PUT:NO     
B75B: A9 CB     859           LDA  #DEL       
B75D: A2 B3     860           LDX  #>DEL      
B75F: 4C 5E 80  861           JMP  PL         
                862  *
                863  PUT:NO   EQU  *          
                     ************************************************
B762: AD BC 02  865           LDA  NUM:LINS   
B765: 85 04     866           STA  REG        
B767: AD BD 02  867           LDA  NUM:LINS+1 
B76A: 85 05     868           STA  REG+1      
B76C: A9 00     869           LDA  #0         
B76E: 85 58     870           STA  REGB       
B770: 4C 34 99  871           JMP  DSP:BIN    
                872  *
                873  LISTLNS  EQU  *          
                     ************************************************
B773: AD 3D 03  875           LDA  INBUF+1    
B776: CD 0F 80  876           CMP  DELIMIT    
B779: F0 07     877           BEQ  LIS:5      
B77B: AD B7 02  878           LDA  IN:LGTH    
B77E: C9 01     879           CMP  #1         
B780: D0 1B     880           BNE  LIS:10     
                881  * PRINT ALL 
B782: A9 00     882  LIS:5    LDA  #0         
B784: A8        883           TAY             
B785: 85 02     884           STA  LINE:NO    
B787: 85 03     885           STA  LINE:NO+1  
B789: AD 09 80  886           LDA  TS         
B78C: 85 4E     887           STA  FROM       
B78E: AD 0A 80  888           LDA  TS+1       
B791: 85 4F     889           STA  FROM+1     
B793: A9 FF     890           LDA  #$FF       
B795: 8D C0 02  891           STA  TO:LINE    
B798: 8D C1 02  892           STA  TO:LINE+1  
B79B: D0 1C     893           BNE  LIS:33     
                894  LIS:10   EQU  *          
B79D: 20 5D BA  895           JSR  GETRANGE   
B7A0: 90 01     896           BCC  LIS:20     
B7A2: 60        897           RTS             
                898  LIS:20   EQU  *          
B7A3: A5 45     899           LDA  TO         
B7A5: 8D C0 02  900           STA  TO:LINE    
B7A8: A5 46     901           LDA  TO+1       
B7AA: 8D C1 02  902           STA  TO:LINE+1  
B7AD: E6 02     903           INC  LINE:NO    
B7AF: D0 02     904           BNE  LIS:31     
B7B1: E6 03     905           INC  LINE:NO+1  
                906  LIS:31   EQU  *          
B7B3: 20 53 BC  907           JSR  DEC:FROM   
B7B6: 20 D3 BA  908           JSR  FRM:ADDR   
B7B9: AD BE 02  909  LIS:33   LDA  ED:COM     
B7BC: C9 52     910           CMP  #'R'       ; REPLACE?
B7BE: F0 07     911           BEQ  LIS:33A    ; YES
B7C0: C9 46     912           CMP  #'F'       ; FIND ?
B7C2: F0 03     913           BEQ  LIS:33A    ; YES
B7C4: 4C 92 B8  914           JMP  LIS:55     
                915  LIS:33A  EQU  *          
B7C7: A0 00     916           LDY  #0         
B7C9: 8C FE 02  917           STY  QT:SIZE    
B7CC: 8C BC 02  918           STY  NUM:LINS   
B7CF: 8C BD 02  919           STY  NUM:LINS+1 
B7D2: 8C F6 02  920           STY  TRN:FLAG   
B7D5: 8C F7 02  921           STY  GLB:FLAG   
B7D8: 8C F2 02  922           STY  Q:FLAG     
B7DB: B9 3C 03  923  LIS:34   LDA  INBUF,Y    
B7DE: CD 0F 80  924           CMP  DELIMIT    
B7E1: F0 0D     925           BEQ  LIS:35     ; FOUND OPENER
B7E3: C8        926           INY             
B7E4: CC B7 02  927           CPY  IN:LGTH    
B7E7: D0 F2     928           BNE  LIS:34     
B7E9: A9 46     929  LIS:34A  LDA  #FND:ERR1  
B7EB: A2 B4     930           LDX  #>FND:ERR1 
B7ED: 4C BA BA  931           JMP  GETR:31    
                932  * 
                933  LIS:35   EQU  *          
B7F0: C8        934           INY             
B7F1: 8C C2 02  935           STY  FND:FROM   
B7F4: CC B7 02  936  LIS:36   CPY  IN:LGTH    
B7F7: F0 F0     937           BEQ  LIS:34A    
B7F9: B9 3C 03  938           LDA  INBUF,Y    
B7FC: CD 0F 80  939           CMP  DELIMIT    
B7FF: F0 03     940           BEQ  LIS:37     ; FOUND CLOSER
B801: C8        941           INY             
B802: D0 F0     942           BNE  LIS:36     
                943  *
                944  LIS:37   EQU  *          
B804: 8C C3 02  945           STY  FND:TO     
B807: 38        946           SEC             
B808: AD C3 02  947           LDA  FND:TO     
B80B: ED C2 02  948           SBC  FND:FROM   
B80E: 8D F0 02  949           STA  REP:SIZE   
B811: 8D F4 02  950           STA  FND:LEN    
                951  *
B814: AD BE 02  952           LDA  ED:COM     
B817: C9 52     953           CMP  #'R'       ; REPLACE?
B819: D0 3C     954           BNE  LIS:45     ; NOPE
B81B: C8        955           INY             
B81C: 8C B3 02  956           STY  REP:FROM   ; START OF NEW STRING
                957  LIS:38   EQU  *          
B81F: CC B7 02  958           CPY  IN:LGTH    
B822: F0 C5     959           BEQ  LIS:34A    ; NO DELIMITER
B824: B9 3C 03  960           LDA  INBUF,Y    
B827: CD 0F 80  961           CMP  DELIMIT    
B82A: F0 0E     962           BEQ  LIS:39     ; END
                963  *
                964  * now see if new string contains spaces or DLE's -
                965  * if so we need to flag a tidy for later (to amalgamate
                966  * multiple spaces/DLE's etc.
                967  *
B82C: C9 10     968           CMP  #$10       ; DLE?
B82E: F0 04     969           BEQ  LIS:38A    ; yes
B830: C9 20     970           CMP  #'         ' ; space?
B832: D0 03     971           BNE  LIS:38B    ; no - forget it
B834: EE FE 02  972  LIS:38A  INC  QT:SIZE    ; flag it
                973  LIS:38B  EQU  *          
B837: C8        974           INY             
B838: D0 E5     975           BNE  LIS:38     
                976  *
                977  LIS:39   EQU  *          
B83A: 8C B4 02  978           STY  REP:TO     
B83D: 38        979           SEC             
B83E: AD C3 02  980           LDA  FND:TO     
B841: ED C2 02  981           SBC  FND:FROM   
B844: 8D F4 02  982           STA  FND:LEN    
B847: 38        983           SEC             
B848: AD B4 02  984           LDA  REP:TO     
B84B: ED B3 02  985           SBC  REP:FROM   
B84E: 8D F0 02  986           STA  REP:SIZE   
B851: ED F4 02  987           SBC  FND:LEN    
B854: 8D B5 02  988           STA  REP:LEN    ; DIFFERENCE IN STRING LENGTHS
                989  * 
                990  *
                991  * NOW LOOK FOR FLAG
                992  *
B857: C8        993  LIS:45   INY             
B858: CC B7 02  994  LIS:46   CPY  IN:LGTH    ; MORE ON LINE?
B85B: F0 2C     995           BEQ  LIS:50     ; NO
B85D: B9 3C 03  996           LDA  INBUF,Y    
B860: C9 20     997           CMP  #'         '
B862: F0 F3     998           BEQ  LIS:45     ; IGNORE SPACES
B864: 29 7F     999           AND  #$7F       ; make sure in lower (upper?) case ...
B866: C9 47     1000 LIS:47   CMP  #'G'       ; GLOBAL?
B868: D0 0A     1001          BNE  LIS:48     ; NO
B86A: 8D F7 02  1002          STA  GLB:FLAG   ; FLAG IT
B86D: AD F4 02  1003          LDA  FND:LEN    
B870: F0 14     1004          BEQ  LIS:ERR    
B872: D0 E3     1005          BNE  LIS:45     
                1006 * 
                1007 * 
B874: C9 54     1008 LIS:48   CMP  #'T'       ; TRANSLATE?
B876: D0 05     1009          BNE  LIS:49     ; NO -
B878: 8D F6 02  1010          STA  TRN:FLAG   
B87B: F0 DA     1011          BEQ  LIS:45     
B87D: C9 51     1012 LIS:49   CMP  #'Q'       ;QUIET?
B87F: D0 05     1013          BNE  LIS:ERR    
B881: 8D F2 02  1014          STA  Q:FLAG     
B884: F0 D1     1015          BEQ  LIS:45     
B886: 4C E9 B7  1016 LIS:ERR  JMP  LIS:34A    ; NONE - ERROR
                1017 *
                1018 *
B889: AD B5 02  1019 LIS:50   LDA  REP:LEN    
B88C: 8D B7 02  1020          STA  IN:LGTH    
B88F: CE B7 02  1021          DEC  IN:LGTH    
B892: 20 97 B8  1022 LIS:55   JSR  DISPLAY    
B895: 18        1023          CLC             
B896: 60        1024          RTS             
                1025 *
                1026 DISPLAY  EQU  *          
                1027 * PRINT LINE
B897: A0 00     1028          LDY  #0         
                1029 DIS:5    EQU  *          
                1030 * 
B899: 20 E1 FF  1031          JSR  STOP       
B89C: F0 20     1032          BEQ  DIS:RTS    
                1033 DIS:5:OK EQU  *          
B89E: B1 4E     1034          LDA  (FROM),Y   
B8A0: F0 0E     1035          BEQ  DIS:WRAP   
B8A2: A5 03     1036          LDA  LINE:NO+1  
B8A4: CD C1 02  1037          CMP  TO:LINE+1  
B8A7: 90 16     1038          BLT  DIS:15     
B8A9: A5 02     1039          LDA  LINE:NO    
B8AB: CD C0 02  1040          CMP  TO:LINE    
B8AE: 90 0F     1041          BLT  DIS:15     
                1042 DIS:WRAP EQU  *          
B8B0: AD BE 02  1043          LDA  ED:COM     
B8B3: C9 52     1044          CMP  #'R'       
B8B5: F0 04     1045          BEQ  DIS:WR1    
B8B7: C9 46     1046          CMP  #'F'       
B8B9: D0 03     1047          BNE  DIS:RTS    
B8BB: 4C DE B9  1048 DIS:WR1  JMP  FND:END    
                1049 DIS:RTS  EQU  *          
B8BE: 60        1050          RTS             
                1051 *
                1052 * 
                1053 DIS:15   EQU  *          
B8BF: AD BE 02  1054          LDA  ED:COM     
B8C2: C9 52     1055          CMP  #'R'       
B8C4: F0 07     1056          BEQ  DIS:0      ; REPLACE
B8C6: C9 46     1057          CMP  #'F'       
B8C8: F0 03     1058          BEQ  DIS:0      ; YES
B8CA: 4C B5 B9  1059          JMP  DIS:4      ; NOT FIND
                1060 DIS:0    EQU  *          
B8CD: A0 00     1061          LDY  #0         
B8CF: 8C F3 02  1062          STY  FND:FLG    ; NOTHING FOUND YET ON THIS LINE
B8D2: 8C C4 02  1063 DIS:0A   STY  FND:POS    
                1064 DIS:1    EQU  *          ; HERE FOR EACH CHAR
B8D5: AC C4 02  1065          LDY  FND:POS    
B8D8: AE C2 02  1066          LDX  FND:FROM   
                1067 DIS:2    EQU  *          ; INNER LOOP
B8DB: EC C3 02  1068          CPX  FND:TO     
B8DE: F0 40     1069          BEQ  DIS:35     ; END OF STRING - FOUND IT !!!
B8E0: B1 4E     1070          LDA  (FROM),Y   ; CHAR FROM FILE 
B8E2: C9 0D     1071          CMP  #CR        ; END OF LINE? 
B8E4: D0 16     1072          BNE  DIS:2A     ; NO
B8E6: AD BE 02  1073          LDA  ED:COM     
B8E9: C9 46     1074          CMP  #'F'       
B8EB: F0 04     1075          BEQ  DIS:2C     
B8ED: C9 52     1076          CMP  #'R'       
B8EF: D0 08     1077          BNE  DIS:16J    
B8F1: AD F3 02  1078 DIS:2C   LDA  FND:FLG    
B8F4: F0 03     1079          BEQ  DIS:16J    ; NOTHING REPLACED ON THIS LINE
B8F6: 4C AD B9  1080          JMP  DIS:80     ; DISPLAY IT
                1081 DIS:16J  EQU  *          
B8F9: 4C CA B9  1082          JMP  DIS:16     ; YES - DON'T DISPLAY
                1083 DIS:2A   EQU  *          
                1084 *
                1085 * TRANSLATE TO UPPER CASE IF REQUESTED
                1086 *
B8FC: 2C F6 02  1087          BIT  TRN:FLAG   
B8FF: 50 0A     1088          BVC  DIS:2AB    ; nope
B901: C9 C1     1089          CMP  #$C1       
B903: 90 06     1090          BLT  DIS:2AB    
B905: C9 DB     1091          CMP  #$DB       
B907: B0 02     1092          BGE  DIS:2AB    
B909: 29 7F     1093          AND  #$7F       
                1094 DIS:2AB  EQU  *          
B90B: DD 3C 03  1095          CMP  INBUF,X    
B90E: D0 04     1096          BNE  DIS:3      ; NO MATCH
B910: C8        1097          INY             
B911: E8        1098          INX             
B912: D0 C7     1099          BNE  DIS:2      ; MORE IN STRING
B914: EE C4 02  1100 DIS:3    INC  FND:POS    
B917: C9 10     1101          CMP  #$10       ; DLE?
B919: D0 BA     1102          BNE  DIS:1      ; no - OK to process next char
B91B: EE C4 02  1103          INC  FND:POS    ; bypass space count
                1104 * confused with CONST )
B91E: D0 B5     1105          BNE  DIS:1      ; process next char in line
                1106 * 
                1107 DIS:35   EQU  *          ; COUNT FOUND
B920: EE BC 02  1108          INC  NUM:LINS   
B923: D0 03     1109          BNE  DIS:35A    
B925: EE BD 02  1110          INC  NUM:LINS+1 
B928: AD BE 02  1111 DIS:35A  LDA  ED:COM     
B92B: 8D F3 02  1112          STA  FND:FLG    ; MARK FOUND
B92E: C9 52     1113          CMP  #'R'       ; REPLACE?
B930: D0 1D     1114          BNE  DIS:70     ; NO
B932: AD B5 02  1115          LDA  REP:LEN    ; NEW STRING SAME LENGTH?
B935: D0 28     1116          BNE  DIS:40     ; NOPE - HARD ONE
B937: AC C4 02  1117 DIS:36A  LDY  FND:POS    
B93A: AE B3 02  1118          LDX  REP:FROM   ; MOVE FROM HERE
B93D: A9 00     1119          LDA  #0         
B93F: 85 53     1120          STA  VAL:CMP    ; COMPILE NO LONGER VALID
                1121 DIS:36   EQU  *          
B941: EC B4 02  1122          CPX  REP:TO     ; END OF NEW STRING?
B944: F0 09     1123          BEQ  DIS:70     ; YES
B946: BD 3C 03  1124          LDA  INBUF,X    
B949: 91 4E     1125          STA  (FROM),Y   
B94B: C8        1126          INY             
B94C: E8        1127          INX             
B94D: D0 F2     1128          BNE  DIS:36     ; BACK FOR MORE
                1129 *
                1130 DIS:70   EQU  *          
B94F: AD F7 02  1131          LDA  GLB:FLAG   ; DO ALL ON LINE?
B952: F0 59     1132          BEQ  DIS:80     ; NO - FINISHED THEN
B954: AD C4 02  1133          LDA  FND:POS    ; POINT TO END OF NEW STRING
B957: 18        1134          CLC             
B958: 6D F0 02  1135          ADC  REP:SIZE   
B95B: A8        1136          TAY             
B95C: 4C D2 B8  1137          JMP  DIS:0A     ; BACK FOR ANOTHER GO
                1138 *
                1139 *
                1140 DIS:40   EQU  *          ; NEW STRING DIFFERENT LENGTH
B95F: 30 1C     1141          BMI  DIS:60     ; NEW SMALLER THAN OLD
                1142 *
                1143 * HERE IF NEW BIGGER THAN OLD
                1144 *
B961: 18        1145          CLC             
B962: A5 4E     1146          LDA  FROM       ; CALC: ADDRESS OF NEW TEXT
B964: 48        1147          PHA             
B965: 6D C4 02  1148          ADC  FND:POS    
B968: 85 26     1149          STA  PNTR       
B96A: A5 4F     1150          LDA  FROM+1     
B96C: 48        1151          PHA             
B96D: 69 00     1152          ADC  #0         
B96F: 85 27     1153          STA  PNTR+1     
B971: 20 3E B5  1154          JSR  INST:TXT   ; MAKE ROOM
                1155 DIS:45   EQU  *          
B974: 68        1156          PLA             
B975: 85 4F     1157          STA  FROM+1     
B977: 68        1158          PLA             
B978: 85 4E     1159          STA  FROM       
B97A: 4C 37 B9  1160          JMP  DIS:36A    ; NOW MOVE IN NEW STRING
                1161 *
                1162 DIS:60   EQU  *          ; NEW SMALLER THAN OLD
B97D: A5 4E     1163          LDA  FROM       
B97F: 48        1164          PHA             
B980: 18        1165          CLC             
B981: AD C4 02  1166          LDA  FND:POS    
B984: 6D F4 02  1167          ADC  FND:LEN    
B987: 65 4E     1168          ADC  FROM       
B989: 85 45     1169          STA  TO         
B98B: 85 43     1170          STA  EPNTR      ; (FOR FIND LENGTH)
B98D: A5 4F     1171          LDA  FROM+1     
B98F: 48        1172          PHA             
B990: 69 00     1173          ADC  #0         
B992: 85 46     1174          STA  TO+1       
B994: 85 44     1175          STA  EPNTR+1    
B996: 20 0B B6  1176          JSR  FIND:END   ; FIND LENGTH OF FILE
B999: 18        1177          CLC             
B99A: A5 45     1178          LDA  TO         
B99C: 6D B5 02  1179          ADC  REP:LEN    ; (WHICH IS NEGATIVE)
B99F: 85 4E     1180          STA  FROM       
B9A1: A5 46     1181          LDA  TO+1       
B9A3: 69 FF     1182          ADC  #$FF       
B9A5: 85 4F     1183          STA  FROM+1     
B9A7: 20 32 B6  1184          JSR  MV:TXT:L   ; SHIFT TEXT LEFT
B9AA: 4C 74 B9  1185          JMP  DIS:45     ; NOW TO MOVE IN NEW TEXT
                1186 *
                1187 *
                1188 DIS:80   EQU  *          
B9AD: AD F2 02  1189          LDA  Q:FLAG     
B9B0: F0 03     1190          BEQ  DIS:4      
B9B2: 4C CA B9  1191          JMP  DIS:16     ; NO DISPLAY - 'QUIET' MODE
                1192 *
                1193 *
                1194 DIS:4    EQU  *          
B9B5: 20 1B BA  1195          JSR  PT:LN:NO   
B9B8: A9 40     1196          LDA  #$40       ; Expand reserved words but not others (not upper case)
B9BA: 85 49     1197          STA  RUNNING    
B9BC: A5 4E     1198          LDA  FROM       
B9BE: A6 4F     1199          LDX  FROM+1     
B9C0: 20 5E 80  1200          JSR  PL         
B9C3: A9 80     1201          LDA  #$80       
B9C5: 85 49     1202          STA  RUNNING    ; back to normal
B9C7: 4C D0 B9  1203          JMP  DIS:17     
B9CA: E6 02     1204 DIS:16   INC  LINE:NO    
B9CC: D0 02     1205          BNE  DIS:17     
B9CE: E6 03     1206          INC  LINE:NO+1  
                1207 *
                1208 * GET POSN NEXT LINE
B9D0: A0 00     1209 DIS:17   LDY  #0         
                1210 DIS:20   EQU  *          
B9D2: B1 4E     1211          LDA  (FROM),Y   
B9D4: 20 38 BC  1212          JSR  INC:FROM   
B9D7: C9 0D     1213          CMP  #CR        
B9D9: D0 F7     1214          BNE  DIS:20     
B9DB: 4C 97 B8  1215          JMP  DISPLAY    
                1216 *
                1217 * 
                1218 FND:END  EQU  *          
B9DE: 20 6D 80  1219          JSR  CROUT      
B9E1: 20 62 B7  1220          JSR  PUT:NO     
B9E4: AD BE 02  1221          LDA  ED:COM     
B9E7: C9 46     1222          CMP  #'F'       
B9E9: F0 18     1223          BEQ  FND:END2   
B9EB: A9 0A     1224          LDA  #RPLCD     
B9ED: A2 BA     1225          LDX  #>RPLCD    
B9EF: 20 5E 80  1226          JSR  PL         
B9F2: AD BC 02  1227          LDA  NUM:LINS   
B9F5: 0D BD 02  1228          ORA  NUM:LINS+1 
B9F8: F0 08     1229          BEQ  FND:RTS    ; no need if nothing done
B9FA: AD FE 02  1230          LDA  QT:SIZE    ; new string contain spaces?
B9FD: F0 03     1231          BEQ  FND:RTS    ; no - no Tidy needed
B9FF: 20 23 BB  1232          JSR  TIDY       ; clean up what we've done
BA02: 60        1233 FND:RTS  RTS             
                1234 *
                1235 FND:END2 EQU  *          
BA03: A9 14     1236          LDA  #FND       
BA05: A2 BA     1237          LDX  #>FND      
BA07: 4C 5E 80  1238          JMP  PL         
                1239 *
BA0A: 20 52 45  1240 RPLCD    ASC  ' REPLACED',0D 
BA0D: 50 4C 41 43 45 44 0D 
BA14: 20 46 4F  1241 FND      ASC  ' FOUND',0D 
BA17: 55 4E 44 0D 
                1242 * 
                1243 PT:LN:NO EQU  *          
                1244 *
BA1B: E6 02     1245          INC  LINE:NO    
BA1D: D0 02     1246          BNE  PT:LN:10   
BA1F: E6 03     1247          INC  LINE:NO+1  
                1248 PT:LN:10 EQU  *          
BA21: AD F1 02  1249          LDA  NLN:FLAG   ; LINE NUMBERS?
BA24: D0 3E     1250          BNE  DIS:4A     ; NOPE
BA26: A5 02     1251 PUT:LINE LDA  LINE:NO    ; entry here from compiler
BA28: 85 04     1252          STA  REG        
BA2A: A6 03     1253          LDX  LINE:NO+1  
BA2C: 86 05     1254          STX  REG+1      
BA2E: A0 00     1255          LDY  #0         
BA30: 84 58     1256          STY  REGB       
BA32: E0 03     1257          CPX  #>1000     
BA34: 90 06     1258          BLT  LT:1000    
BA36: D0 13     1259          BNE  PT:GO      
BA38: C9 E8     1260          CMP  #1000      
BA3A: B0 0F     1261          BGE  PT:GO      
BA3C: C8        1262 LT:1000  INY             
BA3D: E0 00     1263          CPX  #0         
BA3F: D0 0A     1264          BNE  PT:GO      
BA41: C9 64     1265          CMP  #100       
BA43: B0 06     1266          BGE  PT:GO      
BA45: C8        1267          INY             
BA46: C9 0A     1268          CMP  #10        
BA48: B0 01     1269          BGE  PT:GO      
BA4A: C8        1270          INY             
BA4B: 98        1271 PT:GO    TYA             
BA4C: F0 09     1272          BEQ  PT:FIN     
BA4E: 48        1273          PHA             
BA4F: 20 67 80  1274          JSR  PUTSP      
BA52: 68        1275          PLA             
BA53: A8        1276          TAY             
BA54: 88        1277          DEY             
BA55: D0 F4     1278          BNE  PT:GO      
                1279 PT:FIN   EQU  *          
BA57: 20 34 99  1280          JSR  DSP:BIN    
BA5A: 4C 67 80  1281          JMP  PUTSP      
                1282 *
                1283 *
                1284 *
                1285 GETRANGE EQU  *          
                     ************************************************
                1287 * GET 1ST NO
BA5D: A0 00     1288          LDY  #0         
BA5F: 20 8F B5  1289          JSR  GET:NO     
BA62: 90 01     1290          BCC  GETR:5     
BA64: 60        1291 DIS:4A   RTS             
                1292 GETR:5   EQU  *          
BA65: A5 1E     1293          LDA  VALUE      
BA67: 85 4E     1294          STA  FROM       
BA69: D0 04     1295          BNE  GETR:10    
BA6B: A5 1F     1296          LDA  VALUE+1    
BA6D: F0 47     1297          BEQ  GETR:30    
                1298 GETR:10  EQU  *          
BA6F: A5 1F     1299          LDA  VALUE+1    
BA71: 85 4F     1300          STA  FROM+1     
                1301 * GET 2ND NO 
BA73: A4 26     1302          LDY  PNTR       
                1303 GETR:15  EQU  *          
BA75: C8        1304          INY             
BA76: CC B7 02  1305          CPY  IN:LGTH    
BA79: F0 08     1306          BEQ  GETR:16    
BA7B: B9 3C 03  1307          LDA  INBUF,Y    
BA7E: CD 0F 80  1308          CMP  DELIMIT    
BA81: D0 0A     1309          BNE  GETR:20    
BA83: A5 4E     1310 GETR:16  LDA  FROM       
BA85: 85 45     1311          STA  TO         
BA87: A5 4F     1312          LDA  FROM+1     
BA89: 85 46     1313          STA  TO+1       
BA8B: 18        1314          CLC             
BA8C: 60        1315          RTS             
                1316 GETR:20  EQU  *          
BA8D: B9 3C 03  1317          LDA  INBUF,Y    
BA90: C9 30     1318          CMP  #'0'       
BA92: 90 07     1319          BLT  GETR:22    
BA94: C9 3A     1320          CMP  #'9'+1     
BA96: B0 03     1321          BGE  GETR:22    
BA98: 4C 75 BA  1322          JMP  GETR:15    
                1323 GETR:22  EQU  *          
BA9B: 20 8F B5  1324          JSR  GET:NO     
BA9E: 90 01     1325          BCC  GETR:25    
BAA0: 60        1326          RTS             
                1327 GETR:25  EQU  *          
BAA1: A5 1E     1328          LDA  VALUE      
BAA3: 85 45     1329          STA  TO         
BAA5: A5 1F     1330          LDA  VALUE+1    
BAA7: 85 46     1331          STA  TO+1       
                1332 * CHECK RANGE 
BAA9: A5 45     1333          LDA  TO         
BAAB: 38        1334          SEC             
BAAC: E5 4E     1335          SBC  FROM       
BAAE: A5 46     1336          LDA  TO+1       
BAB0: E5 4F     1337          SBC  FROM+1     
BAB2: 30 02     1338          BMI  GETR:30    
BAB4: 18        1339          CLC             
BAB5: 60        1340          RTS             
                1341 GETR:30  EQU  *          
BAB6: A9 AE     1342          LDA  #DEL:ERR1  
BAB8: A2 B3     1343          LDX  #>DEL:ERR1 
BABA: 20 5E 80  1344 GETR:31  JSR  PL         
BABD: 38        1345          SEC             
BABE: 60        1346          RTS             
                1347 *
                1348 TO:ADDR  EQU  *          
                     ************************************************
BABF: A5 45     1350          LDA  TO         
BAC1: 85 1E     1351          STA  VALUE      
BAC3: A5 46     1352          LDA  TO+1       
BAC5: 85 1F     1353          STA  VALUE+1    
BAC7: 20 CE B5  1354          JSR  FIND:LN    
BACA: A5 26     1355          LDA  PNTR       
BACC: 85 45     1356          STA  TO         
BACE: A5 27     1357          LDA  PNTR+1     
BAD0: 85 46     1358          STA  TO+1       
BAD2: 60        1359          RTS             
                1360 *
                1361 FRM:ADDR EQU  *          
                     ************************************************
BAD3: A5 4E     1363          LDA  FROM       
BAD5: 85 1E     1364          STA  VALUE      
BAD7: A5 4F     1365          LDA  FROM+1     
BAD9: 85 1F     1366          STA  VALUE+1    
BADB: 20 CE B5  1367          JSR  FIND:LN    
BADE: A5 26     1368          LDA  PNTR       
BAE0: 85 4E     1369          STA  FROM       
BAE2: A5 27     1370          LDA  PNTR+1     
BAE4: 85 4F     1371          STA  FROM+1     
BAE6: 60        1372          RTS             
                1373 *
                1374 *
                1375 * TIDY UP SOURCE FILE
                1376 *
                1377 * here to convert alphas to reserved words if possible
                1378 *
                1379 TIDY:AL  EQU  *          
BAE7: A6 43     1380          LDX  EPNTR      ; in quotes?
BAE9: D0 7C     1381          BNE  TIDY:CH    ; yes - ignore
BAEB: A6 4E     1382          LDX  FROM       
BAED: 86 1C     1383          STX  NXTCHR     ; start of word 
BAEF: A6 4F     1384          LDX  FROM+1     
BAF1: 86 1D     1385          STX  NXTCHR+1   
BAF3: 20 61 80  1386          JSR  TOKEN1     
BAF6: C6 19     1387          DEC  TKNLEN     
BAF8: A0 00     1388          LDY  #0         
BAFA: C9 49     1389          CMP  #'I'       ; identifier?
BAFC: D0 09     1390          BNE  TIDY:RS    ; no - must be reserved
                1391 *
                1392 * get original letter back
                1393 *
BAFE: A6 19     1394          LDX  TKNLEN     
BB00: 8E FE 02  1395          STX  QT:SIZE    ; ignore next (n - 1) letters
BB03: B1 4E     1396          LDA  (FROM),Y   
BB05: D0 60     1397          BNE  TIDY:CH    ; just copy it
                1398 *
                1399 TIDY:RS  EQU  *          ; reserved word
BB07: A5 19     1400          LDA  TKNLEN     
BB09: 18        1401          CLC             
BB0A: 65 4E     1402          ADC  FROM       
BB0C: 85 4E     1403          STA  FROM       ; add length of (token - 1)
BB0E: 90 02     1404          BCC  TIDY:RS1   
BB10: E6 4F     1405          INC  FROM+1     
                1406 TIDY:RS1 EQU  *          ; bypass whole word in source
BB12: C8        1407          INY             
BB13: B1 4E     1408          LDA  (FROM),Y   ; followed by space?
BB15: 29 7F     1409          AND  #$7F       
BB17: C9 20     1410          CMP  #'         '
BB19: D0 03     1411          BNE  TIDY:RS2   ; no
BB1B: 20 38 BC  1412          JSR  INC:FROM   ; yes - ignore space
                1413 TIDY:RS2 EQU  *          
BB1E: A5 16     1414          LDA  TOKEN      
BB20: 88        1415          DEY             ; y is now zero again
BB21: F0 44     1416          BEQ  TIDY:CH    ; use our new token
                1417 *
                1418 *
                1419 TIDY     EQU  *          
BB23: AD 09 80  1420          LDA  TS         
BB26: AE 0A 80  1421          LDX  TS+1       
                1422 *
                1423 TIDY:ENT EQU  *          
BB29: 85 4E     1424          STA  FROM       
BB2B: 85 45     1425          STA  TO         
BB2D: 85 06     1426          STA  REG2       
BB2F: 86 4F     1427          STX  FROM+1     
BB31: 86 46     1428          STX  TO+1       
BB33: 86 07     1429          STX  REG2+1     
BB35: A9 00     1430          LDA  #0         
BB37: 8D FE 02  1431          STA  QT:SIZE    ; ALPHA BYPASS SIZE
BB3A: 85 43     1432          STA  EPNTR      ; QUOTE FLAG
                1433 *
                1434 TIDY:NXT EQU  *          
BB3C: A0 00     1435          LDY  #0         
BB3E: B1 4E     1436          LDA  (FROM),Y   
BB40: F0 55     1437          BEQ  TIDY:END   
BB42: AE FE 02  1438          LDX  QT:SIZE    ; bypassing a non-reserved word?
BB45: F0 06     1439          BEQ  TIDY:NX1   ; no
BB47: CA        1440          DEX             ; one less to worry about 
BB48: 8E FE 02  1441          STX  QT:SIZE    
BB4B: 10 1A     1442          BPL  TIDY:CH    ; still in middle - just copy character
                1443 TIDY:NX1 EQU  *          
BB4D: C9 0D     1444          CMP  #$0D       ; CARRIAGE RETURN
BB4F: F0 2C     1445          BEQ  TIDY:CR    
BB51: CD 0E 80  1446          CMP  QUOT:SYM   
BB54: F0 1F     1447          BEQ  TIDY:QT    
BB56: C9 20     1448          CMP  #'         ' ; SPACE?
BB58: F0 18     1449          BEQ  TIDY:SPJ   ; YES
BB5A: C9 A0     1450          CMP  #"         " ; SHIFT/SPACE
BB5C: F0 14     1451          BEQ  TIDY:SPJ   
BB5E: C9 10     1452          CMP  #$10       ; DLE? 
BB60: F0 4F     1453          BEQ  TIDY:DLE   
BB62: 20 1F 80  1454          JSR  ISITAL     ; alpha?
BB65: 90 80     1455          BCC  TIDY:AL    ; yes
                1456 *
                1457 * COPY CHARACTER
                1458 *
BB67: 91 45     1459 TIDY:CH  STA  (TO),Y     
BB69: 20 3F BC  1460          JSR  INC:TO     
BB6C: 20 38 BC  1461 TIDY:LF  JSR  INC:FROM   
BB6F: 4C 3C BB  1462          JMP  TIDY:NXT   
                1463 *
BB72: 4C E6 BB  1464 TIDY:SPJ JMP  TIDY:SP    
                1465 *
                1466 *
                1467 TIDY:QT  EQU  *          
BB75: 48        1468          PHA             
BB76: 45 43     1469          EOR  EPNTR      ; FLIP FLAG
BB78: 85 43     1470          STA  EPNTR      
BB7A: 68        1471          PLA             
BB7B: D0 EA     1472          BNE  TIDY:CH    ; STORE IT
                1473 *
                1474 TIDY:CR  EQU  *          
BB7D: 84 43     1475          STY  EPNTR      ; CLEAR QUOTE FLAG
BB7F: 8C FE 02  1476          STY  QT:SIZE    ; AND ALPHA BYPASS COUNT
BB82: 20 5E BC  1477          JSR  CMP:END    ; AT START OF FILE?
BB85: F0 0C     1478          BEQ  TIDY:NSP   ; YES - OFF WE GO
                1479 *
                1480 * DROP TRAILING SPACES
                1481 *
                1482 TIDY:OK  EQU  *          
BB87: 20 46 BC  1483          JSR  DEC:TO     
BB8A: 29 7F     1484          AND  #$7F       
BB8C: C9 20     1485          CMP  #'         '
BB8E: F0 ED     1486          BEQ  TIDY:CR    
                1487 *
BB90: 20 3F BC  1488          JSR  INC:TO     ; BACK TO LAST SPACE
                1489 TIDY:NSP EQU  *          ; END OF FILE/SPACES
BB93: A9 0D     1490          LDA  #$0D       
BB95: D0 D0     1491          BNE  TIDY:CH    
                1492 *
                1493 TIDY:END EQU  *          
BB97: 20 5E BC  1494          JSR  CMP:END    
BB9A: F0 11     1495          BEQ  TIDY:E2    ; AT START OF FILE
BB9C: 20 46 BC  1496          JSR  DEC:TO     ; C/R BEFORE END?
BB9F: 20 3F BC  1497          JSR  INC:TO     
BBA2: C9 0D     1498          CMP  #$0D       
BBA4: F0 07     1499          BEQ  TIDY:E2    ; YES
BBA6: A9 0D     1500          LDA  #$0D       ; NO - PUT ONE THERE
BBA8: 91 45     1501          STA  (TO),Y     
BBAA: 20 3F BC  1502          JSR  INC:TO     
                1503 TIDY:E2  EQU  *          
BBAD: 98        1504          TYA             
BBAE: 91 45     1505          STA  (TO),Y     
BBB0: 60        1506          RTS             
                1507 *
                1508 *
                1509 TIDY:DLE EQU  *          
BBB1: 91 45     1510          STA  (TO),Y     ; COPY 2 CHARS REGARDLESS
BBB3: 20 3F BC  1511          JSR  INC:TO     
BBB6: 20 38 BC  1512          JSR  INC:FROM   
BBB9: B1 4E     1513          LDA  (FROM),Y   
BBBB: AA        1514          TAX             ; save temporarily
BBBC: C8        1515          INY             
BBBD: B1 4E     1516          LDA  (FROM),Y   ; another DLE? 
BBBF: C9 10     1517          CMP  #$10       
BBC1: F0 10     1518          BEQ  TIDY:DL2   ; yes
BBC3: 29 7F     1519          AND  #$7F       
BBC5: C9 20     1520          CMP  #'         ' ; followed by a solitary space?
BBC7: D0 04     1521          BNE  TIDY:DL3   ; no
BBC9: E8        1522          INX             ; yes - add 1 to space count
BBCA: 20 38 BC  1523          JSR  INC:FROM   ; and bypass the space
BBCD: 8A        1524 TIDY:DL3 TXA             ; back to space count
BBCE: A0 00     1525          LDY  #0         
BBD0: 4C 67 BB  1526          JMP  TIDY:CH    
                1527 *
                1528 * here for 2 DLE's in a row
                1529 *
                1530 TIDY:DL2 EQU  *          
BBD3: C8        1531          INY             
BBD4: B1 4E     1532          LDA  (FROM),Y   ; second space count
BBD6: 29 7F     1533          AND  #$7F       ; strip 8 bit
BBD8: A0 00     1534          LDY  #0         
BBDA: 18        1535          CLC             
BBDB: 71 4E     1536          ADC  (FROM),Y   ; add to first space count
BBDD: AA        1537          TAX             ; save in X
BBDE: 20 38 BC  1538          JSR  INC:FROM   ; now bypass 2nd. DLE and its count
BBE1: 20 38 BC  1539          JSR  INC:FROM   
BBE4: D0 E7     1540          BNE  TIDY:DL3   ; now copy over our new count
                1541 *
                1542 *
                1543 TIDY:SP  EQU  *          
BBE6: A5 43     1544          LDA  EPNTR      
BBE8: D0 0E     1545          BNE  TIDY:GQT   ; GOT QUOTE
BBEA: C8        1546          INY             
BBEB: B1 4E     1547          LDA  (FROM),Y   ; 2 SPACES IN ROW?
BBED: C9 10     1548          CMP  #$10       ; space followed by DLE?
BBEF: F0 0C     1549          BEQ  TIDY:BMP   ; yes - add 1 to DLE count
BBF1: 29 7F     1550          AND  #$7F       
BBF3: C9 20     1551          CMP  #'         '
BBF5: F0 10     1552          BEQ  TIDY:SPC   ; YES
BBF7: 88        1553          DEY             ; NO
                1554 TIDY:GQT EQU  *          
BBF8: A9 20     1555          LDA  #'         '
BBFA: 4C 67 BB  1556          JMP  TIDY:CH    
                1557 *
                1558 * here for a single space followed by a DLE and a space count
                1559 * - just add 1 to the space count following and ignore the
                1560 * current space
                1561 *
                1562 TIDY:BMP EQU  *          
BBFD: 98        1563          TYA             ; Y contains 1
BBFE: 18        1564          CLC             
BBFF: C8        1565          INY             ; now at space count
BC00: 71 4E     1566          ADC  (FROM),Y   
BC02: 91 4E     1567          STA  (FROM),Y   
BC04: 4C 6C BB  1568          JMP  TIDY:LF    
                1569 *
                1570 *
                1571 TIDY:SPC EQU  *          ; OUTPUT DLE
BC07: 88        1572          DEY             
BC08: A9 10     1573          LDA  #$10       
BC0A: 91 45     1574          STA  (TO),Y     
BC0C: 20 3F BC  1575          JSR  INC:TO     
BC0F: A2 01     1576          LDX  #1         ; SPACE COUNT
                1577 TIDY:CNT EQU  *          
BC11: 20 38 BC  1578          JSR  INC:FROM   
BC14: B1 4E     1579          LDA  (FROM),Y   
BC16: 29 7F     1580          AND  #$7F       
BC18: C9 20     1581          CMP  #'         ' ; ANOTHER?
BC1A: D0 03     1582          BNE  TIDY:DNE   ; NOPE
BC1C: E8        1583          INX             
BC1D: D0 F2     1584          BNE  TIDY:CNT   
                1585 *
                1586 TIDY:DNE EQU  *          
BC1F: C9 0D     1587          CMP  #$0D       ; END OF LINE?
BC21: F0 0F     1588          BEQ  TIDY:IGN   ; YES - IGNORE THEM
BC23: C9 0A     1589          CMP  #$0A       ; SAME
BC25: F0 0B     1590          BEQ  TIDY:IGN   
BC27: 8A        1591          TXA             ; SPACE COUNT
BC28: 09 80     1592          ORA  #$80       ; SET BIT TO STOP CONFUSION WITH C/R
BC2A: 91 45     1593          STA  (TO),Y     
BC2C: 20 3F BC  1594          JSR  INC:TO     
BC2F: 4C 3C BB  1595          JMP  TIDY:NXT   ; PROCESS CURRENT CHAR
                1596 *
                1597 TIDY:IGN EQU  *          
BC32: 20 46 BC  1598          JSR  DEC:TO     ; FORGET DLE
BC35: 4C 3C BB  1599          JMP  TIDY:NXT   ; PROCESS CHAR
                1600 *
                1601 *
                1602 INC:FROM EQU  *          
BC38: E6 4E     1603          INC  FROM       
BC3A: D0 02     1604          BNE  RTS1       
BC3C: E6 4F     1605          INC  FROM+1     
BC3E: 60        1606 RTS1     RTS             
                1607 *
                1608 INC:TO   EQU  *          
BC3F: E6 45     1609          INC  TO         
BC41: D0 FB     1610          BNE  RTS1       
BC43: E6 46     1611          INC  TO+1       
BC45: 60        1612          RTS             
                1613 *
                1614 DEC:TO   EQU  *          
BC46: C6 45     1615          DEC  TO         
BC48: A5 45     1616          LDA  TO         
BC4A: C9 FF     1617          CMP  #$FF       
BC4C: D0 02     1618          BNE  DEC:TO:9   
BC4E: C6 46     1619          DEC  TO+1       
                1620 DEC:TO:9 EQU  *          
BC50: B1 45     1621          LDA  (TO),Y     ; SAVE TROUBLE LATER
BC52: 60        1622          RTS             
                1623 *
                1624 DEC:FROM EQU  *          
BC53: C6 4E     1625          DEC  FROM       
BC55: A5 4E     1626          LDA  FROM       
BC57: C9 FF     1627          CMP  #$FF       
BC59: D0 E3     1628          BNE  RTS1       
BC5B: C6 4F     1629          DEC  FROM+1     
BC5D: 60        1630          RTS             
                1631 *
                1632 CMP:END  EQU  *          
BC5E: A5 45     1633          LDA  TO         
BC60: C5 06     1634          CMP  REG2       
BC62: D0 04     1635          BNE  CMP:END9   
BC64: A5 46     1636          LDA  TO+1       
BC66: C5 07     1637          CMP  REG2+1     
BC68: 60        1638 CMP:END9 RTS             
                1639 *
                1640 *
                1641 WRAP     EQU  *          
BC69: AD 3D 03  1642          LDA  INBUF+1    
BC6C: C9 46     1643          CMP  #'F'       
BC6E: D0 03     1644          BNE  GET7:A     
BC70: 4C 43 99  1645          JMP  ST:FIL     ; QF = GO TO FILES MENU
                1646 GET7:A   EQU  *          ; ORDINARY QUIT
BC73: 4C 31 99  1647          JMP  RESTART    
                1648 *
                1649 * 
                1650 *
                1651 GETLNZ   EQU  *          
                1652 GETLN    EQU  *          
                1653 GETLN1   EQU  *          
BC76: A0 00     1654          LDY  #0         
BC78: A6 99     1655          LDX  DFLTN      ; input from keyboard (screen)? 
BC7A: D0 15     1656          BNE  GET1       ; no - bypass fancy stuff (screws up disk)
                1657 *
                1658 * the code below ensures that we accept data from the
                1659 * column that the prompt ended, even if we change lines
                1660 *
BC7C: 20 CF FF  1661          JSR  CHRIN      ; trigger read of line
BC7F: A5 CA     1662          LDA  LXSP+1     ; old column
BC81: 85 D3     1663          STA  CH         ; make new column
BC83: C5 C8     1664          CMP  INDX       ; past logical end of line?
BC85: 90 06     1665          BLT  GET4       ; no - is OK
BC87: 84 D0     1666          STY  CRSW       ; indicate line finished 
BC89: A9 0D     1667          LDA  #$0D       ; dummy up a c/r
BC8B: D0 12     1668          BNE  GET:3      
BC8D: A9 01     1669 GET4     LDA  #1         ; make sure we keep reading line
BC8F: 85 D0     1670          STA  CRSW       
BC91: 20 CF FF  1671 GET1     JSR  CHRIN      
BC94: 99 3C 03  1672          STA  INBUF,Y    ; SAVE IN BUFFER 
BC97: C8        1673          INY             
BC98: 29 7F     1674          AND  #$7F       ; c/r may have 8-bit set
BC9A: C9 0D     1675          CMP  #$0D       ; END OF LINE? 
BC9C: D0 F3     1676          BNE  GET1       ; NOPE
BC9E: 88        1677          DEY             
BC9F: 99 3C 03  1678 GET:3    STA  INBUF,Y    ; proper c/r
BCA2: C8        1679          INY             
BCA3: A9 00     1680          LDA  #0         
BCA5: 99 3C 03  1681          STA  INBUF,Y    ; zero after line for Tidy processing
BCA8: 88        1682          DEY             
BCA9: 98        1683          TYA             
BCAA: 48        1684          PHA             
BCAB: 20 6D 80  1685          JSR  CROUT      
BCAE: 68        1686          PLA             
BCAF: AA        1687          TAX             ; PUT INTO X
BCB0: 60        1688          RTS             ; RETURN
                1689 *
                1690 *
                1691 *
                1692 *
BCB1: 00        1694          BRK             


--End assembly, 2350 bytes, Errors: 0 
