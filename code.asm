.model tiny
 
.data
    size         db  16 
    matrix       db  16 dup ('.'),"2222...A",232 dup ('.')                            ; inicializacia matrix with start uslovia
    field_line   db  16 dup ('Ý',162)                                                 ; lime fon and green simbol left half    
    fsnake_str   db  3 dup ('X',230),';',230,3 dup ('Ý',162),'O',196,9 dup ('Ý',162)  ; field line with snake and apple
                                                                 
    counter      db  0
    str_num      db  1 

    score_mes    db  0Ah,0Dh,"               Score: "
    score_str    db  "000"
    score        dw  0
    
    head         dw  19
    tail         dw  16                
    apple        dw  23
    rotation     db  '2'          ; =>

    
    grass_elem   db  'Ý',162      ; grass         code 0
    snake_elem   db  'X',230      ; snake body    code 1
    
    head_elem_u  db  '"',230      ; head up       code 2  
    head_elem_r  db  ';',230      ; head right    code 3
    head_elem_d  db  '"',230      ; head down     code 4
    head_elem_l  db  ':',230      ; head left     code 5
    head_elem_z  db  ' ',230      ; head closed   code 6
    
    apple_elem   db  'O',196      ; apple         code 7
 
    zaderjka     dw  4              
   
    paus1        db  "Û Û"    
                 db  "Û Û"
                 db  "Û Û"
    
    paus_clr     db   9 dup (' ')
    
    snk1         db  " ___          ____      __  ___ "
                 db  "| __| |\  /| | __ | |\ / / | __|"
                 db  "||__  | \ || ||__|| ||/ /  ||_  "
                 db  "|__ | ||\\|| | __ | |  (   | _| "
                 db  " __|| || \ | ||  || ||\ \  ||__ "
                 db  "|___| |/  \| |/  \| |/ \_\ |___|"
                       
    gm1          db  " ____   ____   _ ",' '," _   ___ "
                 db  "| ___| | __ | | \",' ',"/ | | __|"   
                 db  "|| __  ||__|| |  ",'Y',"  | ||_  "    
                 db  "|||_ | | __ | ||\",' ',"/|| | _| "
                 db  "||__|| ||  || || ", 31," || ||__ "              
                 db  "|____| |/  \| |/ ",' '," \| |___|"   
    
    ovr1         db  " ____           ___   ____ "
                 db  "| __ | |\   /| | __| | __ |"
                 db  "||  || ||   || ||_   ||__||"  
                 db  "||  || \\   // | _|  | _ _|"    
                 db  "||__||  \\_//  ||__  || \\ "
                 db  "|____|   \_/   |___| |/  \\"  
    
    rgm1         db  " ____   ___   ____   _   _ ",' '," _   ___ "
                 db  "| __ | | __| | ___| | | | \",' ',"/ | | __|" 
                 db  "||__|| ||_   || __  | | |  ",'Y',"  | ||_  "  
                 db  "| _ _| | _|  |||_ | | | ||\",' ',"/|| | _| "    
                 db  "|| \\  ||__  ||__|| | | || ", 31," || ||__ "
                 db  "|/  \\ |___| |____| |_| |/ ",' '," \| |___|"  
    
    you1         db  "         ____         "
                 db  "|\   /| | __ | |\   /|"
                 db  "\ \ / / ||  || ||   ||"  
                 db  " \   /  ||  || ||   ||"    
                 db  "  | |   ||__|| \\___//"
                 db  "  |_|   |____|  \___/ "
    
    won1         db  "              ____        "
                 db  "|\        /| | __ | |\  /|"
                 db  "||        || ||  || | \ ||"  
                 db  "\\   /\   // ||  || ||\\||"    
                 db  " \\_//\\_//  ||__|| || \ |"
                 db  "  \_/  \_/   |____| |/  \|"   
    
    scr1         db  " ___   ____   ____   ____   ___ "
                 db  "| __| | ___| | __ | | __ | | __|"
                 db  "||__  ||     ||  || ||__|| ||_  "
                 db  "|__ | ||     ||  || | _ _| | _| "
                 db  " __|| ||___  ||__|| || \\  ||__ "
                 db  "|___| |____| |____| |/  \\ |___|"
    
    lst1         db  " _      _   ___   _____ "
                 db  "| |    | | | __| |_   _|" 
                 db  "| |    | | ||__    | |  "  
                 db  "| |    | | |__ |   | |  "    
                 db  "| |__  | |  __||   | |  "
                 db  "|____| |_| |___|   |_|  "  
                                                                                            
    
    play_agn_str db  "Play again"
    scr_lst_str  db  "Score list"
    exit_str     db  "Exit"
    
    easy         db  "Easy        XXX    XX.XX.20XX"        
    medium       db  "Medium      XXX    XX.XX.20XX"        ; Regime  score   date
    hard         db  "Hard        XXX    XX.XX.20XX"
    
    cng_rgm      db  "Change regime"    
     
    choice       db  1 
    chc          db  '>'    
    
    f_name       db 'records.txt',0 
    rec_buf      db 12 dup (?)  
     
    
