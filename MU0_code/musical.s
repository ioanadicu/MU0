; MU0 Piano
; 
; This program reads user input from a keypad and displays corresponding 
; digits on a multi-segment display. The user can press the numeric keys 
; for different features. 
;
; Key Mapping:
; - Keys '1', '2', '3': Play different preset songs.
; - Keys '0' and '4' to '9': Play individual musical notes ('do', 're', 'mi', etc.) on the buzzer.
; 
; Songs and notes are defined using programmable mode on the piezo buzzer.
; Delays are included between notes.
;

ORG &000 ; Start address of the program



;
;
;   ---- Detecting which key is pressed ----
;
;

main_loop
    LDA &FF2          ; Load keypad input
    SUB zero_key      ; Check if '0' is pressed
    JNE check_one     ; If not, check the next key
    LDA zero_display  ; Load the pattern for displaying '0'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_si       ; Play the note 'si'
    JMP main_loop     ; Continue main loop

check_one
    LDA &FF2          ; Load keypad input
    SUB one_key       ; Check if '1' is pressed
    JNE check_two     ; If not, check the next key
    LDA one_display   ; Load the pattern for displaying '1'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_song1    ; Plat the first song
    JMP main_loop     ; Continue main loop

check_two
    LDA &FF2          ; Load keypad input
    SUB two_key       ; Check if '2' is pressed
    JNE check_three   ; If not, check the next key
    LDA two_display   ; Load the pattern for displaying '2'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_song2    ; Play the second song
    JMP main_loop     ; Continue main loop

check_three
    LDA &FF2          ; Load keypad input
    SUB three_key     ; Check if '3' is pressed
    JNE check_four    ; If not, check the next key
    LDA three_display ; Load the pattern for displaying '3'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_song3    ; Play the third song
    JMP main_loop     ; Continue main loop

check_four
    LDA &FF2          ; Load keypad input
    SUB four_key      ; Check if '4' is pressed
    JNE check_five    ; If not, check the next key
    LDA four_display  ; Load the pattern for displaying '4'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_do       ; Play the note 'do'
    JMP main_loop     ; Continue main loop

check_five
    LDA &FF2          ; Load keypad input
    SUB five_key      ; Check if '5' is pressed
    JNE check_six     ; If not, check the next key
    LDA five_display  ; Load the pattern for displaying '5'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_re       ; Play the note 're'
    JMP main_loop     ; Continue main loop

check_six
    LDA &FF2          ; Load keypad input
    SUB six_key       ; Check if '6' is pressed
    JNE check_seven   ; If not, check the next key
    LDA six_display   ; Load the pattern for displaying '6'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_mi       ; Play the note 'mi'
    JMP main_loop     ; Continue main loop

check_seven
    LDA &FF2          ; Load keypad input
    SUB seven_key     ; Check if '7' is pressed
    JNE check_eight   ; If not, check the next key
    LDA seven_display ; Load the pattern for displaying '7'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_fa       ; Play the note 'fa'
    JMP main_loop     ; Continue main loop

check_eight
    LDA &FF2          ; Load keypad input
    SUB eight_key     ; Check if '8' is pressed
    JNE check_nine    ; If not, check the next key
    LDA eight_display ; Load the pattern for displaying '8'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_sol      ; Play the note 'sol'
    JMP main_loop     ; Continue main loop

check_nine
    LDA &FF2          ; Load keypad input
    SUB nine_key      ; Check if '9' is pressed
    JNE main_loop     ; If not, continue the main loop
    LDA nine_display  ; Load the pattern for displaying '9'
    STA &FFA          ; Write to the last multi-segment display
    JMP play_la       ; Play the note 'la'
    JMP main_loop     ; Continue main loop



;
;
;   ---- Defining piano keys ----
;
;

