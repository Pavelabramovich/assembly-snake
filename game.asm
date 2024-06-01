data segment 'data'
assume ds:data    

    size              =    16                                                            
    field             db   size*size dup (?)

; Field cell constants:
    
    empty_cell        =    '.'  
                                      
    top_cell          =    '1'        
    right_cell        =    '2'
    bottom_cell       =    '3'
    left_cell         =    '4'
    
    apple_cell        =    'A'


; Variables to store game state:
    
    head              dw   ?             
    tail              dw   ?                
    apple             dw   ?             
    
    rotation          db   ?
    
    delay             dw   ? 

; Color constants:

    black             =    00h
    blue              =    01h
    green             =    02h
    cuan              =    03h
    red               =    04h
    purple            =    05h
    brown             =    06h
    light_gray        =    07h
    dark_gray         =    08h
    light_blue        =    09h
    lime              =    0Ah
    light_cuan        =    0Bh
    light_red         =    0Ch
    crimson           =    0Dh
    yellow            =    0Eh
    white             =    0Fh
       
; Variables to store field elements. Each word in graphics
; memory is interpreted as follows: the first byte is 
; the character, 4 most significant bits of next byte are 
; the background color and the last 4 are the character color.
        
    grass_elem        db   'Ý',lime+green*10h       
    snake_elem        db   'X',brown+yellow*10h      
    
    head_elem_top     db   '"',brown+yellow*10h      
    head_elem_right   db   ';',brown+yellow*10h      
    head_elem_bottom  db   '"',brown+yellow*10h      
    head_elem_left    db   ':',brown+yellow*10h     
    head_elem_blink   db   ' ',brown+yellow*10h      
    
    apple_elem        db   'O',red+light_red*10h 

    blink_counter     db   0

; Key constants:
        
    top_arrow_key     =    048h
    right_arrow_key   =    04Dh
    bottom_arrow_key  =    050h
    left_arrow_key    =    04Bh
    
    space_key         =    039h
       
    enter_key         =    01C0Dh  
    escape_key        =    0011Bh
            
; Variables to store page numbers. First bit
; will be used to store page initialization state.     
                                             
    menu_page         db   00000000b       
    records_page      db   00000001b
    regime_page       db   00000010b              
    game_page         db   00000011b
    game_over_page    db   00000100b          
    game_win_page     db   00000101b 
    exit_page         db   00000110b                

; Choices constants:
    
    play_chc          =    1
    records_chc       =    2 
    
    menu_chc          =    1
    
    game_over_chc     =    1
    win_chc           =    2
    
    play_again_chc    =    1        
    back_to_menu_chc  =    2        
         
    escape_chc        =    255
    
; Variables to process choices:

    choice            db   1 
    choice_ptr        db   '>'
    choice_clear      db   ' '
    
    first_choice_row  =    17
    first_choice_col  =    24     
    
; Variables to records processing. The data in the file 
; should be stored as follows: four bytes are allocated 
; for each regime, they are stored in the file in the order: 
; easy, medium, hard. First byte of each regime is its record. 
; The maximum value is 252 = field_size - start_snake_size. 
; The next three bytes of regime describe the day, month and 
; year in the century (for 2021 it will be 21) in BCD format.

    records_file      db   '../records.txt',0 
    
    record_len        =    4
    regime_count      =    3
    
    rec_buf_len       =    record_len*regime_count
    rec_buf           db   rec_buf_len dup (?)  
    
    
    default_record    =    1    
    
; Variables, that store big words. The first two bytes of big word
; must be length and width, then comes the actual string.

    snake_big_word    db   32,6,
                      db   " ___          ____      __  ___ "
                      db   "| __| |\  /| | __ | |\ / / | __|"
                      db   "||__  | \ || ||__|| ||/ /  ||_  "
                      db   "|__ | ||\\|| | __ | |  (   | _| "
                      db   " __|| || \ | ||  || ||\ \  ||__ "
                      db   "|___| |/  \| |/  \| |/ \_\ |___|"
                       
    game_big_word     db   27,6
                      db   " ____   ____   _ ",' '," _   ___ "
                      db   "| ___| | __ | | \",' ',"/ | | __|"   
                      db   "|| __  ||__|| |  ",'Y',"  | ||_  "    
                      db   "|||_ | | __ | ||\",' ',"/|| | _| "
                      db   "||__|| ||  || || ", 31," || ||__ "              
                      db   "|____| |/  \| |/ ",' '," \| |___|"   
    
    over_big_word     db   27,6
                      db   " ____           ___   ____ "
                      db   "| __ | |\   /| | __| | __ |"
                      db   "||  || ||   || ||_   ||__||"  
                      db   "||  || \\   // | _|  | _ _|"    
                      db   "||__||  \\_//  ||__  || \\ "
                      db   "|____|   \_/   |___| |/  \\"  
    
    regime_big_word   db   37,6
                      db   " ____   ___   ____   _   _ ",' '," _   ___ "
                      db   "| __ | | __| | ___| | | | \",' ',"/ | | __|" 
                      db   "||__|| ||_   || __  | | |  ",'Y',"  | ||_  "  
                      db   "| _ _| | _|  |||_ | | | ||\",' ',"/|| | _| "    
                      db   "|| \\  ||__  ||__|| | | || ", 31," || ||__ "
                      db   "|/  \\ |___| |____| |_| |/ ",' '," \| |___|"  
    
    you_big_word      db   22,6
                      db   "         ____         "
                      db   "|\   /| | __ | |\   /|"
                      db   "\ \ / / ||  || ||   ||"  
                      db   " \   /  ||  || ||   ||"    
                      db   "  | |   ||__|| \\___//"
                      db   "  |_|   |____|  \___/ "
    
    won_big_word      db   26,6
                      db   "              ____        "
                      db   "|\        /| | __ | |\  /|"
                      db   "||        || ||  || | \ ||"  
                      db   "\\   /\   // ||  || ||\\||"    
                      db   " \\_//\\_//  ||__|| || \ |"
                      db   "  \_/  \_/   |____| |/  \|"   
    
    score_big_word    db   32,6  
                      db   " ___   ____   ____   ____   ___ "
                      db   "| __| | ___| | __ | | __ | | __|"
                      db   "||__  ||     ||  || ||__|| ||_  "
                      db   "|__ | ||     ||  || | _ _| | _| "
                      db   " __|| ||___  ||__|| || \\  ||__ "
                      db   "|___| |____| |____| |/  \\ |___|"
    
    list_big_word     db   24,6 
                      db   " _      _   ___   _____ "
                      db   "| |    | | | __| |_   _|" 
                      db   "| |    | | ||__    | |  "  
                      db   "| |    | | |__ |   | |  "    
                      db   "| |__  | |  __||   | |  "
                      db   "|____| |_| |___|   |_|  "  
    
    pause_big_word    db   3,3
                      db   3 dup ("Û Û")    
    
    pause_clear       db   3,3
                      db   3 dup ("   ")