.code


;------------

    mov_to_page macro num
   
    mov ah,5
    mov al,num                  
    
    int 10h 
    
    endm  

;----------

start:    
    
    mov ax,0000h                 ; ochistka ekrana set small ecrane  
    int 10h                       
          
    mov ax,1003h                 ; vibor jarkih color
    mov bl,0
    
    int 10h                 

    mov ax, @data                ; v ds pomeschaem adres segmenta dannih
    mov ds, ax 
       
    mov ax, @data                ; v es pomeschaem adres segmenta dannih
    mov es, ax
    
restart:    
          
    call show_start_ekrane 
        
    jmp strt_gm

gm_ovr:
    
    call update_record
    call show_gm_ovr_ekrane
           
    call new_game
      
strt_gm:
              
    call create_field
    
    mov bh,0                       ; nomer of page 
    call action_choice
   
    cmp al,1
    je regm
    
    cmp al,2 
    je scr_lst
    
    jmp end_game
    
regm:  
    call regime_choice
    jmp main_loop
    
scr_lst:

    call show_score_list
      
main_loop:   
    
    call change_rotat
    
    call update_score       
    call update_apple 
     
    call set_head
    
    mov cx,zaderjka
    call stoping    
  
    
    jmp main_loop 
     
           
end_game:

   call show_end_gm_ekrane
   
    
                                           
;------------
    
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

;----------

    
    show_score_list proc
    
    mov_to_page 7
    
    call read_records
    
    
    mov counter,6
    
    mov bh,7                     ; nomer stranici 
    mov cx,32                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,15                                                
    mov al,1                    ; bez atributov   
    lea bp,scr1
    
    call print_str 
        
    mov bl,7   
    mov counter,6
    mov cx,24 
    lea bp,lst1
    mov dl,8
    
    call print_str
    
       
    mov bl,10                     ;lime color
    mov cx,29
    mov dh,17
    mov dl,6
    lea bp,easy
    mov ah,13h
    
    int 10h
    
    mov bl,14                    ; yellow
    mov dh,19
    lea bp,medium
    
    int 10h
    
    mov bl,12                   ; red
    mov dh,21
    lea bp,hard
    
    int 10h
    
    
    
    
entering_command:    
    
    mov ah,0                        ; prerivanie vvoda simvola s ojidaniem
    int 16h
    
    cmp al,27
    je end_game
    
    mov choice,1
    
    cmp ax,01C0Dh
    je restart        
      
    jmp entering_command       
        
    ret    
    show_score_list endp    
      
;------------    
    
    
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
    
    
    
            
            
    mov ax,zaderjka
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

;------------ 

   regime_choice proc
   
   mov_to_page 5
   
   mov counter,6
    
    mov bh,5                     ; nomer stranici 
    mov cx,37                   ; dlina stroki SNAKE
    mov dl,2
    mov dh,4                          
    mov bl,12                                                
    mov al,1                    ; bez atributov   
    lea bp,rgm1
    
    call print_str
    
    mov bl,7
    mov cx,4
    mov dh,17
    mov dl,26
    lea bp,easy
    mov ah,13h
    
    int 10h
    
    mov dh,19
    mov cx,6
    lea bp,medium
    
    int 10h
    
    mov dh,21
    mov cx,4
    lea bp,hard
    
    int 10h
     
    mov bh,5
    mov choice,1
    call action_choice
    
    mov ax,5
    sub al,choice
    
    mov zaderjka,ax
     
   mov_to_page 1
    
   ret
   regime_choice endp 

;-----------

    show_end_gm_ekrane proc
   
    mov_to_page 6 
                     
    mov ax,4C00h              ; zakanchivaem programmu           
    int 21h  
      
    show_end_gm_ekrane endp  
  
;------------
    
    action_choice proc
    