play_do
    LDA lights_green    ; Turn lights on
    STA &FFF

    LDA note_do ; Play do
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_re
    LDA lights_yellow   ; Turn lights on
    STA &FFF

    LDA note_re ; Play re
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_mi
    LDA lights_red  ; Turn lights on
    STA &FFF

    LDA note_mi ; Play mi
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_fa
    LDA lights_green    ; Turn lights on
    STA &FFF

    LDA note_fa ; Play fa
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_sol
    LDA lights_yellow   ; Turn lights on
    STA &FFF

    LDA note_sol ; Play sol
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_la
    LDA lights_red  ; Turn lights on
    STA &FFF

    LDA note_la ; Play la
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop

play_si 
    LDA lights_green    ; Turn lights on
    STA &FFF

    LDA note_si ; Play si
    STA &FFD

    LDA lights_off  ; Turn lights off
    STA &FFF

    JMP main_loop   ; Continue to main loop



;
;
;   ---- Pattern for song 1 ----
;
;

play_song1
    LDA lights_green
    STA &FFF
    ; Snail song: a = c4, b = e4
    ; First segment: a b
    LDA note_c4       
    STA &FFD          
    LDA delay
delay1
    SUB one
    JNE delay1

    LDA note_e4       
    STA &FFD          
    LDA delay
delay2
    SUB one
    JNE delay2

    ; Second segment: aa b
    LDA note_c4       
    STA &FFD          
    LDA delay
delay3
    SUB one
    JNE delay3

    LDA note_c4       
    STA &FFD          
    LDA delay
delay4
    SUB one
    JNE delay4

    LDA note_e4       
    STA &FFD          
    LDA delay
delay5
    SUB one
    JNE delay5

    LDA lights_all
    STA &FFF

    ; Third segment: aa bb
    LDA note_c4       
    STA &FFD          
    LDA delay
delay6
    SUB one
    JNE delay6

    LDA note_c4       
    STA &FFD          
    LDA delay
delay7
    SUB one
    JNE delay7

    LDA note_e4       
    STA &FFD          
    LDA delay
delay8
    SUB one
    JNE delay8

    LDA note_e4       
    STA &FFD          
    LDA delay
delay9
    SUB one
    JNE delay9

    LDA lights_green
    STA &FFF
    ; Fourth segment: a b
    LDA note_c4       
    STA &FFD          
    LDA delay
delay10
    SUB one
    JNE delay10

    LDA note_e4       
    STA &FFD          
    LDA delay
delay11
    SUB one
    JNE delay11

    ; Fifth segment: aa bb
    LDA note_c4       
    STA &FFD          
    LDA delay
delay12
    SUB one
    JNE delay12

    LDA note_c4       
    STA &FFD          
    LDA delay
delay13
    SUB one
    JNE delay13

    LDA note_e4       
    STA &FFD          
    LDA delay
delay14
    SUB one
    JNE delay14

    LDA note_e4       
    STA &FFD          
    LDA delay
delay15
    SUB one
    JNE delay15

    LDA lights_yellow
    STA &FFF

    ; Sixth segment: aa b
    LDA note_c4       
    STA &FFD          
    LDA delay
delay16
    SUB one
    JNE delay16

    LDA note_c4       
    STA &FFD          
    LDA delay
delay17
    SUB one
    JNE delay17

    LDA note_e4       
    STA &FFD          
    LDA delay
delay18
    SUB one
    JNE delay18

    ; Seventh segment: aa bb
    LDA note_c4       
    STA &FFD          
    LDA delay
delay19
    SUB one
    JNE delay19

    LDA note_c4       
    STA &FFD          
    LDA delay
delay20
    SUB one
    JNE delay20

    LDA note_e4       
    STA &FFD          
    LDA delay
delay21
    SUB one
    JNE delay21

    LDA note_e4       
    STA &FFD          
    LDA delay
delay22
    SUB one
    JNE delay22

    LDA lights_all
    STA &FFF

    ; Eighth segment: aa b
    LDA note_c4       
    STA &FFD          
    LDA delay