; Variables to score processing: 

    score_mes         db   "Score: "
    score_str         db   "000" 
    score_mes_len     =    10 
    score_str_len     =    3
    score             dw   0
    max_score         =    252
    
; Variables to store choice variants:

    play_str          db   "Play",'$'
    play_again_str    db   "Play again",'$'
    records_str       db   "Records",'$'   
    back_to_menu_str  db   "Back to menu",'$'     
    exit_str          db   "Exit",'$'
        
    easy_str          db   "Easy",'$'        
    medium_str        db   "Medium",'$'        
    hard_str          db   "Hard",'$'

; Variables to process records strings:    
    
    easy_record_str   db   "Easy        XXX    XX.XX.20XX"
    medium_record_str db   "Medium      XXX    XX.XX.20XX"                  
    hard_record_str   db   "Hard        XXX    XX.XX.20XX"
                                    
    rec_str_len       =    29
    
    rec_value_offset  =    12                               
    rec_day_offset    =    19
    rec_monts_offset  =    22
    rec_year_offset   =    27                               

; Variables to store result string:
                                    
    your_res_str      db   "Your result: "
    your_res_str_len  =    13
                             
; Other variables:

    counter           db   0
    
    to_lower_mask     =    00100000b
       
data ends    


code segment 'code'
assume cs:code    
                                                       

start:                call set_start_settings 
                      call set_records
    
menu:                 call load_menu_page 
    
                      cmp  choice,play_chc
                      je   regime
        
                      cmp  choice,records_chc
                      je   records
    
                      jmp  game_exit

records:              call load_records_page
    
                      cmp  choice,menu_chc
                      je   menu
    
                      jmp  game_exit
 
regime:               call load_regime_page
    
                      cmp  choice,escape_chc
                      je   game_exit
        
                      mov  al,choice
                      call set_delay
    
game:                 call load_game_page
    
                      cmp  choice,escape_chc
                      je   game_exit  

game_end:             call load_game_end_page

                      cmp  choice,play_again_chc
                      je   game
        
                      cmp  choice,back_to_menu_chc
                      je   menu
           
game_exit:            jmp  load_exit_page
               

                                                           
;==========================================================
;
; Procedure for initial game setup. Called once at the very 
; beginning of the program.
;
; Entry: No args.
; Returns: No return. 
; Changes: AX,BL,DS,ES.
;
set_start_settings    proc  
                                                       
                      mov  ax,0000h                        ; Set a small screen and clean it.  
                      int  10h                       
                            
                      mov  bl,0
                      
                      mov  ax,1003h                        
                      int  10h                             ; Set bright colors.

                      mov  ax, @data                
                      mov  ds, ax            
                      mov  es, ax
                   
                      ret                   
set_start_settings    endp

                                                          
;==========================================================
;
; Pocedure that saves records from file to rec_buf. If 
; record file does not exists, creates new file with 
; default records.
;
; Entry: No args.
; Returns: No return.
; Changes: AX,BX,CX,DX,counter
;
set_records           proc

                      lea  dx,records_file     
                                                  
                      mov  al,00b                          
                      mov  ah,3Dh
                      int  21h                             ; Open existed file in readonly mode.
                      jc   open_error
                                         
                      mov  bx,ax                           ; BX - file identifier. 

                      mov  cx,rec_buf_len                  
                      lea  dx,rec_buf                     
                    
                      mov  ah,3Fh                          
                      int  21h                             ; Read from file.
                      jc   close_file                      
                     
                      push bx
                      mov  counter,0
                      jmp  set_record_str_loop                    

open_error:           cmp  ax,03h                          ; 02h and 03h - file not found errors.
                      jg   end_of_reading

                      mov  cx,00000000b                    ; Simple file with read-write mode
                      
                      mov  ah,5Bh                             
                      int  21h                             ; Create and open file.
                      jc   end_of_reading
                     
                      mov  bx,ax                           ; BX - new file identifier. 
                      push bx
                     
                      mov  counter,0
     
init_file_loop:       mov  dl,counter                      ; for (counter = 0; counter < 3; counter++) 
                      mov  dh,0                            ; {    
                                                           ;     set_record(regime: counter, value: default_record)
                      mov  al,default_record               ; }
                      call set_record
                     
                      inc  counter 
                      cmp  counter,3
                      jl   init_file_loop   
                                                  
                      mov  counter,0

set_record_str_loop:  mov  bl,counter
                      mov  bh,0                     
                      call set_record_str 
                                   
                      inc  counter
                      cmp  counter,3
                      jl   set_record_str_loop
                     
                      pop  bx
                     
close_file:           mov  ah,3Eh                          
                      int  21h                             ; Close file.

end_of_reading:       ret
set_records           endp
               

;==========================================================
;
; Procedure for set value of some record. File must be 
; opened. 
;
; Entry: BX - file identifier 
;        DX - regime index (easy = 0, medium = 1, hard = 2) 
;        AL - new value
; 
; Returns: No return
; Calls: No calls 
; Changes: AX,BX,CX,DX
; 
set_record            proc

                      push ax
                       
                      mov  cx,0      
                      shl  dx,2                            ; Get index of needed regime.
                       
                      push dx 
                              
                      mov  al,0                            ; Offset from beginning of file. 
                           
                      mov  ah,42h                          
                      int  21h                             ; Move cursor to offset.
                                                 
                      pop  dx
                      pop  ax                
                      jc   id_error 
                                            
                      push bx
                      mov  bx,dx
                        
                      mov  rec_buf[bx],al                  ; Save new record.
                       
                      mov  ah,04h
                      int  1Ah                             ; Get date.
                
                      sub  cx,2000h
                
                      inc  bx
                      mov  rec_buf[bx],dl                  ; Day.
                                                
                      inc  bx
                      mov  rec_buf[bx],dh                  ; Month.
                
                      inc  bx
                      mov  rec_buf[bx],cl                  ; Year.
                                  
                      sub  bx,3                            ; Reset to start of regime record.                          
                                                    
                      lea  dx,rec_buf[bx]                  ; Bufer address.
                      mov  cx,record_len                   ; Count of bytes to write.
                      pop  bx              
                      
                      mov  ah,40h                                                                 
                      int  21h                             ; Write to file.                                   
                                                     