entering_simbol2:
    
    mov al,choice
    dec al
    shl al,1
    
    mov dh,17
    add dh,al
    
    
    mov bl,7
    mov cx,1
    
    mov dl,24
    lea bp,chc
    mov ah,13h
    mov al,1
    
    int 10h
    
    
    mov ah,1                        ; priachem kursor
    mov ch,20h
    
    int 10h
    
   
    
    
    mov ah,0                        ; prerivanie vvoda simvola s ojidaniem
    int 16h 
    
    push ax
    
    mov cx,1
    lea bp,paus_clr
    mov ah,13h
    mov al,1
    int 10h
    
    pop ax
    
    cmp ah,1                        ; esli esc, to exit
    je end_game
    
    
    cmp al,'w'
    je w2
    
    cmp ah,048h
    jne not_w2    
w2:        
    dec choice
        
    cmp choice,0
    je to_3
    
    jmp entering_simbol2
    
not_w2:
    
    cmp al,'s'
    je s2
    
    cmp ah,050h
    jne not_s2    
s2:
    inc choice
        
    cmp choice,4
    je to_1
    
                           ; esli ne probel, to vvodim dalshe
not_s2:
    
    cmp ax,01C0Dh
    jne not_enter
    
    mov al,choice
    ret
    
not_enter:
    
    cmp al,27
    je end_game
    
    jmp entering_simbol2
             
to_1:

    mov choice,1
    jmp entering_simbol2        

to_3:

    mov choice,3
    jmp entering_simbol2

        
    ret
    action_choice endp    

;------------
    
    print_str proc
    
    mov ah,13h
    
str_loop:    
                
    int 10h
    
    dec counter
    inc dh
    add bp,cx
    
    cmp counter,0
    jne str_loop
           
    ret
    print_str endp    

;-----------
   
    print_pause proc
    
    mov al,1                    ; bez atributov
         
    mov bh,1                     ; nomer stranici
    mov bl,7                   ; seriõ cvet dlia SCORE 
    
    mov cx,3                   ; dlina stroki SNAKE
    mov counter,3
    
    mov dh,2                  ; mesto vivoda
    mov dl,2                                
                                                                   
    call print_str
       
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
    je end_game
    
    cmp ah,57                       ; esli ne probel, to vvodim dalshe
    jne entering_pause     
     
    lea bp,paus_clr   
    call print_pause 
     
               
    ret
    pause endp    

;------------ 

    stoping proc
     
    mov dx,0          ; zaderjka
    mov ah,86h  
    
    int 15h        
        
    ret
    stoping endp   


;-----------

    update_score proc
        
    mov bx,apple
    cmp matrix[bx],'A'
    jne inc_score                  
                         
    mov bx,tail 
    call move
    
    mov ax,tail   
    mov tail,bx
    
    mov bx,ax
    mov matrix[bx],'.'
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
    mov bh,1
    
    mov cx,27                   ; dlina stroki
    
    mov dh,20
    mov dl,0
     
    mov ax, @data                ; v es pomeschaem adres segmenta dannih
    mov es, ax
    lea bp,score_mes            ; dlia prerivania  
    mov al,1 
     
     
    mov ah,13h
   
    int 10h 
        
    
apl:    
        
    ret
    update_score endp    


;------------

    new_game proc
     
    mov bx,0 
     
    clr_loop:                      ; ochistka_massiva
    
    mov matrix[bx],'.'

    inc bx
    cmp bx,256       
    
    jne clr_loop
       
    mov matrix[16],'2'
    mov matrix[17],'2'
    mov matrix[18],'2'
    mov matrix[19],'2'   
    
    mov matrix[23],'A'
    
    mov score,0
    
    mov tail,16
    mov head,19
    
    mov apple,23
    
    mov rotation,'2'
    
    mov score_str[0],'0'
    mov score_str[1],'0'
    mov score_str[2],'0'
    
    ret
    new_game endp    

;-----------   
    
    set_head proc
    
    mov bx,head
    
    mov cx,1
    call set_elem
    
    call move
    mov head,bx
    
    cmp matrix[bx],'.'
    je skip
    
    cmp matrix[bx],'A'
    je skip
    
    mov choice,0      ; vivodit GAME OVER
    jmp gm_ovr
    