delay23
    SUB one
    JNE delay23

    LDA note_c4       
    STA &FFD          
    LDA delay
delay24
    SUB one
    JNE delay24

    LDA note_e4       
    STA &FFD          
    LDA delay
delay25
    SUB one
    JNE delay25

    LDA lights_off    ; Turn off the lights
    STA &FFF

    JMP main_loop     ; Go back to main loop



;
;
;   ---- Pattern for song 2 ----
;
;

play_song2
    LDA lights_green
    STA &FFF
    ; First note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay26
    SUB one
    JNE delay26

    ; Second note: A4
    LDA note_a4       
    STA &FFD          
    LDA delay
delay27
    SUB one
    JNE delay27

    ; Third note: B4
    LDA note_b4       
    STA &FFD          
    LDA delay
delay28
    SUB one
    JNE delay28

    ; Fourth note: D5
    LDA note_d5       
    STA &FFD          
    LDA delay
delay29
    SUB one
    JNE delay29

    LDA lights_all
    STA &FFF

    ; Fifth note: G4 (repeat)
    LDA note_g4       
    STA &FFD          
    LDA delay
delay30
    SUB one
    JNE delay30

    ; Sixth note: F#4
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay31
    SUB one
    JNE delay31

    ; Seventh note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay32
    SUB one
    JNE delay32

    ; Eighth note: C5
    LDA note_c5       
    STA &FFD          
    LDA delay
delay33
    SUB one
    JNE delay33

    ; Ninth note: A4 (repeat)
    LDA note_a4       
    STA &FFD          
    LDA delay
delay34
    SUB one
    JNE delay34

    LDA lights_red
    STA &FFF

    ; Tenth note: G4 (repeat)
    LDA note_g4       
    STA &FFD          
    LDA delay
delay35
    SUB one
    JNE delay35

    ; Eleventh note: D5 (repeat)
    LDA note_d5       
    STA &FFD          
    LDA delay
delay36
    SUB one
    JNE delay36

    ; Twelfth note: F#4
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay37
    SUB one
    JNE delay37

    ; Thirteenth note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay38
    SUB one
    JNE delay38

    LDA lights_yellow
    STA &FFF

    ; Fourteenth note: A4
    LDA note_a4       
    STA &FFD          
    LDA delay
delay39
    SUB one
    JNE delay39

    ; Fifteenth note: B4
    LDA note_b4       
    STA &FFD          
    LDA delay
delay40
    SUB one
    JNE delay40

    ; Sixteenth note: C5
    LDA note_c5       
    STA &FFD          
    LDA delay
delay41
    SUB one
    JNE delay41

    ; Seventeenth note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay42
    SUB one
    JNE delay42

    LDA lights_green
    STA &FFF

    ; Eighteenth note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay43
    SUB one
    JNE delay43

    ; Nineteenth note: D5
    LDA note_d5       
    STA &FFD          
    LDA delay
delay44
    SUB one
    JNE delay44

    ; Twentieth note: F#4
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay45
    SUB one
    JNE delay45

    ; Twenty-first note: A4
    LDA note_a4       
    STA &FFD          
    LDA delay
delay46
    SUB one
    JNE delay46

    LDA lights_all
    STA &FFF

    ; Twenty-second note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay47
    SUB one
    JNE delay47

    ; Twenty-third note: B4
    LDA note_b4       
    STA &FFD          
    LDA delay
delay48
    SUB one
    JNE delay48

    ; Twenty-fourth note: C5
    LDA note_c5       
    STA &FFD          
    LDA delay
delay49
    SUB one
    JNE delay49

    ; Twenty-fifth note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay50
    SUB one
    JNE delay50

    LDA lights_off
    STA &FFF

    JMP main_loop



;
;
;   ---- Pattern for song 3 ----
;
;

play_song3
    LDA lights_red
    STA &FFF

    ; First note: C4
    LDA note_c4       
    STA &FFD          
    LDA delay
