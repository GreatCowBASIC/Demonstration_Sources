;Décodeur NEC 32 bits
;protocole NEC caractérisé par un start de 9 ms
;NEC IR Remote Control Library for GCBASIC

;Thierry Lancelot
;Version 1.0 -- 11/2026

;This include file will let you easily read and use the
;infrared signals from a NEC compatible television remote
;control. In particular, the remote control transmits a
;pulse modulated signal, the sensor detects this, and the
;subroutine in this header file decodes the signal,
;returning two numbers: one representing the device
;(television, VCR, DVD, tuner, etc.), while the the other
;returns the key which has been depressed (VOL+, MUTE,
;channel numbers 0 through 9, etc.).

;This has been tested and confirmed with a remote control NEC/YAMAHA

; 38 kHz IR sensor will  work.
;The only tricky bit is making sure you get the pinout
;for your sensor correct; search out the datasheet for
;whichever device you use. There are only three pins:
;Ground
;Vcc
;Data

;It is essential to filter the power applied to the Vcc pin.
;Do this by connecting a 100 ohm resistor from the +5V power
;supply to the Vcc pin, and bridge the pin to ground with a
;47uF electrolytic capacitor.

;The Data pin often requires a 10 kΩ pull-up resistor.

;There is only one constant required of the calling program.
;It indicates which port line the IR sensor is connected to.
;For example,

;#DEFINE IR_DATA_PIN PORTA.0

;There is one subroutine:

;readIR_Remote(IR_rem_dev, IR_rem_key)

;The values returned are, respectively, the device number
;mentioned earlier and the key that is currently pressed. Both
;are byte values.

sub readIR_Remote(out IR_rem_dev as byte, out IR_rem_key as byte)

Dim IR_count As Byte
Dim BitIdx As Byte
Dim LowWord As Word
Dim HighWord As Word

    ; --- 1. Vérification du start NEC (9ms bas) ---
    retour:
    Do
        IR_count = 0     
        Do While IR_DATA_PIN = 0
            Wait 100 uS 
            IR_count = IR_count + 1
        Loop
    Loop While IR_count < 85  

    ; --- 2. Vérification d'un appui simple ---
    IR_count = 0
    Do While IR_DATA_PIN = 1
       Wait 100 uS
       IR_count = IR_count + 1
    Loop
    If IR_count < 30 Then   
       goto retour
    End If

    LowWord = 0
    HighWord = 0
    
    ; --- 3. Lecture séquentielle des 32 bits ---
    For BitIdx = 1 to 32
        Do While IR_DATA_PIN = 0 ; attente de sortir du niveau bas pour commencer le comptage
        ; on ne fait rien, on attend dans la boucle
        Loop
        
        IR_count = 0
        Do While IR_DATA_PIN = 1
            Wait 100 uS
            IR_count = IR_count + 1
            If IR_count > 30 Then Exit Do  ;securité anti-blocage (timeout)
        Loop            
;Dès que le compteur dépasse 30 (3 ms), la condition If IR_count > 30 devient vraie
;et Exit Do force la sortie immédiate de la boucle.
;Le programme peut ainsi reprendre sa course normale sans rester figé.
        
        If BitIdx <= 16 Then
            LowWord = LowWord * 2
            If IR_count > 12 Then LowWord = LowWord + 1
        Else
            HighWord = HighWord * 2
            If IR_count > 12 Then HighWord = HighWord + 1
        End If
    Next
    
    ; --- Extraction des octets utiles pour isoler l'octet de poids fort ---
    IR_rem_dev = LowWord / 256
    IR_rem_key = HighWord / 256
End Sub