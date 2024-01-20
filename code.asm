
data segment 'data'
assume ds:data    
                         
    size            =  16                                                            
    field           db  256 dup (?)
    
    black           = 00h
    blue            = 01h
    green           = 02h
    cuan            = 03h
    red             = 04h
    purple          = 05h
    brown           = 06h
    light_gray      = 07h
    dark_gray       = 08h
    light_blue      = 09h
    lime            = 0Ah
    light_cuan      = 0Bh
    light_red       = 0Ch
    crimson         = 0Dh
    yellow          = 0Eh
    white           = 0Fh
    
; Each word in graphics memory is interpreted as follows: 
; the first byte is the character, the next 4 bits are the character color 
; and the last 4 are the background color.
                                          

    menu_page        db  00000000b      ; first bit will be used to store initialization state  
    score_list_page  db  00000001b
    regime_page      db  00000010b              
    game_page        db  00000011b
    game_over_page   db  00000100b          
    game_win_page    db  00000101b 
    game_end_page    db  00000110b                
                                                                 
    counter         db  0
    str_num      db  1      
    
    
    empty        =  0
    top          =  1
    right        =  2
    bottom       =  3
    left         =  4 
    

    score_mes    db  "Score: "
    score_str    db  "000"
    score        dw  0
    
    head         dw  19
    tail         dw  16                
    apple        dw  23
    rotation     db  '2'          ; =>

    
    grass_elem   db  'Ý',0A2h     ; grass         code 0
    snake_elem   db  'X',230      ; snake body    code 1
    
    head_elem_u  db  '"',230      ; head up       code 2  
    head_elem_r  db  ';',230      ; head right    code 3
    head_elem_d  db  '"',230      ; head down     code 4
    head_elem_l  db  ':',230      ; head left     code 5
    head_elem_z  db  ' ',230      ; head closed   code 6
    
    apple_elem   db  'O',196      ; apple         code 7
 
    delay        dw  3              
   
    paus1        db  3 dup ("Û Û")    
    
    paus_clr     db  3 dup ("   ")
    
    snake_big_word   db  32,6,
                     db  " ___          ____      __  ___ "
                     db  "| __| |\  /| | __ | |\ / / | __|"
                     db  "||__  | \ || ||__|| ||/ /  ||_  "
                     db  "|__ | ||\\|| | __ | |  (   | _| "
                     db  " __|| || \ | ||  || ||\ \  ||__ "
                     db  "|___| |/  \| |/  \| |/ \_\ |___|"
                       
    game_big_word    db  27,6
                     db  " ____   ____   _ ",' '," _   ___ "
                     db  "| ___| | __ | | \",' ',"/ | | __|"   
                     db  "|| __  ||__|| |  ",'Y',"  | ||_  "    
                     db  "|||_ | | __ | ||\",' ',"/|| | _| "
                     db  "||__|| ||  || || ", 31," || ||__ "              
                     db  "|____| |/  \| |/ ",' '," \| |___|"   
    
    over_big_word    db  27,6
                     db  " ____           ___   ____ "
                     db  "| __ | |\   /| | __| | __ |"
                     db  "||  || ||   || ||_   ||__||"  
                     db  "||  || \\   // | _|  | _ _|"    
                     db  "||__||  \\_//  ||__  || \\ "
                     db  "|____|   \_/   |___| |/  \\"  
    
    regime_big_word  db  37,6
                     db  " ____   ___   ____   _   _ ",' '," _   ___ "
                     db  "| __ | | __| | ___| | | | \",' ',"/ | | __|" 
                     db  "||__|| ||_   || __  | | |  ",'Y',"  | ||_  "  
                     db  "| _ _| | _|  |||_ | | | ||\",' ',"/|| | _| "    
                     db  "|| \\  ||__  ||__|| | | || ", 31," || ||__ "
                     db  "|/  \\ |___| |____| |_| |/ ",' '," \| |___|"  
    
    you_big_word     db  22,6
                     db  "         ____         "
                     db  "|\   /| | __ | |\   /|"
                     db  "\ \ / / ||  || ||   ||"  
                     db  " \   /  ||  || ||   ||"    
                     db  "  | |   ||__|| \\___//"
                     db  "  |_|   |____|  \___/ "
    
    won_big_word     db  26,6
                     db  "              ____        "
                     db  "|\        /| | __ | |\  /|"
                     db  "||        || ||  || | \ ||"  
                     db  "\\   /\   // ||  || ||\\||"    
                     db  " \\_//\\_//  ||__|| || \ |"
                     db  "  \_/  \_/   |____| |/  \|"   
    
    score_big_word   db  32,6  
                     db  " ___   ____   ____   ____   ___ "
                     db  "| __| | ___| | __ | | __ | | __|"
                     db  "||__  ||     ||  || ||__|| ||_  "
                     db  "|__ | ||     ||  || | _ _| | _| "
                     db  " __|| ||___  ||__|| || \\  ||__ "
                     db  "|___| |____| |____| |/  \\ |___|"
    
    list_big_word    db  24,6 
                     db  " _      _   ___   _____ "
                     db  "| |    | | | __| |_   _|" 
                     db  "| |    | | ||__    | |  "  
                     db  "| |    | | |__ |   | |  "    
                     db  "| |__  | |  __||   | |  "
                     db  "|____| |_| |___|   |_|  "  
                                                                                            

    
    play_str         db  "Play",'$'
    play_again_str   db  "Play again",'$'
    score_list_str   db  "Score list",'$'
    exit_str         db  "Exit",'$' 
    
    
    play_chc         =   1
    score_list_chc   =   2 
    
    back_chc         =   1
    
    escape_chc       =   255
    
    
    
    
    up_arrow_key     =   048h
    right_arrow_key  =   04Dh
    down_arrow_key   =   050h
    left_arrow_key   =   04Bh
    
    
    enter_key        =   01C0Dh  
    escape_key       =   0011Bh
    
    
    easy_str     db  "Easy",'$'        
    medium_str   db  "Medium",'$'        ; Regime  score   date
    hard_str     db  "Hard",'$'
    
    record_str   db  "Easy        XXX    XX.XX.20XX"
    
    
    cng_rgm      db  "Back to menu"    
                  
     
    choice       db  1 
    choice_ptr   db  '>'
    choice_clear db  ' '    
    
    f_name       db '../records.txt',0 
    rec_buf      db 12 dup (?)  
     