delay51
    SUB one
    JNE delay51

    ; Second note: D4
    LDA note_d4       
    STA &FFD          
    LDA delay
delay52
    SUB one
    JNE delay52

    ; Third note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay53
    SUB one
    JNE delay53

    ; Fourth note: F#4
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay54
    SUB one
    JNE delay54

    LDA lights_yellow
    STA &FFF

    ; Fifth note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay55
    SUB one
    JNE delay55

    ; Sixth note: A4
    LDA note_a4       
    STA &FFD          
    LDA delay
delay56
    SUB one
    JNE delay56

    ; Seventh note: B4
    LDA note_b4       
    STA &FFD          
    LDA delay
delay57
    SUB one
    JNE delay57

    ; Eighth note: C5
    LDA note_c5       
    STA &FFD          
    LDA delay
delay58
    SUB one
    JNE delay58
    
    LDA lights_all
    STA &FFF

    ; Ninth note: B4 (repeat)
    LDA note_b4       
    STA &FFD          
    LDA delay
delay59
    SUB one
    JNE delay59

    ; Tenth note: A4 (repeat)
    LDA note_a4       
    STA &FFD          
    LDA delay
delay60
    SUB one
    JNE delay60

    ; Eleventh note: G4 (repeat)
    LDA note_g4       
    STA &FFD          
    LDA delay
delay61
    SUB one
    JNE delay61

    ; Twelfth note: F#4 (repeat)
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay62
    SUB one
    JNE delay62

    ; Thirteenth note: E4 (repeat)
    LDA note_e4       
    STA &FFD          
    LDA delay
delay63
    SUB one
    JNE delay63

    LDA lights_yellow
    STA &FFF

    ; Fourteenth note: D4 (repeat)
    LDA note_d4       
    STA &FFD          
    LDA delay
delay64
    SUB one
    JNE delay64

    ; Fifteenth note: C4 (repeat)
    LDA note_c4       
    STA &FFD          
    LDA delay
delay65
    SUB one
    JNE delay65

    ; Sixteenth note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay66
    SUB one
    JNE delay66

    ; Seventeenth note: E4
    LDA note_e4       
    STA &FFD          
    LDA delay
delay67
    SUB one
    JNE delay67

    ; Eighteenth note: D4
    LDA note_d4       
    STA &FFD          
    LDA delay
delay68
    SUB one
    JNE delay68

    LDA lights_red
    STA &FFF

    ; Nineteenth note: F#4
    LDA note_fsharp4  
    STA &FFD          
    LDA delay
delay69
    SUB one
    JNE delay69

    ; Twentieth note: A4
    LDA note_a4       
    STA &FFD          
    LDA delay
delay70
    SUB one
    JNE delay70

    ; Twenty-first note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay71
    SUB one
    JNE delay71

    ; Twenty-second note: B4
    LDA note_b4       
    STA &FFD          
    LDA delay
delay72
    SUB one
    JNE delay72

    LDA lights_green
    STA &FFF

    ; Twenty-third note: D5
    LDA note_d5       
    STA &FFD          
    LDA delay
delay73
    SUB one
    JNE delay73

    ; Twenty-fourth note: C5
    LDA note_c5       
    STA &FFD          
    LDA delay
delay74
    SUB one
    JNE delay74

    ; Twenty-fifth note: G4
    LDA note_g4       
    STA &FFD          
    LDA delay
delay75
    SUB one
    JNE delay75

    LDA lights_off    ; Turn off the lights
    STA &FFF

    JMP main_loop     ; Go back to main loop



;
;
;   ---- Declaring data ----
;
;