id_error:             ret    
set_record            endp                
               
               
;==========================================================
;
; Procedure to read one record from buffer and save records
; values in record strings.
;
; Entry: BX - regime index (easy = 0, medium = 1, hard = 2) 
; 
; Returns: No return
; Calls: set_score_str,set_date_str 
; Changes: None
;  
set_record_str        proc  
                                          
                      call set_score_str
                      call set_date_str
                                                         
                      ret
set_record_str        endp


;==========================================================
;
; Procedure to set byte record value to string.
;
; Entry: BX - regime index 
; 
; Returns: No return
; Calls: score_to_str 
; Changes: AX,CH,DH,SI,easy_record_str
;  
set_score_str         proc                            
              
                      shl  bx,2
                      mov  ch,rec_buf[bx]                  ; Save value of regime with needed index to CH.
                      shr  bx,2
              
                      push bx
              
                      mov  ax, bx                          ; Set si to index of last digit of record value. 
                                              
                      mov  ah,rec_str_len                  ; AX = BX * rec_str_len + rec_value_offset 
                      mul  ah                              ; SI = AX + 2
                           
                      add  ax,rec_value_offset
            
                      mov  si,ax 
            
                      mov  ah,0                            ; AH = 0
                      mov  al,ch                           ; AL = score_value
                      
                      call score_to_str
                      
                      mov  bx,0
        
set_num:              mov  dh,score_str[bx]
                      mov  easy_record_str[si],dh
                      inc  bx              
                      inc  si
                      
                      cmp  bx,3
                      jl   set_num
                      
                      pop  bx
                      ret
set_score_str         endp

                
;==========================================================
;
; Procedure to convert integer score to string.  
;                
; Entry: AX - score value 
; 
; Returns: Saves result in score_str
; Calls: No calls 
; Changes: AX,BX,CL,score_str
;                 
score_to_str          proc
                
                      mov  bx,2
                      mov  cl,10                           ; for (BX = 2 ; BX > 0; BX--) 
                                                           ; {     
scan_num:             div  cl                              ;     (AH, AL) = (AX % 10, AX / 10)                 
                                                           ;     AH = AH.to_string()
                      add  ah,'0'                          ;     score_str[BX] = AH                    
                      mov  score_str[bx],ah                ;     AH = 0                       
                                                           ; }                              
                      mov  ah,0                                                              
                                                           ; Set AH to 0 to divide previos 
                      dec  bx                              ; quotient in the next iteration.
           
                      cmp  bx,0
                      jg   scan_num   
                                        
                      add  al,48                           ; AL = AL.to_string()
                      mov  score_str[bx],al
                                        
                      ret
score_to_str          endp     
 
 
;==========================================================
;
; Procedure to set byte record value to string. 
;            
; Entry: BX - regime index 
; 
; Returns: No return
; Calls: get_date_part 
; Changes: AX,DX,easy_record_str
;  
set_date_str          proc  
              
                      mov  ax,bx                            
                                              
                      mov  ah,rec_str_len                    
                      mul  ah                              ; AX = BX * rec_str_len
    
                      mov  si,ax                           ; Set SI to index of needed regime record string.
                      
                      mov  dx,bx
                      shl  dx,2
                      inc  dx                              ; Set DX to index of day in date 
                      
                      push bx
                      lea  bx,easy_record_str
                      
                      call get_date_part
                      mov  bx[si+rec_day_offset],ah
                      mov  bx[si+rec_day_offset+1],al
            
                      inc  dx
                      call get_date_part
                      mov  bx[si+rec_monts_offset],ah    
                      mov  bx[si+rec_monts_offset+1],al    
            
                      inc  dx
                      call get_date_part
                      mov  bx[si+rec_year_offset],ah
                      mov  bx[si+rec_year_offset+1],al
                      
                      pop  bx
                      ret
set_date_str          endp     
 

;==========================================================
;
; Procedure to get date part as byte from BCD format.
;       
; Entry: DX - index in record buffer where date part start 
; 
; Returns: Saves first digit in AH, last in AL
; Calls: No calls
; Changes: AX,CX
;  
get_date_part         proc       
    
                      mov  cx,si                           ; Save value of si.
                      mov  si,dx
            
                      mov  ax,0
                      mov  al,rec_buf[si]
            
                      shl  ax,4
                      shr  al,4
            
                      add  ah,'0'                          ; AH = AH.to_string()
                      add  al,'0'                          ; AL = AL.to_string()
                      
                      mov  si,cx
                      
                      ret    
get_date_part         endp    
 

;==========================================================
;
; Macro to get page number. 
;
; Entry: page - byte with last 7 bits is page number 
; 
; Returns: Saves result in BH
; Calls: No calls
; Changes: BH
; 
get_page_num          macro page
                                                           ; Since pages use the first bit to indicate 
                      mov  bh,page                         ; initialization, to get the page number needed 
                      and  bh,01111111b                    ; to set the first bit to 0. 
endm                                                        
  
                   
;==========================================================
;
; Macro to go to another page.
;
; Entry: page - byte with last 7 bits is page number 
; 
; Returns: No return
; Calls: get_page_num
; Changes: AX
; 
go_to_page            macro page
               
                      get_page_num page 
                      mov  al,bh                
                      
                      mov  ah,5
                      int  10h    
endm  
 
                                           
;==========================================================
;
; Macro for marking pages as initialized.
;
; Entry: page - byte with last 7 bits is page number 
; 
; Returns: No return
; Calls: get_page_num
; Changes: BX,DL
;   
set_inited            macro page 
                      local already_inited     
    
                      cmp  page,10000000b
                      jae  already_inited
                
                      get_page_num page
                      mov  bl, bh                          ; Save page number as offset from menu_page.
                      mov  bh,0
          
                      mov  dl,menu_page[bx]                ; Since pages are allocated in memory one after another and 
                      or   dl,10000000b                    ; similarly marked with numbers,can be used the address of the
                                                           ; first page and the page itself as an offset to obtain the address.
                      mov menu_page[bx],dl                  