data ends    


code segment 'code'
assume cs:code    


start:    
     
    call set_start_settings 
    
menu:  
                  
    call load_menu_page 
    
    cmp  choice,play_chc
    je   regime
        
    cmp  choice,score_list_chc
    je   score_list
    
    jmp  game_end

score_list:
    
    call load_score_list_page


  
regime:

    call load_regime_page
    
    cmp choice,3
    jg  game_end
        
    mov  al,choice
    call set_delay
    
game:    
    
    
             
    jmp strt_gm





gm_ovr:
    
    call update_record
    call show_gm_ovr_ekrane
           
    call set_start_game_state
      
strt_gm:
             
              
    call print_game_page
    

    
regm:  
    jmp main_loop
    
scr_lst:

    call print_score_list_page
      
main_loop:   
    
    call change_rotat
    
    call update_score       
    call update_apple 
     
    call set_head
    
    mov cx,delay
    call stoping    
  
    
    jmp main_loop 
     
           
game_end:

   call show_end_gm_ekrane

 
 
;===================================
;
; Procedure for initial game setup. 
; Called once at the very beginning of the program. 

set_start_settings proc  
    
                   mov  ax,0000h                 ; Set a small screen and clean it  
                   int  10h                       
          
                   mov  ax,1003h                 ; Set bright colors
                   mov  bl,0
    
                   int  10h                 

                   mov  ax, @data                
                   mov  ds, ax 
       
                   mov  ax, @data              
                   mov  es, ax
                   
                   ret                   
set_start_settings endp


;===================================
;
; Since pages use the first bit to indicate initialization, 
; to get the page number needed to set the first bit to 0.
; The only argument is the page. 
; The result is placed in BH. 

get_page_num macro page
    
             mov bh,page 
             and bh,01111111b               
endm
  
                   
;===================================
;
; Macro to go to another page.
; The only argument is the page. 

mov_to_page macro page
   
            mov ah,5  
    
            get_page_num page 
            mov al,bh                
    
            int 10h 
    
