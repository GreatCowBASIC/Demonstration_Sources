/*
 mTouchCVD_8Buttons.h - CVD touch sensing for eight buttons, as Microchip's mTouch Framework v2.3 does it, for the
 mTouch CVD Evaluation Board (PIC16F1937, assembly 02-02091) with the 8-button sensor board (02-02094).
 Shared by GCBASIC_mTouch_Framework_CVD_8Buttons_16F1937.gcb and GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb.
 See GCBASIC_mTouch_Framework_CVD_8Buttons_explained.md for how it works.

 Sensors 0-7 on AN0-AN7: RA0, RA1, RA2, RA3, RA5, RE0, RE1, RE2. Sensor n uses sensor n - 1 as its reference
 (sensor 0 uses sensor 7). The program runs at 32 MHz (the ADC clock and the delays assume it).

 Calls
    TouchInit       the ADC, and every sensor pin an output driven low. Call it first
    TouchStart      each sensor's first reading, then power-up learning. Call it once the pads have settled
                    (after a start-up delay), with nothing on them
    TouchService    call it in the main loop: scans all sensors every TOUCH_PERIOD_MS; TouchNewScan is 1 after a
                    scan, else 0
 Results, per sensor n (0-7)
    TouchState(n)   0 power-up learning, 1 released, 2 pressed
    TouchSums(n)    the last 8-reading sum
    TouchDeltas(n)  how far the last sum was above the baseline (0 when below)
    TouchBaseline(n)

@author    Evan R. Venn
@license   GPL
@version   1.00

1.00  From GCBASIC_mTouch_Framework_CVD_8Buttons_16F1937.gcb 1.00: the CVD reading and decoding as a library, plus
      TouchSums and TouchDeltas for reporting
*/

#include <millis.h>

// ---- Settings
//
// ADCON1: right justified, ADC clock Fosc/32 (1 us at 32 MHz, the framework's setting for 32 MHz), VDD reference.
// ADCON0 for sensor (or reference) n: channel ANn with the ADC on, n * 4 + 1
#DEFINE CVD_ADCON1   0xA0
#DEFINE TOUCH_SENSORS        8
// Press and release, on the 8-sample sum above the baseline (release at half the press, as the framework)
#DEFINE TOUCH_PRESS          250
#DEFINE TOUCH_RELEASE        125
// The slew limit per reading (the framework's MTOUCH_DECIMATION_MAX_STEP)
#DEFINE TOUCH_MAX_STEP       10
// Timing, in scans of TOUCH_PERIOD_MS: power-up learning 0.3 s, baseline updated every 10th scan (1/16 each time),
// a press held 10 s learns again (the framework's MTOUCH_POWER_UP_SAMPLES, MTOUCH_BASELINE_RATE, MTOUCH_BUTTON_TIMEOUT)
#DEFINE TOUCH_PERIOD_MS      10
#DEFINE TOUCH_POWERUP        30
#DEFINE TOUCH_BASELINE_RATE  10
#DEFINE TOUCH_TIMEOUT        1000
// Jitter: up to 63 delay loops before each reading (the framework's MTOUCH_JITTER_BITS 6)
#DEFINE TOUCH_JITTER_MASK    0x3F

// ---- Variables
//
// Per sensor: the slew-limited reading, the baseline, the state (0 power-up, 1 released, 2 pressed), scans counted
// for the power-up and the press time-out, scans counted for the baseline rate, the last sum and delta
Dim TouchFiltered(TOUCH_SENSORS) As Word
Dim TouchBaseline(TOUCH_SENSORS) As Word
Dim TouchState(TOUCH_SENSORS) As Byte
Dim TouchScans(TOUCH_SENSORS) As Word
Dim TouchBaselineScans(TOUCH_SENSORS) As Byte
Dim TouchSums(TOUCH_SENSORS) As Word
Dim TouchDeltas(TOUCH_SENSORS) As Word
// The sensor pin found by CVDPinLookup, the jitter seed, the scan flag, the time
Dim CVDLookupMask, CVDLookupPort As Byte
Dim TouchJitterSeed As Byte
Dim TouchNewScan As Byte
Dim TouchNowMs, TouchLastMs, TouchElapsedMs As Long

// ---- Calls

Sub TouchInit
    // The ADC, and every sensor pin an output driven low between measurements
    Dim TouchInitSensor As Byte
    ADCON1 = CVD_ADCON1
    For TouchInitSensor = 0 To TOUCH_SENSORS - 1
        CVDPinLookup TouchInitSensor
        CVDDrive CVDLookupMask, CVDLookupPort, 0
    Next
    TouchNewScan = 0
End Sub