already_inited:        
endm


;==========================================================
;
; Macro to check if the page is initialized.
;
; Entry: page - byte with last 7 bits is page number 
; 
; Returns: If inited, sets CF, atherwice resets it.
; Calls: No calls
; Changes: AH
;
is_inited             macro page
    
                      mov  ah,page                         ; An overflow will occur here if the page is greater 
                      add  ah,10000000b                    ; than 01111111b, which is a sign of an initialized page.     
endm                                                       ; This will set or reset the CF.
        

;==========================================================
;
; Procedure for displaying big words. 
;          
; Entry: ES:BP - big word adress
;        BH - page num 
;        BL - attribute
;        DH,DL - row and column
; 
; Returns: No return
; Calls: No calls
; Changes: AX,CX,BP,counter
;    
print_big_word        proc 
    
                      mov  al,0                            ; One attribute for all symbols.
            
                      mov  cl,[bp]                         ; Get lenght of big word.
                                                           ; Get height of big word.
                      mov  ch,[bp+1] 
                      mov  counter, ch                     ; Save to counter and set to zero.
                      mov  ch,0                            ; CX = CL
            
                      add  bp,2                            ; Set bp to start of big word.
               
                      mov  ah,13h
    
str_loop:             int  10h                             ; Print one line of big word.
    
                      dec  counter                  
                       
                      inc  dh                              ; Move to next line.
                      add  bp,cx
            
                      cmp  counter,0
                      jne  str_loop
                                        
                      ret      
print_big_word        endp    


;==========================================================
;
; Procedure for displaying choices. There are always three 
; options and they are located in the same places.Choices 
; must be strings ended with $.    
;
; Entry: ES:AX - first choice address
;        ES:CX - second choice address
;        ES:DX - third choice address
;        BH - page number
; 
; Returns: No return
; Calls: No calls
; Changes: AX,CX,DX,counter
;    
print_choices         proc          
    
                      push dx
                      push cx
                      push ax 
    
                      mov  counter,0 
    
                      mov  ch,first_choice_row             ; Store row.
        
print_choices_loop:   mov  dh,ch
                      mov  dl,first_choice_col+2
    
                      mov  ah,02h                          ; Move cursor.
                      int  10h
    
                      pop  dx                              ; Pop from stack choice string address.
                      mov  ah,09h                          ; Print choice string.
                      int  21h
    
                      add  ch,2                            ; Go down two rows.
    
                      inc  counter
                      cmp  counter,3
                      jl   print_choices_loop
             
                      ret
print_choices         endp 


;==========================================================
;
; Procedure for choosing from three options. Responsible 
; for switching between options. The choice variable is 
; responsible for the number of the selected action.  
;
; Entry: BH - page number
;        choice - initial choice
; 
; Returns: Save selection in the choice variable
; Calls: No calls
; Changes: AX,BL,CX,DX,BP,choice
; 
make_choice           proc
            
                      mov  al,choice
        
                      dec  al                              ; Get offset in the lines relative to the first option. 
                      shl  al,1                            ; There is one empty line between the lines with options.
            
                      mov  dh,first_choice_row             ; Row with first choice.
                      add  dh,al
                      mov  dl,first_choice_col
                              
                      lea  bp,choice_ptr                     
                      mov  al,0                            ; Attribute in bl
                      mov  bl,light_gray
                      mov  cx,1                            ; Print one symbol
                      
                      mov  ah,13h                                     
                      int  10h                             ; Print choice ptr in neaded position.
                                                               
                      mov  ch,20h
                      mov  ah,1 
                      int  10h                             ; Hide cursor.

choice_waiting:       mov  ah,0                            ; Wait symbol in keyboard buffer.
                      int  16h                             ; Result saved in ax.
                      
                      mov  cx,ax
                      or   al,to_lower_mask                ; al = al.to_lower()
                                                           ; This trick allows to avoid 
                      cmp  al,'w'                          ; comparison with UPPER CASE letters.
                      je   to_upper_choice
                       
                      cmp  ah,top_arrow_key
                      je   to_upper_choice
        
        
                      cmp  al,'s'
                      je   to_lower_choice
        
                      cmp  ah,bottom_arrow_key
                      je   to_lower_choice
        
                      mov  ax,cx
                      jmp  other_choice
    
to_upper_choice:      add  choice,4                        ; upper_choice = (choice + 4) % 3 + 1

to_lower_choice:      mov  ah,0
                      mov  al,choice                       ; lower_choice = choice % 3 + 1 
        
                      mov  ch,3
                      div  ch
       
                      inc  ah
                      mov  choice,ah  
           
                      mov  cx,1                            ; Clear choice ptr on previos choice on screen.
                      lea  bp,choice_clear                 
                      mov  al,0
                     
                      mov  ah,13h
                      int  10h
                  
                      jmp  make_choice                     ; Redisplay choice pointer.

other_choice:         cmp  ax,enter_key                    
                      je   choice_is_made
        
                      cmp  ax,escape_key                      
                      jne  choice_waiting
        
                      mov  choice,escape_chc

choice_is_made:       mov  dh,choice                       ; Clear current choice.
            
                      dec  dh                               
                      shl  dh,1                           
                        
                      add  dh,17                          
                      mov  dl,24
            
                      mov  bl,black
                      mov  cx,1
                  
                      lea  bp,choice_clear
                      mov  ah,13h
                      mov  al,0
                     
                      int  10h                             ; Print choice_clear on top of the pointer.
    
                      ret        
make_choice           endp  


;==========================================================
;
; Procedure for waiting user input. Space, enter and escape 
; keys are recognized. Space equal to enter. 
;
; Entry: No args
; Returns: Save result in the choice variable  
; Calls: No calls
; Changes: AX,choice
; 
wait_command          proc
    
                      mov  ah,0                            ; Wait symbol
                      int  16h
            
                      cmp  ax,escape_key
                      je   escape
                      
                      cmp  ax,enter_key 
                      je   back
                      
                      cmp  ah,space_key
                      je   back
                      
                      jmp  wait_command
            
escape:               mov  choice,escape_chc
                      jmp  command_made

back:                 mov  choice,1                 
        