delay         DEFW &FFFF 
one            DEFW &0001   
zero_display  DEFW &0C3F  ; Pattern for displaying '0' on multi-segment display
one_display   DEFW &1200  ; Pattern for displaying '1' on multi-segment display (bits 9 and 12 on)
two_display   DEFW &00DB  ; Pattern for displaying '2' on multi-segment display
three_display DEFW &00CF  ; Pattern for displaying '3' on multi-segment display
four_display  DEFW &00E6  ; Pattern for displaying '4' on multi-segment display
five_display  DEFW &00ED  ; Pattern for displaying '5' on multi-segment display
six_display   DEFW &00FD  ; Pattern for displaying '6' on multi-segment display
seven_display DEFW &1401  ; Pattern for displaying '7' on multi-segment display (bits 0, 10, and 11 on)
eight_display DEFW &00FF  ; Pattern for displaying '8' on multi-segment display
nine_display  DEFW &00EF  ; Pattern for displaying '9' on multi-segment display

zero_key      DEFW &0001  ; Keypad value for '0'
one_key       DEFW &0002  ; Keypad value for '1'
two_key       DEFW &0004  ; Keypad value for '2'
three_key     DEFW &0008  ; Keypad value for '3'
four_key      DEFW &0010  ; Keypad value for '4'
five_key      DEFW &0020  ; Keypad value for '5'
six_key       DEFW &0040  ; Keypad value for '6'
seven_key     DEFW &0080  ; Keypad value for '7'
eight_key     DEFW &0100  ; Keypad value for '8'
nine_key      DEFW &0200  ; Keypad value for '9'

note_c4        DEFW &9800 ; Mode = 1, Octave = 4, Note = 0 (C), Duration = 8 (0.8 seconds)
note_d4        DEFW &9812 ; Mode = 1, Octave = 4, Note = 2 (D), Duration = 2 (0.2 seconds)
note_e4        DEFW &9924 ; Mode = 1, Octave = 4, Note = 4 (E), Duration = 2 (0.2 seconds)
note_g4        DEFW &9A07 ; Mode = 1, Octave = 4, Note = 7 (G), Duration = 7 (0.7 seconds)
note_a4        DEFW &9A18 ; Mode = 1, Octave = 4, Note = 9 (A), Duration = 8 (0.8 seconds)
note_b4        DEFW &9A1B ; Mode = 1, Octave = 4, Note = 11 (B), Duration = 8 (0.8 seconds)
note_c5        DEFW &9B00 ; Mode = 1, Octave = 5, Note = 0 (C), Duration = 8 (0.8 seconds)
note_d5        DEFW &9B12 ; Mode = 1, Octave = 5, Note = 2 (D), Duration = 2 (0.2 seconds)
note_fsharp4   DEFW &9A16 ; Mode = 1, Octave = 4, Note = 6 (F#), Duration = 6 (0.6 seconds)

note_do       DEFW &9830  ; Mode = 1, Octave = 4, Note = 0 (C), Duration = 4 (0.4 seconds)
note_re       DEFW &9832  ; Mode = 1, Octave = 4, Note = 2 (D), Duration = 4 (0.4 seconds)
note_mi       DEFW &9834  ; Mode = 1, Octave = 4, Note = 4 (E), Duration = 4 (0.4 seconds)
note_fa       DEFW &9835  ; Mode = 1, Octave = 4, Note = 5 (F), Duration = 4 (0.4 seconds)
note_sol      DEFW &9837  ; Mode = 1, Octave = 4, Note = 7 (G), Duration = 4 (0.4 seconds)
note_la       DEFW &9839  ; Mode = 1, Octave = 4, Note = 9 (A), Duration = 4 (0.4 seconds)
note_si       DEFW &983B  ; Mode = 1, Octave = 4, Note = 11 (B), Duration = 4 (0.4 seconds)


lights_off       DEFW &0000 ; 00000_000_000_00_000
lights_green     DEFW &0131 ; 00000_001_001_10_001
lights_yellow    DEFW &0242 ; 00000_010_010_00_010
lights_red       DEFW &048C ; 00000_100_100_01_100
lights_all       DEFW &07FF ; 00000_111_111_11_111