endm  
 
                                           
;===================================
;
; Macro for marking pages as initialized.
; The only argument is the page. 
    
set_inited       macro page 
                 local already_inited     
    
                 cmp page,10000000b
                 jae already_inited
                
                 get_page_num page
                 mov bl, bh
                 mov bh,0
          
                 mov dl,menu_page[bx]      ; Since pages are allocated in memory one after another and 
                 or  dl,10000000b          ; similarly marked with numbers,can be used the address of the
                                           ; first page and the page itself as an offset to obtain the address
                 mov menu_page[bx],dl
                  
already_inited:  
endm


;===================================
;
; Macro to check if the page is initialized.
; The only argument is the page.
; The result is stored in the CF bit

is_inited macro page
    
          mov ah,page                       ; An overflow will occur here if the page is greater than 01111111b, which
          add ah,10000000b                  ; is a sign of an initialized page. This will set or reset the CF flag.    
endm        


;===================================
;
; Procedure for displaying big words. 
; ES:BP - big word adress.The first two bytes must be length and width, then comes the actual string.
; BH - page num 
; BL - attribute
; DH,DL - row and column
    
print_big_word proc 
    
               mov  al,0                     ; one attribute for all symbols
    
               mov  cl,[bp]                  ; get lenght of big word
                                            ; get height og big word
               mov  ch,[bp+1] 
               mov  counter, ch              ; save to counter and set to zero to
               mov  ch,0                     ; CX = CL
    
               add  bp,2                     ; set bp to start of big word
       
               mov  ah,13h
    
str_loop:      int  10h                      ; print one line of big word
    
               dec  counter                  
               
               inc  dh                       ; move to next line
               add  bp,cx
    
               cmp  counter,0
               jne  str_loop
                                
               ret      
print_big_word endp    


;===================================
;
; Procedure for displaying choices. There are always three 
; options and they are located in the same places.
; ES:AX - first choice
; ES:CX - second choice
; ES:DX - third choice
; BH - page number
; 
; Choices must be strings ended with $

print_choices        proc          
    
                     push dx
                     push cx
                     push ax 
    
                     mov  counter,0 
    
                     mov  ch,17                ; Store row.
        
print_choices_loop:  mov  dh,ch
                     mov  dl,26
    
                     mov  ah,02h               ; Move cursor.
                     int  10h
    
                     pop  dx                   ; Pop from stack choice string address
                     mov  ah,09h               ; Print choice string
                     int  21h
    
                     add  ch,2                 ; Go down two rows
    
                     inc  counter
                     cmp  counter,3
                     jl   print_choices_loop
             
                     ret
print_choices        endp 


;===================================
;
; Procedure for choosing from three options. Responsible for 
; switching between options. The choice variable is responsible 
; for the number of the selected action. Stores the result 
; of the selection in the choice variable. 
; BH - page num 

    
make_choice      proc
            
                 mov  al,choice
        
                 dec  al                  ; get offset in the lines relative to the first option. 
                 shl  al,1                ; There is one empty line between the lines with options.
        
                 mov  dh,17               ; Row with first choice
                 add  dh,al
                 mov  dl,24
        
                 mov  bl,light_gray
                 mov  cx,1
        
       
                 lea  bp,choice_ptr
                 mov  ah,13h
                 mov  al,0
                                                ; print choice ptr in neaded position
                 int  10h
            
            
                 mov  ah,1                        ; priachem kursor
                 mov  ch,20h
            
                 int  10h

choice_waiting:  mov  ah,0                        ; prerivanie vvoda simvola s ojidaniem
                 int  16h                         ; result saved in ax
         
                 cmp  al,'w'
                 je   to_upper_choice
    
                 cmp  ah,up_arrow_key
                 je   to_upper_choice
    
    
                 cmp  al,'s'
                 je   to_lower_choice
    
                 cmp  ah,down_arrow_key
                 je   to_lower_choice
    
    
                 jmp  other_choice
    
to_upper_choice: add  choice,4                      ; upper_choice = (choice + 4) % 3 + 1