skip:
    
    mov ah,2ch      ; schitivaem vremia
    int 21h         ; v dh - sekundi, v dl - santisekundi 
    
    mov al,rotation 
    mov matrix[bx],al
    
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
       
    mov bh,1                     ; nomer stranici
   
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
    
    cmp matrix[bx],'A'
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

    cmp matrix[bx],'.'  ; esli popali v snake, to randomim zanogo
    jne try_set_apple    
       
    mov matrix[bx],'A'
    mov apple,bx    
    
    mov cx,7          ; 7 - cod elementa apla
    call set_elem
        
    ret    
    update_apple endp    


;------------

    move proc   ; v bx lejit index togo, chto nada dvigat
    
    cmp matrix[bx],'1'
    jne not_1    
    call to_up
    ret    
not_1:        
    cmp matrix[bx],'2'
    jne not_2    
    call to_right
    ret
not_2:    
    cmp matrix[bx],'3'
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
    je end_game
    
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
    
    mov_to_page 2
    
    cmp choice,1
    je Won
    
    mov counter,6
    
    mov bh,2                     ; nomer stranici 
    mov cx,27                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,12                                                
    mov al,1                    ; bez atributov   
    lea bp,gm1
    
    call print_str 
        
    mov bl,4    
    mov counter,6
    mov cx,27 
    lea bp,ovr1
    mov dl,9
    
    call print_str 
    jmp regme
    
Won:
    
    mov counter,6
    
    mov bh,2                    ; nomer stranici 
    mov cx,22                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,10                                                
    mov al,1                    ; bez atributov   
    lea bp,you1
    
    call print_str 
        
    mov bl,2    
    mov counter,6
    mov cx,26 
    lea bp,won1
    mov dl,9
    
    call print_str 
    
regme:
     
    mov choice,0 
     
    mov bl,7
    mov cx,10
    mov dh,17
    mov dl,26
    lea bp,play_agn_str
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
    
    mov bh,2 
    mov choice,1
    call action_choice
    
    
    
    cmp al,1
    je Play_agn
    
    cmp al,2 
    je Rgm
    
    jmp end_game    
    
Play_agn:    

    call new_game
    call create_field
    mov_to_page 1
    je main_loop
    
Rgm:
    call new_game
    call create_field 
   ; je restart
    je regm    
        
    ret   ;;; 
    show_gm_ovr_ekrane endp    

;-------   

    show_start_ekrane proc
    
    mov_to_page 0
    
    mov counter,6
    
    mov bh,0                     ; nomer stranici 
    mov cx,32                   ; dlina stroki SNAKE
    mov dl,3
    mov dh,2                          
    mov bl,13                                                
    mov al,1                    ; bez atributov   
    lea bp,snk1
    
    call print_str 
        
    mov bl,5    
    mov counter,6
    mov cx,27 
    lea bp,gm1
    mov dl,6
    
    call print_str
    
    mov bl,7
    mov cx,4
    mov dh,17
    mov dl,26
    lea bp,play_agn_str    ; Read only 4 first symbols - p
    mov ah,13h
    
    int 10h
    
    mov dh,19
    mov cx,10
    lea bp,scr_lst_str
    
    int 10h
    
    mov dh,21
    mov cx,4
    lea bp,exit_str
    
    int 10h   
    
    ret      
    show_start_ekrane endp  

;----------
    
    create_field proc                      
   
    mov str_num,4
    
    mov counter,0                   
   
    mov ax, @data                ; v es pomeschaem adres segmenta dannih
    mov es, ax
    lea bp,field_line            ; dlia prerivania 
   
    mov ah,13h
       
    mov bh,1                     ; nomer stranici
   
    mov ch,0  
    mov cl,size                  ; strlen 
   
    mov dl,12 ;;                    ; nomer clmn
    mov al,255                   ; regime - stroka s atributami
   
show_line_loop:                        
   
    mov dh,str_num              ; nomer stroki
    
    cmp counter,1
    jne skip1
    
    add bp,32
    
    int 10h ;;;; 
    
    sub bp,32
    jmp skip2
       
skip1:    
    
    int 10h ;;;;                    ; vivod stroki 
    
skip2:
      
    inc str_num
     
    inc counter
    mov dh,size
                                   
    cmp dh,counter              ; vivodim SIZE raz stroky
    jne show_line_loop 
    
    mov cx,27                   ; dlina stroki SCORE
   
    mov dh,str_num              ; mesto vivoda
    mov dl,0
                                ; seriõ cvet dlia SCORE
    mov bl,7                                                
    mov al,1                    ; bez atributov

    lea bp,score_mes            ; dlia prerivania  
   
    mov ah,13h

    int 10h
    
    ret  
    create_field endp 

;------------
 
 
end start