Sub TouchStart
    // RAM is not cleared at reset: every sensor starts at a real reading, in power-up learning (the scans of the
    // next 0.3 s set the baselines)
    Dim TouchStartSensor As Byte
    TouchJitterSeed = 0xA5              // any value but 0
    For TouchStartSensor = 0 To TOUCH_SENSORS - 1
        TouchFiltered(TouchStartSensor) = CVDRead(TouchStartSensor)
        TouchBaseline(TouchStartSensor) = 0
        TouchState(TouchStartSensor) = 0
        TouchScans(TouchStartSensor) = 0
        TouchBaselineScans(TouchStartSensor) = 0
        TouchSums(TouchStartSensor) = 0
        TouchDeltas(TouchStartSensor) = 0
    Next
    TouchNewScan = 0
    TouchLastMs = millis()
End Sub

Sub TouchService
    // A scan of all sensors every TOUCH_PERIOD_MS; TouchNewScan tells the program
    Dim TouchServiceSensor As Byte
    TouchNewScan = 0
    TouchNowMs = millis()
    TouchElapsedMs = TouchNowMs - TouchLastMs
    If TouchElapsedMs >= TOUCH_PERIOD_MS Then
        TouchLastMs = TouchNowMs
        For TouchServiceSensor = 0 To TOUCH_SENSORS - 1
            TouchScanSensor TouchServiceSensor
        Next
        TouchNewScan = 1
    End If
End Sub

// ---- Sensor pins

// Sensor n's pin: its bit mask, on PORTA for sensors 0-4 and PORTE for 5-7
Table CVDPinMasks
    1
    2
    4
    8
    32
    1
    2
    4
End Table

Sub CVDPinLookup(In CVDLookupSensor)
    // Sets CVDLookupMask and CVDLookupPort (0 PORTA, 1 PORTE) for sensor CVDLookupSensor (0 to 7)
    Dim CVDLookupIndex As Byte
    CVDLookupIndex = CVDLookupSensor + 1
    ReadTable CVDPinMasks, CVDLookupIndex, CVDLookupMask
    CVDLookupPort = 0
    If CVDLookupSensor > 4 Then CVDLookupPort = 1
End Sub

Sub CVDDrive(In CVDDriveMask, In CVDDrivePort, In CVDDriveLevel)
    // The pin an output, driven to CVDDriveLevel (0 or 1)
    Dim CVDDriveInverse As Byte
    CVDDriveInverse = Not CVDDriveMask
    If CVDDrivePort = 0 Then
        If CVDDriveLevel = 0 Then
            LATA = LATA And CVDDriveInverse
        Else
            LATA = LATA Or CVDDriveMask
        End If
        TRISA = TRISA And CVDDriveInverse
    Else
        If CVDDriveLevel = 0 Then
            LATE = LATE And CVDDriveInverse
        Else
            LATE = LATE Or CVDDriveMask
        End If
        TRISE = TRISE And CVDDriveInverse
    End If
End Sub

Sub CVDFloat(In CVDFloatMask, In CVDFloatPort)
    // The pin an input: it floats at the level it was driven to
    If CVDFloatPort = 0 Then
        TRISA = TRISA Or CVDFloatMask
    Else
        TRISE = TRISE Or CVDFloatMask
    End If
End Sub

// ---- CVD reading

Function CVDRead(In CVDSensor) As Word
    // One differential reading of sensor CVDSensor: scan B - scan A + 1024 (a touch raises it), as the
    // framework's result (B | 0x400) - A. Each scan: drive the reference and connect CHOLD to it (CHOLD charges),
    // make the sensor an input and connect CHOLD to it (they share their charge), let it settle, convert. The two
    // delays are the framework's CVD_CHOLD_CHARGE_DELAY and CVD_SETTLING_DELAY. The sensor is driven again only once
    // the conversion is done (CHOLD is still connected for part of the first ADC clock)
    Dim CVDRef, CVDSensorMask, CVDSensorPort, CVDRefMask, CVDRefPort As Byte
    Dim CVDSensorChannel, CVDRefChannel As Byte
    Dim CVDPhaseA, CVDPhaseB As Word

    // The reference: the sensor before (sensor 0 uses the last one)
    CVDRef = TOUCH_SENSORS - 1
    If CVDSensor > 0 Then CVDRef = CVDSensor - 1
    CVDPinLookup CVDSensor
    CVDSensorMask = CVDLookupMask
    CVDSensorPort = CVDLookupPort
    CVDPinLookup CVDRef
    CVDRefMask = CVDLookupMask
    CVDRefPort = CVDLookupPort
    CVDSensorChannel = CVDSensor * 4 + 1
    CVDRefChannel = CVDRef * 4 + 1

    IntOff

    // Scan A: CHOLD charged high through the reference; the sensor (low) shares with it
    CVDDrive CVDRefMask, CVDRefPort, 1
    ADCON0 = CVDRefChannel
    Wait 1 us                           // CHOLD charges
    CVDFloat CVDSensorMask, CVDSensorPort
    ADCON0 = CVDSensorChannel
    Wait 1 us                           // the shared charge settles
    Set ADCON0.GO = 1
    Wait While ADCON0.GO = 1
    CVDDrive CVDSensorMask, CVDSensorPort, 1
    CVDPhaseA = ADRESL
    CVDPhaseA_H = ADRESH

    // Scan B: CHOLD discharged through the reference; the sensor (high) shares with it
    CVDDrive CVDRefMask, CVDRefPort, 0
    ADCON0 = CVDRefChannel
    Wait 1 us                           // CHOLD discharges
    CVDFloat CVDSensorMask, CVDSensorPort
    ADCON0 = CVDSensorChannel
    Wait 1 us                           // the shared charge settles
    Set ADCON0.GO = 1
    Wait While ADCON0.GO = 1
    CVDDrive CVDSensorMask, CVDSensorPort, 0
    CVDPhaseB = ADRESL
    CVDPhaseB_H = ADRESH

    IntOn
    CVDRead = CVDPhaseB - CVDPhaseA + 1024