to_lower_choice: mov  ah,0
                 mov  al,choice                     ; lower_choice = choice % 3 + 1 
    
                 mov  ch,3
                 div  ch
   
                 inc  ah
                 mov  choice,ah  
    
    
                 mov  cx,1                        ; clear choice ptr on previos choice on screen
                 lea  bp,choice_clear                 
                 mov  al,0
                 
                 mov  ah,13h
                 int  10h
              
                 jmp  make_choice               ; redisplay choice pointer

other_choice:    cmp  ax,enter_key                 ; enter
                 je   choice_is_made
    
                 cmp  ax,escape_key                      ; esc 
                 jne  choice_waiting
    
                 mov  choice,escape_chc

choice_is_made:  ret    
make_choice      endp  


;===================================
;
; Pocedure for displaying a menu page. Writes 
; to video memory once, then overwriting will not occur.

print_menu_page       proc
    
                      is_inited menu_page
                      jc   menu_page_is_inited
        
                      get_page_num menu_page
    
                      mov  ax,@data
                      mov  es,ax 
    
       
                      lea  bp,snake_big_word   
       
                      mov  dh,2                  ; Row
                      mov  dl,3                  ; Column                                
                      mov  bl,crimson                                                
                       
                      call print_big_word 
                
                
                      lea  bp,game_big_word
                
                      mov  dl,6    
                      mov  bl,purple    
            
                      call print_big_word
                
                
                      lea  ax,play_str
                      lea  cx,score_list_str
                      lea  dx,exit_str
                
                      call print_choices
                
                      set_inited menu_page
     
menu_page_is_inited:  ret     
print_menu_page       endp  

 
;===================================
;
; Procedure that controls the logic of a menu page. 
; Saves the selection results to the choice variable.

load_menu_page proc
    
               mov_to_page menu_page  
     
               call print_menu_page
    
    
               get_page_num menu_page 
               mov choice,1
                     
               call make_choice
                              
               ret                      
load_menu_page endp


;===================================
;
; Procedure for setting delay based on difficulty level.
; AL-difficulty level (1-easy,2-medium,3-hard) 
 
set_delay proc
          
          mov cx,5
          sub cl,al
    
          mov delay,cx
  
          ret
set_delay endp     
 
 
;===================================
;
; Pocedure for displaying a regime page. Writes 
; to video memory once, then overwriting will not occur.

print_regime_page       proc
    
                        is_inited regime_page
                        jc   regime_page_is_inited   

                        get_page_num regime_page
    
                        mov  ax,@data
                        mov  es,ax 
    
                        lea  bp,regime_big_word   
       
                        mov  dh,4                  ; Row
                        mov  dl,2                  ; Column                                
                        mov  bl,light_red                                                
                       
                        call print_big_word 
                      
                        lea  ax,easy_str
                        lea  cx,medium_str
                        lea  dx,hard_str
                
                        call print_choices
   
    
                        set_inited regime_page
     
regime_page_is_inited:  ret 
print_regime_page       endp  
 
 
;===================================
;
; Procedure that controls the logic of a regime page. 
; Saves the selection results to the choice variable

load_regime_page proc
                 
                 mov_to_page regime_page
                 
                 call print_regime_page  
                 
                 get_page_num regime_page 
                 mov choice,1
                     
                 call make_choice
                 
                 ret
load_regime_page endp





;----------

    
print_score_list_page proc
    
    
    
    call read_records
       
    mov counter,6
    
    get_page_num score_list_page   ; nomer stranici 
                       
    mov cx,32                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,15                                                
    mov al,1                    ; bez atributov   
    lea bp,score_big_word
    
    call print_big_word 
        
    mov bl,7   
    mov counter,6
    mov cx,24 
    lea bp,list_big_word
    mov dl,8
    
    call print_big_word
    
       
    mov bl,10                     ;lime color
    mov cx,29
    mov dh,17
    mov dl,6
    lea bp,easy_str
    mov ah,13h
    
    int 10h
    
    mov bl,14                    ; yellow
    mov dh,19
    lea bp,medium_str
    
    int 10h
    
    mov bl,12                   ; red
    mov dh,21
    lea bp,hard_str
    
    int 10h
    
    
    
    