command_made:         ret
wait_command          endp    


;==========================================================
;
; Procedure that controls the logic of a menu page. 
;
; Entry: No args
; Returns: Save selection in the choice variable
;  
; Calls: go_to_page,
;        print_menu_page,
;        get_page_num,
;        make_choice 
;
; Changes: choice
; 
load_menu_page        proc
    
                      go_to_page menu_page  
             
                      call print_menu_page
            
                      get_page_num menu_page 
                      mov  choice,1
                             
                      call make_choice
                                      
                      ret                      
load_menu_page        endp
 
 
;==========================================================
;
; Pocedure for displaying a menu page. Writes to video 
; memory once, then overwriting will not occur.
;
; Entry: No args
; Returns: Save selection in the choice variable
;  
; Calls: is_inited,
;        get_page_num,
;        print_big_word,
;        print_choices
;
; Changes: AX,CX,Bl,DX,BP
; 
print_menu_page       proc
    
                      is_inited menu_page
                      jc   menu_page_inited
        
                      get_page_num menu_page
       
                      lea  bp,snake_big_word   
       
                      mov  dh,2                            ; Row
                      mov  dl,3                            ; Column                                
                      mov  bl,crimson                                                
                       
                      call print_big_word 
                
                
                      lea  bp,game_big_word
                
                      mov  dl,6    
                      mov  bl,purple    
            
                      call print_big_word
                
                
                      lea  ax,play_str
                      lea  cx,records_str
                      lea  dx,exit_str
                
                      call print_choices
                
                      set_inited menu_page
     
menu_page_inited:     ret     
print_menu_page       endp  


;==========================================================
;
; Procedure that controls the logic of a records page. 
;
; Entry: No args
; Returns: Save selection in the choice variable
;  
; Calls: go_to_page,
;        print_records_page,
;        wait_command
;
; Changes: None
; 
load_records_page     proc
                      
                      go_to_page records_page 
                      
                      call print_records_page 
                      call wait_command  
                      
                      ret
load_records_page     endp


;==========================================================
;
; Pocedure for displaying a records page. Writes to video
; memory once, then overwriting will not occur.
;
; Entry: No args
; Returns: No return
;  
; Calls: is_inited,
;        get_page_num,
;        print_big_word,
;        set_inited,
;
; Changes: AX,BL,CX,DX,BP
;    
print_records_page    proc
      
                      is_inited records_page
                      jc  records_page_inited   
                                                        
                      get_page_num records_page
    
                      lea  bp,score_big_word   
       
                      mov  dh,3                            ; Row
                      mov  dl,2                            ; Column                                
                      mov  bl,white                                                                       
                      call print_big_word 
                            
                      lea  bp,list_big_word
                            
                      mov  dl,8
                      mov  bl,light_gray
                      call print_big_word
                            
                      set_inited records_page
                            
records_page_inited:  get_page_num records_page
                      
                      lea  bp,easy_record_str
                            
                      mov  cx,rec_str_len                  
                      mov  al,0                            ; One color for string.                                                                                                       
                      mov  bl,lime
                      mov  dh,17                           ; Row.
                      mov  dl,6                            ; Column.                           
                      
                      mov  ah,13h      
                      int  10h                             ; Print string.
                        
                      lea  bp,medium_record_str
                      mov  bl,yellow                   
                      mov  dh,19
                          
                      int  10h
                        
                      lea  bp,hard_record_str
                      mov  bl,light_red                  
                      mov  dh,21
                           
                      int  10h
                   
                      ret                         
print_records_page    endp 


;==========================================================
;
; Procedure that controls the logic of a regime page. 
;
; Entry: No args
; Returns: Save selection in the choice variable
;  
; Calls: go_to_page,
;        print_regime_page,
;        get_page_num,
;        make_choice
;
; Changes: choice
; 
load_regime_page      proc
                 
                      go_to_page regime_page
                 
                      call print_regime_page  
                 
                      get_page_num regime_page 
                      mov  choice,1
                     
                      call make_choice
                 
                      ret
load_regime_page      endp


;==========================================================
;
; Pocedure for displaying a regime page. Writes to video 
; memory once, then overwriting will not occur.
;
; Entry: No args
; Returns: No return
;  
; Calls: is_inited,
;        get_page_num,
;        print_big_word,
;        print_choices,
;        set_inited
;
; Changes: AX,BL,CX,DX,BP
;    
print_regime_page     proc
    
                      is_inited regime_page
                      jc   regime_page_inited   

                      get_page_num regime_page
    
                      lea  bp,regime_big_word   
                                                             
                      mov  dh,4                            ; Row.
                      mov  dl,2                            ; Column.                                
                      mov  bl,light_red                                               
                       
                      call print_big_word 
                      
                      lea  ax,easy_str
                      lea  cx,medium_str
                      lea  dx,hard_str
                
                      call print_choices
       
                      set_inited regime_page
     
regime_page_inited:   ret 
print_regime_page     endp  


;==========================================================
;
; Procedure for setting delay based on difficulty level.
;
; Entry: AL - difficulty level (1-easy,2-medium,3-hard) 
;
; Returns: No return 
; Calls: No calls
; Changes: CX
;  
set_delay             proc
          
                      mov  cx,5
                      sub  cl,al
                
                      mov  delay,cx
              
                      ret
set_delay             endp     
 
 
;==========================================================
;
; Procedure that controls the logic of a regime page. 
;
; Entry: AL - difficulty level (1-easy,2-medium,3-hard) 
;
; Returns: Save selection in the choice variable
;
; Calls: set_start_game_state,
;        print_game_page,
;        go_to_page,
;        process_game_key,
;        move_tail,
;        update_apple,
;        move_head,
;        stoping,
;        update_record
;
; Changes: choice
; 
load_game_page        proc
                               
                      call set_start_game_state             
                      call print_game_page
                       
                      go_to_page game_page                ; First clear field, then move to page.

game_loop:            call process_game_key
                      jc   escape_from_game
                    
                      call move_tail
                      jc   win_game
                                                 
                      call update_apple 
         
                      call move_head
                      jc   loose_game
                    
                      mov  cx,delay 
                      call stoping 
                            
                      jmp  game_loop 

                                                       
escape_from_game:     mov  choice,escape_chc
                      jmp  end_game                            

win_game:             mov  choice,win_chc
                      jmp  end_game

loose_game:           mov  choice,game_over_chc
                 