End Function

Sub TouchJitter
    // A random delay of 0 to 63 loops before each reading, from the framework's 8-bit LFSR (shift right, XOR 0xB4
    // when a 1 is shifted out), so the readings do not lock on to noise at a fixed frequency
    Dim TouchJitterCount As Byte
    If TouchJitterSeed.0 = 1 Then
        TouchJitterSeed = TouchJitterSeed / 2
        TouchJitterSeed = TouchJitterSeed Xor 0xB4
    Else
        TouchJitterSeed = TouchJitterSeed / 2
    End If
    TouchJitterCount = TouchJitterSeed And TOUCH_JITTER_MASK
    Do While TouchJitterCount > 0
        TouchJitterCount--
    Loop
End Sub

// ---- Decoding

Sub TouchScanSensor(In TouchScanIndex)
    // One scan of one sensor: eight readings, each after a random delay and each moving the slew-limited value by
    // at most TOUCH_MAX_STEP, summed; then the power-up / released / pressed decision and, while released, the slow
    // baseline
    Dim TouchCount, TouchNowState As Byte
    Dim TouchRaw, TouchValue, TouchUp, TouchDown, TouchSum, TouchBase, TouchDelta, TouchCounted As Word

    TouchValue = TouchFiltered(TouchScanIndex)
    TouchSum = 0
    For TouchCount = 1 To 8
        TouchJitter
        TouchRaw = CVDRead(TouchScanIndex)
        TouchUp = TouchValue + TOUCH_MAX_STEP
        TouchDown = 0
        If TouchValue > TOUCH_MAX_STEP Then TouchDown = TouchValue - TOUCH_MAX_STEP
        If TouchRaw > TouchUp Then
            TouchValue = TouchUp
        Else If TouchRaw < TouchDown Then
            TouchValue = TouchDown
        Else
            TouchValue = TouchRaw
        End If
        TouchSum = TouchSum + TouchValue
    Next
    TouchFiltered(TouchScanIndex) = TouchValue

    // How far above the baseline (0 when below)
    TouchBase = TouchBaseline(TouchScanIndex)
    TouchDelta = 0
    If TouchSum > TouchBase Then TouchDelta = TouchSum - TouchBase

    TouchNowState = TouchState(TouchScanIndex)
    TouchCounted = TouchScans(TouchScanIndex)
    Select Case TouchNowState
        Case 0
            // Power-up (and after a time-out): the baseline follows the sum for TOUCH_POWERUP scans
            TouchBase = TouchSum
            TouchCounted++
            If TouchCounted >= TOUCH_POWERUP Then
                TouchCounted = 0
                TouchBaselineScans(TouchScanIndex) = 0
                TouchNowState = 1
            End If
        Case 1
            // Released: press above TOUCH_PRESS, else the baseline follows slowly (1/16 every TOUCH_BASELINE_RATE
            // scans)
            If TouchDelta >= TOUCH_PRESS Then
                TouchCounted = 0
                TouchNowState = 2
            Else
                TouchBaselineScans(TouchScanIndex) = TouchBaselineScans(TouchScanIndex) + 1
                If TouchBaselineScans(TouchScanIndex) >= TOUCH_BASELINE_RATE Then
                    TouchBaselineScans(TouchScanIndex) = 0
                    TouchBase = TouchBase - TouchBase / 16 + TouchSum / 16
                End If
            End If
        Case 2
            // Pressed: release below TOUCH_RELEASE; held for TOUCH_TIMEOUT scans means something is left on the
            // pad, so learn the baseline again
            If TouchDelta < TOUCH_RELEASE Then
                TouchNowState = 1
            Else
                TouchCounted++
                If TouchCounted >= TOUCH_TIMEOUT Then
                    TouchCounted = 0
                    TouchNowState = 0
                End If
            End If
    End Select
    TouchBaseline(TouchScanIndex) = TouchBase
    TouchState(TouchScanIndex) = TouchNowState
    TouchScans(TouchScanIndex) = TouchCounted
    TouchSums(TouchScanIndex) = TouchSum
    TouchDeltas(TouchScanIndex) = TouchDelta
End Sub