entering_command:    
    
    mov ah,0                        ; prerivanie vvoda simvola s ojidaniem
    int 16h
    
    cmp al,27
    je game_end
    
    mov choice,1
    
    cmp ax,01C0Dh
    je menu        
      
    jmp entering_command       
        
                      ret    
print_score_list_page endp    
      
;------------  









;===================================
;
; Procedure that controls the logic of a score list page. 
; Save back_chc in choice variable if user choice back to menu
; and save escape_chc if user press escape


load_score_list_page proc
                      
                     mov_to_page score_list_page 
                      
                     call print_score_list_page 
                      
                      
                     ret
load_score_list_page endp








         
;-----------
    
read_records proc
    
    lea dx,f_name ;    
    
    mov ah,3Dh                          ; otkrit suschestvuuschiõ file
    mov al,00h                          ; tolko dla chtenia    
    
    int 21h    
    jc exit2                             ; esli oshibka - vihod   
    
    mov bx,ax                           ; bx - file identifikator 
    mov di,01                           ; di - STDOUT identifikator
    
    mov cx,12                           ; razmer bloka dla chtenia
    lea dx,rec_buf                      ; bufer 
    
    mov ah,3Fh
    int 21h
    
    jc exit2
         
    mov ah,0
    mov al,rec_buf[0]
    mov score,ax
    
    call get_score
    
    mov bx,58
    mov si,1
    
    call read_1_record 
    
     
    mov ah,0 
    mov al,rec_buf[4]
    mov score,ax
    
    call get_score
    
    
    mov bx,29
    mov si,5
    
    call read_1_record
    
    
    mov ah,0 
    mov al,rec_buf[8]
    mov score,ax
    
    call get_score
    
    mov bx,0
    mov si,9
    
    call read_1_record
    
    mov score,0
    mov score_str[0],'0'
    mov score_str[1],'0'
    mov score_str[2],'0'
    
exit2:

    mov ah,3Eh
    int 21h
    
    
           
    ret    
    read_records endp    
 
;------------
    
    read_1_record proc
    
    mov cl,score_str[0]
    mov easy[bx+12],cl
    
    mov cl,score_str[1]
    mov easy[bx+13],cl
    
    mov cl,score_str[2]
    mov easy[bx+14],cl
    
    call read_date
    mov easy[bx+19],ah
    mov easy[bx+20],al
    
    inc si
    call read_date
    mov easy[bx+22],ah
    mov easy[bx+23],al
    
    inc si
    call read_date
    mov easy[bx+27],ah
    mov easy[bx+28],al
               
    ret    
    read_1_record endp      

;-----------

    read_date proc
    
    mov ax,0
    mov al,rec_buf[si]
    
    shl ax,4
    shr al,4
    
    add ah,48
    add al,48
           
    ret    
    read_date endp    

;-------------------  
    
    
    update_record proc
    
    lea dx,f_name ;    
    
    mov ah,3Dh                          ; otkrit suschestvuuschiõ file
    mov al,00h                          ; tolko dla chtenia    
    
    int 21h    
    jc exit                             ; esli oshibka - vihod   
    
    mov bx,ax                           ; bx - file identifikator 
    mov di,01                           ; di - STDOUT identifikator
    
    mov cx,12                           ; razmer bloka dla chtenia
    lea dx,rec_buf                      ; bufer 
    
    mov ah,3Fh
    int 21h
    
    jc exit                             ; esli oshibka - zakrit file      
    
    
    
            
            
    mov ax,delay
    sub ax,2
    
    shl ax,2
    
    mov bx,ax
    
    mov ax,score
    
    mov ch,0
    mov cl,rec_buf[bx]
    
    cmp ax,cx   
    jng exit 
                
    mov rec_buf[bx],al
    
    mov ah,4
    int 1Ah
    
    sub cx,2000h
    
    inc bx
    mov rec_buf[bx],dl
    
    inc bx
    mov rec_buf[bx],dh
    
    inc bx
    mov rec_buf[bx],cl
    
    
    lea dx,f_name ;    
    
    mov ah,3Dh                          ; otkrit suschestvuuschiõ file
    mov al,1                            ; tolko dla chtenia  
   
    int 21h    
    jc exit                             ; esli oshibka - vihod
       
    mov bx,ax                           ; bx - file identifikator 
   
    mov cx,12                           ; razmer bloka dla chtenia
    lea dx,rec_buf                      ; bufer 
    
    mov ah,40h
    int 21h
    
    mov ah,3Eh
    int 21h
                                                            