end_game:             call update_record
                      ret
load_game_page        endp     


;==========================================================
;
; Pocedure for displaying a game page. 
;
; Entry: No args
; Returns: No return
;  
; Calls: get_page_num,
;        set_elem
;
; Changes: AX,BL,CX,DX,BP
;  
print_game_page       proc 
                    
                      get_page_num game_page                                                                 
    
                      mov  dh,4
                      mov  dl,12   
    
                      mov  cx,0
                      mov  cl,size
              
print_field_loop:     mov  dl,12
                      mov  ah,02h
                      int  10h                             ; Move cursor.
                         
                      mov  al,grass_elem[0]
                      mov  bl,grass_elem[1]
                      
                      mov  ah,09h
                      int  10h                             ; Set range of grass elems to graphic memory.
        
                      inc  dh
                      cmp  dh,20
                      jl   print_field_loop
                       
                      lea  bp,snake_elem
                      mov  bx,16
                      call set_elem
                         
                      mov  bx,17
                      call set_elem
                         
                      mov  bx,18
                      call set_elem
                         
                      lea  bp,head_elem_right
                      mov  bx,19
                      call set_elem
                         
                      lea  bp,apple_elem
                      mov  bx,23
                      call set_elem
                            
                      get_page_num game_page
                       
                      lea  bp,score_mes                                         
                      mov  dh,21                           ; Row.
                      mov  dl,15                           ; Column.
                          
                      mov  ch,0
                      mov  cl,score_mes_len               
                                                
                      mov  bl,light_gray                                                
                      mov  al,1                            ; One attribute.
      
                      mov  ah,13h   
                      int  10h                             ; Print score.
        
                      ret  
print_game_page       endp 


;==========================================================
;
; Set settings to the start state. 
; Field becomes like this:
;      
;     012345678....15
;     ______________
; 0  |...........*..| 
; 1  |SSSS...A...*..| 
; 2  |...........*..|    
; .  |************..|        
; 14 |..............| 
; 15 |______________|  
;
; Field size is 16x16  
; Score is set to 0
;
; Entry: No args
; Returns: No return
; Calls: No calls
;
; Changes: AL,CX,DI,field,tail,
;          head,apple,rotation,
;          score,score_str
;           
set_start_game_state  proc 
    
                      mov  al,empty_cell
                      mov  cx,size*size
                      lea  di,field
                      rep  stosb                           ;    memset(field, empty_cell, size * size)
                                                            
                      mov  field[16],right_cell            ;    field[1][0..4] = snake
                      mov  field[17],right_cell             
                      mov  field[18],right_cell         
                      mov  field[19],right_cell        
                                                
                      mov  tail,16                         ;    tail = [1][0]
                      mov  head,19                         ;    head = [1][3] 
                                                                                                                                                                                
                      mov  field[23],apple_cell            ;    field[1][7] = apple
                                                
                      mov  apple,23                        ;    apple = [1][7]
                      
                      mov  rotation,right_cell             
                          
                      mov  score,0
                
                      mov  score_str[0],'0'
                      mov  score_str[1],'0'
                      mov  score_str[2],'0'
                    
                      ret
set_start_game_state  endp 


;==========================================================
;
; Procedure for process key press in game. Can set pause, 
; escape, only turn left or right relative to the current 
; position. Read key from keyboard buffer, if can.
;
; Entry: No args
; Returns: No return
; Calls: stopping
;
; Changes: AL,CX,rotation
;   
process_game_key      proc

                      mov  ah,1              
                      int  16h                             ; Check if there is a key in the keyboard buffer.
         
                      jz   process_end                     ; If no key, return.
        
                      mov  ah,0                            
                      int  16h                             ; If buffer contains key, save it to ax.
                      
                      cmp  ax,escape_key
                      je   process_escape
                      
                      or   al,to_lower_mask
                      
                      cmp  al,'w'
                      je   rotate_top
        
                      cmp  ah,top_arrow_key
                      je   rotate_top    
                    
                    
                      cmp  al,'d'
                      je   rotate_right
        
                      cmp  ah,right_arrow_key
                      je   rotate_right    
    
      
                      cmp  al,'s'
                      je   rotate_bottom
        
                      cmp  ah,bottom_arrow_key
                      je   rotate_bottom   
                    
                    
                      cmp  al,'a'
                      je   rotate_left
                    
                      cmp  ah,left_arrow_key
                      je   rotate_left
                    
                                    
                      cmp  ah,space_key
                      je   process_pause
               
                  
                      jmp  process_end

rotate_top:           cmp  rotation,bottom_cell
                      je   process_end
        
                      mov  rotation,top_cell
                      jmp  process_end
                  
              
rotate_right:         cmp  rotation,left_cell
                      je   process_end
        
                      mov  rotation,right_cell
                      jmp  process_end      
                 
             
rotate_bottom:        cmp  rotation,top_cell
                      je   process_end
        
                      mov  rotation,bottom_cell
                      jmp  process_end 
           
                 
rotate_left:          cmp  rotation,right_cell
                      je   process_end
        
                      mov  rotation,left_cell
                      jmp  process_end                            
       
       
process_pause:        call load_pause
                      jc   process_escape 
        
                      mov  cx,1
                      call stoping
        
                      jmp  process_game_key

process_escape:       stc                                  ; Set carry flag.
                      ret
    
process_end:          clc                                  ; Clear carry flag.
                      ret
process_game_key      endp
 
 
;==========================================================
;
; Procedure for processing pause. Wait untill player press 
; space again or leave from game by escape. 
;
; Entry: No args
; Returns: Set CF if escape, othervice reset it
; Calls: set_pause
;
; Changes: AX,BP
;   
load_pause            proc
     
                      lea  bp,pause_big_word   
                      call set_pause

entering_pause:       mov  ah,0                           
                      int  16h 
        
                      cmp  ax,escape_key
                      je   pause_escape                    ; If escape, set cf and return.
        
                      cmp  ah,space_key                    ; If not space, wait again.
                      jne  entering_pause     
         
                      lea  bp,pause_clear   
                      call set_pause                       ; Clear carry flag.
                      clc 
                      ret
    
pause_escape:         stc
                 
                      ret