exit:
    
    ret
    update_record endp     




;-----------

    show_end_gm_ekrane proc
   
    mov_to_page game_end_page 
                     
    mov ax,4C00h              ; zakanchivaem programmu           
    int 21h  
      
    show_end_gm_ekrane endp  
 
  
  




;-----------
   
    print_pause proc
    
    mov al,1                    ; bez atributov
    
    
    get_page_num game_page     
;    mov bh,1                     ; nomer stranici
    mov bl,7                   ; seriõ cvet dlia SCORE 
    
    mov cx,3                   ; dlina stroki SNAKE
    mov counter,3
    
    mov dh,2                  ; mesto vivoda
    mov dl,2                                
                                                                   
    call print_big_word
       
    ret
    print_pause endp    


;------------

    pause proc
    

        
    lea bp,paus1   
    call print_pause

entering_pause:                 
                   
    mov ah,0                        ; prerivanie vvoda simvola s ojidaniem
    int 16h 
    
    cmp ah,1                        ; esli esc, to exit
    je game_end
    
    cmp ah,57                       ; esli ne probel, to vvodim dalshe
    jne entering_pause     
     
    lea bp,paus_clr   
    call print_pause 
     
               
    ret
    pause endp    

;------------ 

    stoping proc
     
    mov dx,0          ; delay
    mov ah,86h  
    
    int 15h        
        
    ret
    stoping endp   


;-----------

    update_score proc
        
    mov bx,apple
    cmp field[bx],'A'
    jne inc_score                  
                         
    mov bx,tail 
    call move
    
    mov ax,tail   
    mov tail,bx
    
    mov bx,ax   
         
    mov dh,empty 
    mov field[bx],dh     
    
    mov cx,0
    call set_elem
    
    jmp apl

inc_score:  

    inc score
    
    cmp score,252
    jne not_won
    
    mov choice,1
    jmp gm_ovr
     
not_won:
     
    call get_score
    
    
    mov bl,7   
    
    get_page_num game_page
   ; mov bh,1
    
    mov cx,3                   ; dlina stroki
    
    mov dh,21
    mov dl,22
     
    mov ax, @data                ; v es pomeschaem adres segmenta dannih
    mov es, ax   
    
    
    
    lea bp,score_str            ; dlia prerivania  
    mov al,1 
     
     
    mov ah,13h
   
    int 10h 
        
    
apl:    
        
    ret
    update_score endp    


;===================================
;
; Set settings to the start state: 
;
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
         
set_start_game_state proc
     
                     mov  bx,0                   
                     mov  dh,empty 
                                                ;
clr_loop:            mov  field[bx],dh          ;    for i from 0 to size    
                                                ;        for j from 0 to size
                     inc  bx                    ;            field[i][j] = empty
                     cmp  bx,256                ;
                     jne  clr_loop              ;
                                                ;
                                                ;
                     mov  field[16],'2'         ;    field[1][0..4] = snake
                     mov  field[17],'2'         ;    
                     mov  field[18],'2'         ;
                     mov  field[19],'2'         ;
                                                ;
                     mov  tail,16               ;    tail = [1][0]
                     mov  head,19               ;    head = [1][3]
                                                ;
                     mov  rotation,'2'          ;    rotation = right   
                                                ; 
                                                ;
                     mov  field[23],'A'         ;    field[1][7] = apple
                                                ;
                     mov  apple,23              ;    apple = [1][7]
                
            
                     mov  score,0
                
                     mov  score_str[0],'0'
                     mov  score_str[1],'0'
                     mov  score_str[2],'0'
                    
                     ret
set_start_game_state endp    

;-----------   
    
    set_head proc
    
    mov bx,head
    
    mov cx,1
    call set_elem
    
    call move
    mov head,bx
    
    mov  dh,empty
    cmp field[bx],dh
    je skip
    
    cmp field[bx],'A'
    je skip
    
    mov choice,0      ; vivodit GAME OVER
    jmp gm_ovr
    
skip:
    
    mov ah,2ch      ; schitivaem vremia
    int 21h         ; v dh - sekundi, v dl - santisekundi 
    
    mov al,rotation 
    mov field[bx],al
    
    and dx,000001110111111b
    cmp dx,50
    jg not_closed
    
    mov cx,6
    jmp set_h

not_closed:
        
    sub al,47
    mov ah,0
    
    mov cx,ax
    
set_h:        
    
    call set_elem
    
    
    ret    
    set_head endp    

;------------

    set_elem proc
        
    push bx    
    
    mov al,bl
    mov ah,bl
    
    shr al,4            ; chastnoe ot delenia na 16
  
    and ah,00001111b    ; ostatok ot delenia na 16
    
    add al,4            ; +4 dlia nomera stroki
    add ah,12            ; +12 dlia nomera stolbca
    
    mov dx, @data                ; v es pomeschaem adres segmenta dannih
    mov es, dx
    
    shl cl,1            ; sdvig dlia poluchenia nujnogo elementa
    
    push bx
    mov bx,cx
    
    lea bp,grass_elem[bx]
    
    pop bx 
    

    get_page_num game_page        ; nomer stranici
   
    mov ch,0  
   
   mov cl,1  
   
    mov dl,ah                     ; nomer clmn
    mov dh,al              ; nomer stroki
    
    mov al,255                   ; regime - stroka s atributami
    mov ah,13h
    
    int 10h
    
        
    pop bx   
        
    ret    
    set_elem endp
    
;------------   

    update_apple proc
    
    mov bx,apple
    
    cmp field[bx],'A'
    jne try_set_apple
    
    ret
    
try_set_apple:

    mov ah,2ch      ; schitivaem vremia
    int 21h         ; v dh - sekundi, v dl - santisekundi 
    
    mov dh,dl
    shr dh,1        ; randomim
                    ; dl *= 2,5
    shl dl,1        ; dh = 0
    add dl,dh       
    
    mov dh,0        
    
    mov bx,dx       ; tepier v bx index apla
    
    mov  ah,empty
    cmp field[bx],ah  ; esli popali v snake, to randomim zanogo
    jne try_set_apple    
       
    mov field[bx],'A'
    mov apple,bx    
    
    mov cx,7          ; 7 - cod elementa apla
    call set_elem
        
    ret    
    update_apple endp    


;------------

    move proc   ; v bx lejit index togo, chto nada dvigat
    
    cmp field[bx],'1'
    jne not_1    
    call to_up
    ret    
not_1:        
    cmp field[bx],'2'
    jne not_2    
    call to_right
    ret
not_2:    
    cmp field[bx],'3'
    jne not_3    
    call to_down
    ret
not_3: 
    
    call to_left
        
    ret    
    move endp        

;-----------

    to_up proc
    
    sub bl,16          ; esli index - size menshe 0
                       ; to on avtomatom opustitca k         
    ret                ; nijnei granice
    to_up endp    

;-----------

    to_down proc    
    
    add bl,16          ; esli index - size bolshe chem size^2
                       ; to on avtomatom podnimetca k         
    ret                ; verhnei granice   
    to_down endp          

;-----------

    to_right proc 
    
    mov al,bl
 
    and al,00001111b
    inc al                 ; esli periehod 
    and al,00010000b       ; otnimetca size
    
    sub bl,al
    
    inc bl 
      
    ret
    to_right endp
    
;-----------
      
    to_left proc
  
    dec bl
   
    mov al,bl
 
    and al,00001111b
    inc al                 ; esli periehod 
    and al,00010000b       ; dobavitca size
    
    add bl,al
               
    ret    
    to_left endp    

;-----------

    change_rotat proc

check_char:
    
    mov ah,1             ; prerivanie vvoda simvola v bufer clavi
    int 16h  
     
    jz repit  
    
    mov ah,0             ; esli est simvol v bufere, to chitaem
    int 16h
       
    cmp al,'w'
    je w
    
    cmp ah,048h
    jne not_w    
w:    
    cmp rotation,'3'
    je repit
    
    mov rotation,'1'
    ret
not_w:

    cmp al,'d'
    je d
    
    cmp ah,04Dh
    jne not_d    
d:     
    cmp rotation,'4'
    je repit
    
    mov rotation,'2'
    ret   