load_pause            endp  
 
 
;==========================================================
;  
; Procedure to print or clear pause.
; 
; Entry: BP - address of pause_big_word or pause_clr
;
; Returns: No return
; Calls: print_big_word
; Changes: AL,BL,DX
;  
set_pause             proc
    
                      mov  al,1                            ; One attribute.
            
                      get_page_num game_page     
                      mov  bl,light_gray                  
            
                      mov  dh,2                            ; Row
                      mov  dl,2                            ; Column    
                                                                           
                      call print_big_word
               
                      ret
set_pause             endp    
  

;==========================================================
;
; Procedure for move tail. If apple is eaten, tail don't 
; move. 
; 
; Entry: No args
; Returns: If win, set CF, otherwice reset CF
;
; Calls: move, 
;        set_elem,
;        score_to_str  
;
; Changes: AX,BX,DH,BP
;  
move_tail             proc
        
                      mov  bx,apple                        ; If on 'apple' index not apple, it means 
                      cmp  field[bx],apple_cell            ; it was eaten in the previous iteration.
                      jne  inc_score                       ; Not move tail with moving head.        
                             
                      mov  bx,tail 
                      call move
        
                      mov  ax,tail   
                      mov  tail,bx
        
                      mov  bx,ax   
             
                      mov  dh,empty_cell 
                      mov  field[bx],dh                    ; Clear old tail on field.
        
                      lea  bp,grass_elem                  
                      call set_elem                        ; Clear old tail on page.
        
                      jmp  tail_move_end

inc_score:            inc  score
                      
                      mov  ax,score 
                      call score_to_str
                      
                      cmp  score,max_score
                      jne  not_won
                      
                      stc
                      ret
     
not_won:              lea  bp,score_str      
                     
                      mov  bl,light_gray   
        
                      get_page_num game_page
        
                      mov  cx,score_str_len                  
        
                      mov  dh,21                           ; Row.
                      mov  dl,22                           ; Column.
           
                      mov  al,1                            ; One attributes.
         
                      mov  ah,13h                          ; Print new score.
                      int  10h 
     
tail_move_end:        clc 
                      ret
move_tail             endp  


;==========================================================
;
; Procedure for set cell on game page by field index.
;
; Entry: BX - field index
;        BP - element address 
;
; Returns: No return
;
; Calls: get_page_num  
;
; Changes: AX,CX,DX
;  
set_elem              proc
        
                      push bx    
                
                      mov  dh,bl
                      mov  dl,bl
                
                      shr  dh,4                            ; row = field_index / field_size   
                      and  dl,00001111b                    ; col = field_index % field_size
                
                      add  dh,4                            ; row_num += 4              
                      add  dl,12                           ; col_num += 12  
                
                      get_page_num game_page        
               
                      mov  cx,1                            ; Print one symbol.
                
                      mov  al,255                          ; String with attributes.
                
                      mov  ah,13h    
                      int  10h                             ; Print needed symbol.
                        
                      pop  bx                       
                      ret    
set_elem              endp


;==========================================================
;
; Procedure to set new apple.
;
; Entry: No args
; Returns: No return
; Calls: set_elem 
; Changes: AX,BX,CX,DX,BP
;  
update_apple          proc
    
                      mov  bx,apple
            
                      cmp  field[bx],apple_cell
                      jne  try_set_apple
            
                      ret
    
try_set_apple:        mov  ah,2Ch                          ; Get current time.
                      int  21h                             ; dh - seconds, dl - centiseconds. 
                    
                      mov  al,60                           ; Since the smaller the unit of measurement, the more  
                      mul  dl                              ; unpredictable value will be, seconds and centiseconds 
                      mov  dl,dh                           ; are best suited for obtaining a random number. 
                      mov  dh,0                 
                      add  ax,dx                           ; ax = cs * 60 + s
                      mov  dx,0
                                                           ; Now AX value will be a random number from [0,5999].
                      mov  cx,23                           ; Divide this value by 23 and get an almost 
                      div  cx                              ; uniform distribution of the index.
                    
                      mov  bh,0                            ; al - random value from [0,255].
                      mov  bl,al
        
                      cmp  field[bx],empty_cell            ; If new index is not empty index, try again.
                      jne  try_set_apple    
           
                      mov  field[bx],apple_cell
                      mov  apple,bx    
        
                      lea  bp,apple_elem                   
                      call set_elem
            
                      ret    
update_apple          endp 


;==========================================================
;
; Procedure for move head.
;
; Entry: No args
; Returns: No return
; Calls: set_elem 
; Changes: AX,BX,CX,BP,blink_counter
;  
move_head             proc
    
                      mov  bx,head
            
                      lea  bp,snake_elem                   
                      call set_elem
            
                      call move
                      mov  head,bx
            
                      cmp  field[bx],empty_cell
                      je   not_lose
            
                      cmp  field[bx],apple_cell
                      je   not_lose
            
                      stc
                      ret
    
not_lose:             mov  cl,rotation 
                      mov  field[bx],cl
                   
                      inc  blink_counter 
                      and  blink_counter,00000111b         ; Every 8 frames snake will blink.
                      cmp  blink_counter,00000111b
                      jne  not_blink    
            
                      lea  bp,head_elem_blink
                      jmp  set_h
        
not_blink:            sub  cl,top_cell
                      mov  ch,0 
                      shl  cx,1
                      
                      mov  si,cx
                      lea  bp,head_elem_top[si]
    
set_h:                call set_elem         
                      clc
    
                      ret    
move_head             endp    


;==========================================================
;
; Procedure for slowing down the game.
; 
; Entry: CX - needed delay. Delay time = CX*256/1000 s
;
; Returns: No return
; Calls: No calls
; Changes: DX,AH
; 
stoping               proc    
        
                      mov  dx,0         
                      mov  ah,86h                  
                      int  15h                             ; delay_seconds = (cx * 100h + dx) / 1000
                    
                      ret
stoping               endp  


;==========================================================
;
; Procedure to move field cell by it rotation.
;
; Entry: BX - index of cell
; Returns: No return   

; Calls: to_left, 
;        to_bottom,  
;        to_right, 
;        to_top 
;
; Changes: AX,BX,CX,BP,blink_counter
;  
move                  proc 
     
                      mov  al,field[bx]
                      sub  al,49    
                      mov  ah,0                            ; ax - index of direction.
                     
                      push to_left
                      push to_bottom
                      push to_right
                      push to_top
                     
                      mov  bp,sp
                      shl  ax,1
                      add  bp,ax
                      mov  ax,[bp]
                     
                      call ax                              ; call [to_top,to_right,to_bottom,to_left][direction_index]
                     
                      add  sp,2*4                          ; pop 4
                          
                      ret    