not_d:     
    cmp al,'s'
    je s
    
    cmp ah,050h
    jne not_s    
s:   
    cmp rotation,'1'
    je repit
    
    mov rotation,'3'
    ret   
not_s: 
    cmp al,'a'
    je a
    
    cmp ah,04Bh
    jne not_a    
a:    
    cmp rotation,'2'
    je repit
    
    mov rotation,'4'
    ret   
not_a:
    cmp al,' '
    jne not_pause 
    
    call pause 
    
    mov cx,1
    call stoping
    
    jmp check_char 
    
not_pause:

    cmp al,27
    je game_end
    
repit:    
    
    ret
    change_rotat endp

 
;-----------   
    get_score proc
   
    mov bx,0
    mov ax,score
    mov cl,10
      
scan_num:
   
    div cl
   
    add ah,48
    mov score_str[bx],ah

    mov ah,0
     
    inc bx
   
    cmp bx,2
    jne scan_num   
   
    mov bl,score_str[0]
    mov score_str[2],bl
   
    add al,48
    mov score_str[0],al   
  
   
    ret
    get_score endp
 

;--------
    
    show_gm_ovr_ekrane proc
    
    mov_to_page game_over_page
    
    cmp choice,1
    je Won
    
    mov counter,6
    
    get_page_num game_over_page ; nomer stranici 
    
    mov cx,27                   ; dlina stroki 
    mov dl,3
    mov dh,2                          
    mov bl,12                                                
    mov al,1                    ; bez atributov   
    lea bp,game_big_word
    
    call print_big_word 
        
    mov bl,4    
    mov counter,6
    mov cx,27 
    lea bp,over_big_word
    mov dl,9
    
    call print_big_word 
    jmp regme
    
Won:
    
    mov counter,6
    
    get_page_num game_win_page
;    mov bh,2                    ; nomer stranici 
    mov cx,22                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,10                                                
    mov al,1                    ; bez atributov   
    lea bp,you_big_word
    
    call print_big_word 
        
    mov bl,2    
    mov counter,6
    mov cx,26 
    lea bp,won_big_word
    mov dl,9
    
    call print_big_word 
    
regme:
     
    mov choice,0 
     
    mov bl,7
    mov cx,10
    mov dh,17
    mov dl,26
    lea bp,play_again_str
    mov ah,13h
    
    int 10h
    
    mov dh,19
    mov cx,13
    lea bp,cng_rgm
    
    int 10h
    
    mov dh,21
    mov cx,4
    lea bp,exit_str
    
    int 10h
   
    
    get_page_num game_over_page
   
    mov choice,1
    call make_choice
    
    
    
    cmp al,1
    je Play_agn
    
    cmp al,2 
    je Rgm
    
    jmp game_end    
    
Play_agn:    

    call set_start_game_state
    call print_game_page
    mov_to_page game_page
    jmp main_loop
    
Rgm:
    call set_start_game_state
    call print_game_page
    jmp menu
    
        
    ret   ;;; 
    show_gm_ovr_ekrane endp    
 
 


   

;---------------
   
print_game_page proc 
    is_inited game_page
    jc game_page_is_inited
    
    get_page_num game_page                                                              
    
    mov ax, @data                ; v es pomeschaem adres segmenta dannih
    mov es, ax       
    
    mov dh,4
    mov dl,12   
    
    mov cx,0
    mov cl,size
              
print_field_loop: 
    mov dl,12
    mov ah,02h
    int 10h                       ; move cursor
    
    mov ah,09h
    mov al,grass_elem[0]
    mov bl,grass_elem[1]
     
    int 10h                       ; set range of grass elems to graphic memory
    
    inc dh
    cmp dh,20
    jl  print_field_loop
    
    inc dh
    mov dl,15                
    mov cx,10                   ; dlina stroki SCORE
                                ; seriõ cvet dlia SCORE
    mov bl,7                                                
    mov al,1                    ; bez atributov

    lea bp,score_mes            ; dlia prerivania  
   
    mov ah,13h

    int 10h
    
    set_inited game_page 
    
game_page_is_inited:         
    
   
             
    ret  
    print_game_page endp 

;------------  

code ends 
 
end start       