move                  endp        


;==========================================================
;
; Procedure to move to top.
;
; Entry: BX - index of cell
; Returns: No return   
; Calls: No calls
; Changes: BL
;
to_top                proc
                                                         
                      sub  bl,size                         ; If index-size is less than zero, 
                                                           ; the correct index will be obtained because of overflows         
                      ret                                  ; (index will shift from the top border to the bottom border).
to_top                endp    


;==========================================================
;
; Procedure to move to bottom.
;
; Entry: BX - index of cell
; Returns: No return   
; Calls: No calls
; Changes: BL
;
to_bottom             proc    
    
                      add  bl,size                         ; If index-size is less than size^2-1 (255),
                                                           ; the correct index will be obtained because of overflows    
                      ret                                  ; (index will shift from the bottom border to the top border).  
to_bottom             endp          


;==========================================================
;
; Procedure to move to right.
;
; Entry: BX - index of cell
; Returns: No return   
; Calls: No calls
; Changes: AL,BL
;
to_right              proc 
    
                      mov  al,bl
             
                      and  al,00001111b                    ; Get index in row.
                      inc  al                             
                      and  al,00010000b                    ; If the index is on the right border, then 
                                                           ; al will contain size, otherwise zero.
                      sub  bl,al
                
                      inc  bl 
                  
                      ret
to_right              endp

    
;==========================================================
;
; Procedure to move to left.
;
; Entry: BX - index of cell
; Returns: No return   
; Calls: No calls
; Changes: AL,BL
;      
to_left               proc
  
                      dec  bl                              ; First move to left.
   
                      mov  al,bl                           ; Check, is the index on the right border. If it is, 
                                                           ; then add size so as not to move to the line above.
                      and  al,00001111b
                      inc  al                               
                      and  al,00010000b                   
    
                      add  bl,al
               
                      ret    
to_left               endp  


;==========================================================
;
; Procedure for update record in file and in rec_buf, if 
; need.
;
; Entry: No args
; Returns: No return   
; Calls: set_record, set_record_str
; Changes: AX,CX,DX
;
update_record         proc
            
                      mov  dx,4
                      sub  dx,delay                        ; Get index of current regime.  
            
                      mov  bx,dx
                      shl  bx,2                            ; Get index of regime in file.
            
                      mov  cx,score
            
                      mov  ah,0
                      mov  al,rec_buf[bx]
            
                      cmp  cx,ax   
                      jna  end_update 
                        
                      mov  rec_buf[bx],cl
            
                      mov  bx,dx
                      lea  dx,records_file     
            
                      mov  ah,3Dh                          ; Open existed file in
                      mov  al,1                            
           
                      int  21h    
                      jc   end_update                      
                       
                      push bx
                       
                      mov  dx,bx   
                      mov  bx,ax                           ; bx - file identifier. 
                      mov  al,cl
            
                      call set_record
                       
                      pop  bx
                                             
                      call set_record_str
                       
                      mov  ah,3Eh                          ; Close file.
                      int  21h
                                                                     
end_update:           ret
update_record         endp  


;==========================================================
;
; Procedure for load game end page. If choice is win_chc, 
; load win_page, otherwise load game_over_page.
;
; Entry: No args
; Returns: No return
;  
; Calls: go_to_page,
;        print_game_end_page,
;        make_choice
;
; Changes: choice
; 
load_game_end_page    proc
                   
                      cmp  choice,win_chc
                      je   load_won
                       
                      go_to_page game_over_page
                      clc
                      jmp  page_num_set
                       
load_won:             go_to_page game_win_page                   
                      stc
                      
page_num_set:         call print_game_end_page
                   
                      mov  choice,1
                      call make_choice
                                      
                      ret
load_game_end_page    endp    


;==========================================================
;
; Procedure for print page in game end.
;
; Entry: CF - win flag
;
; Returns: No return
;  
; Calls: go_to_page, 
;        is_inited,
;        print_game_end_page,
;        print_choices
;
; Changes: AX,BL,CX,DX,BP,SI
;
print_game_end_page   proc
                                   
                      jc  print_won
                    
                      get_page_num game_over_page
                      is_inited bl
                      jc   end_page_inited
 
                      lea  bp,game_big_word                    
                      mov  dl,3
                      mov  dh,2                       
                      mov  bl,light_red 
                                        
                      call print_big_word                    
                    
                      lea  bp,over_big_word
                      mov  dl,9
                      mov  bl,red
                    
                      call print_big_word
                      jmp  game_end_mes
                    
print_won:            get_page_num game_win_page
                      is_inited bl
                      jc   end_page_inited
                    
                      lea  bp,you_big_word
                      mov  dl,3
                      mov  dh,2  
                      mov  bl,lime
                    
                      call print_big_word
                    
                      lea  bp,won_big_word
                      mov  dl,9
                      mov  bl,green
                    
                      call print_big_word

game_end_mes:         push bx

                      lea  bp,your_res_str
                      mov  dh,19
                      mov  dl,3
                      mov  al,10000000b 
                      mov  cx,your_res_str_len
                      mov  bl,light_gray
                    
                      mov  ah,13h
                      int  10h 
                    
                      mov  si,sp                             
                      mov  bx,[si]                         ; pick bx
                    
                      lea  ax,play_again_str
                      lea  cx,back_to_menu_str
                      lea  dx,exit_str
                
                      call print_choices
                                      
                      set_inited bl
                      pop  bx
                    
end_page_inited:      lea  bp,score_str 
                      mov  al,10000000b
                      mov  cx,score_str_len
                      mov  dl,3
                      add  dl,your_res_str_len
                      mov  dh,19 
                      mov  bl,light_gray
                    
                      mov  ah,13h
                      int  10h                      
                                        
                      ret
print_game_end_page   endp


;==========================================================
;
; Procedure for load screen on exit from game.
;
; Entry: No args
; Returns: No return   
; Calls: No calls
; Changes: AX
;
load_exit_page        proc
   
                      go_to_page exit_page 
                     
                      mov  ax,4C00h                        ; End programm.           
                      int  21h  
      
load_exit_page        endp  
 

code ends 
end start 
  