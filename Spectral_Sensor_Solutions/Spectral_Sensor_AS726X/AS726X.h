#IGNORE
#option Explicit
/*
AS7262 Visible Light 6-channel spectral (visible) sensor
AS7263 Near Infrared Spectral Sensor

Detects six distinct channels of visible light with this spectral sensor. 
Unlike normal RGB colour sensors, with the AS7262 provides six bands of colour readings that roughly translate to red, orange, yellow, green, blue, and violet. The rainbow.

The two onboard white LEDs provides illumination to give more accurate spectral readings and also measure the reflectivity of surfaces. 
The LEDs are typically high-quality ones with a CRI of >=90 and a colour temperature of 4,000K for consistent and accurate colour rendering.

With this sensor, like analysing different light sources, measuring the transmission of light through materials or solutions (with an additional light source).

The AS7262 6-Channel Spectral Sensor Breakout is an I2C interface and is 3.3V or 5V compatible. 

	I2C interface (address: 0x49)
	6 spectral channels (450, 500, 550, 570, 600, 650nm)
	2 onboard illumination LEDs
	3.3V or 5V compatible
	Reverse polarity protection


*/

// C to GCB Conversion vv0.9a 2023


//GET THE VARIOUS COLOR READINGS

	// int AS726X::getViolet() { return(getChannel(AS7262_V)); }
	// int AS726X::getBlue() { return(getChannel(AS7262_B)); }
	// int AS726X::getGreen() { return(getChannel(AS7262_G)); }
	// int AS726X::getYellow() { return(getChannel(AS7262_Y)); }
	// int AS726X::getOrange() { return(getChannel(AS7262_O)); }
	// int AS726X::getRed() { return(getChannel(AS7262_R)); }

	// //Get the various NIR readings
	// int AS726X::getR() { return(getChannel(AS7263_R)); }
	// int AS726X::getS() { return(getChannel(AS7263_S)); }r
	// int AS726X::getT() { return(getChannel(AS7263_T)); }
	// int AS726X::getU() { return(getChannel(AS7263_U)); }
	// int AS726X::getV() { return(getChannel(AS7263_V)); }
	// int AS726X::getW() { return(getChannel(AS7263_W)); }

	//RETURNS THE VARIOUS CALIBRATION DATA

// Constants
	// Determine if user has set an alternative I2C address
	#script
		IF NODEF(AS726X_ADDRESS) THEN
			AS726X_ADDRESS = 0X92
		END IF
	#endscript

	#DEFINE SENSORTYPE_AS7262 		0X3E
	#DEFINE SENSORTYPE_AS7263 		0X3F

	//REGISTER ADDRESSES
	#DEFINE AS726X_DEVICE_TYPE 		0X00
	#DEFINE AS726X_HW_VERSION 		0X01
	#DEFINE AS726X_CONTROL_SETUP 	0X04
	#DEFINE AS726X_INT_T 			0X05
	#DEFINE AS726X_DEVICE_TEMP 		0X06
	#DEFINE AS726X_LED_CONTROL 		0X07
	#DEFINE AS72XX_SLAVE_STATUS_REG 0X00
	#DEFINE AS72XX_SLAVE_WRITE_REG 	0X01
	#DEFINE AS72XX_SLAVE_READ_REG 	0X02

	//THE SAME REGISTER LOCATIONS ARE SHARED BETWEEN THE AS7262 AND AS7263, THEY'RE JUST CALLED SOMETHING DIFFERENT

	//AS7262 REGISTERS
	#DEFINE AS7262_V 0X08
	#DEFINE AS7262_B 0X0A
	#DEFINE AS7262_G 0X0C
	#DEFINE AS7262_Y 0X0E
	#DEFINE AS7262_O 0X10
	#DEFINE AS7262_R 0X12
	#DEFINE AS7262_V_CAL 0X14
	#DEFINE AS7262_B_CAL 0X18
	#DEFINE AS7262_G_CAL 0X1C
	#DEFINE AS7262_Y_CAL 0X20
	#DEFINE AS7262_O_CAL 0X24
	#DEFINE AS7262_R_CAL 0X28

	//AS7263 REGISTERS
	#DEFINE AS7263_R 0X08
	#DEFINE AS7263_S 0X0A
	#DEFINE AS7263_T 0X0C
	#DEFINE AS7263_U 0X0E
	#DEFINE AS7263_V 0X10
	#DEFINE AS7263_W 0X12
	#DEFINE AS7263_R_CAL 0X14
	#DEFINE AS7263_S_CAL 0X18
	#DEFINE AS7263_T_CAL 0X1C
	#DEFINE AS7263_U_CAL 0X20
	#DEFINE AS7263_V_CAL 0X24
	#DEFINE AS7263_W_CAL 0X28

	#DEFINE AS72XX_SLAVE_TX_VALID 0X02
	#DEFINE AS72XX_SLAVE_RX_VALID 0X01
	#DEFINE SENSORTYPE_AS7262 0X3E
	#DEFINE SENSORTYPE_AS7263 0X3F
	#DEFINE POLLING_DELAY 5 ms //AMOUNT OF MS TO WAIT BETWEEN CHECKING FOR VIRTUAL REGISTER CHANGES

//*****************PROCESSED******************************************

#startup AS726X_Init, 95

Sub AS726X_Init ( optional AS726XGain as Byte = 3, optional AS726XMeasurementMode as Byte = 3 )	// ?F2L11S1?

	wait 255 ms             'added to ensure the charge pump and power is operational.
	#IFDEF HI2C_DATA

		Dir HI2C_DATA In
		Dir HI2C_CLOCK In
	
		HI2CMode Master
		Wait 15 ms  'wait for power-up and reset
	#ENDIF

	Dim AS726XSensorVersion, AS726XSensorState as Byte
	AS726XSensorVersion = 0
	AS726XSensorState = False

	AS726XSensorVersion = AS726x_VirtualReadRegister( AS726X_HW_VERSION )  // ?F2L14S1?

	IF ( AS726XSensorVersion <> SENSORTYPE_AS7262 & AS726XSensorVersion <> SENSORTYPE_AS7263 )  Then // HW VERSION FOR AS7262 AND AS7263	// ?F2L15S1?
		AS726XSensorState = False
		Exit Sub
	End If

	AS726X_SetBulbCurrent(0b00); //SET TO 12.5MA (MINIMUM)	// ?F2L20S1?
	AS726X_Disablebulb(); //TURN OFF TO AVOID HEATING THE SENSOR	// ?F2L21S1?
	AS726X_SetIndicatorCurrent(0b11); //SET TO 8MA (MAXIMUM)	// ?F2L23S1?
	AS726X_DisableIndicator(); //TURN OFF LIGHTS TO SAVE POWER	// ?F2L24S1?
	AS726X_SetIntegrationTime(50); //50 * 2.8MS = 140MS. 0 TO 255 IS VALID.	// ?F2L26S1?
	AS726X_SetGain( AS726XGain ); //SET GAIN TO 64X	// ?F2L29S1?
	AS726X_SetMeasurementMode( AS726XMeasurementMode ); //ONE-SHOT READING OF VBGYOR	// ?F2L31S1?
	IF (AS726XSensorVersion = 0) Then	// ?F2L33S1?
		AS726XSensorState = False
		Exit Sub
	End If	// ?F2L36S1?
	AS726XSensorState = True	// ?F2L37S1?

	End Sub

Function AS726X_GetVersion() As Byte	// ?F2L40S20?
	
	AS726X_GetVersion = AS726XSensorVersion;	// ?F2L42S20?
	
	End Function	// ?F2L43S20?

Sub AS726X_SetMeasurementMode( AS726XMeasurementMode )	// ?F2L50S3?

	Dim AS726XValue as Byte

	IF ( AS726XMeasurementMode > 0b11 ) Then AS726XMeasurementMode = 0b11;	// ?F2L52S3?
	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L55S3?
	AS726XValue = AS726XValue & 0b11110011; //CLEAR BANK BITS	// ?F2L56S3?

	AS726XValue.3 = AS726XMeasurementMode.1 ; VALUE |= (MODE << 2) //SET BANK BITS WITH USER'S CHOICE	// ?F2L57S3?
	AS726XValue.2 = AS726XMeasurementMode.0
	
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue); //WRITE	// ?F2L58S3?

	End Sub	// ?F2L59S3?

Sub AS726X_SetGain( in AS726XGain)	// ?F2L66S4?

	Dim AS726XValue as Byte

	IF ( AS726XGain > 0b11) Then AS726XGain = 0b11;	// ?F2L68S4?
	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L71S4?
	AS726XValue = AS726XValue & 0b11001111; //CLEAR GAIN BITS	// ?F2L72S4?
	
	AS726XValue.5 = AS726XValue.1 //SET GAIN BITS WITH USER'S CHOICE	// ?F2L73S4?
	AS726XValue.4 = AS726XValue.0 //SET GAIN BITS WITH USER'S CHOICE	// ?F2L73S4?
	
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue); //WRITE	// ?F2L74S4?

	End Sub	// ?F2L75S4?

	// Integration time = <value> * 2.8ms
Sub AS726X_SetIntegrationTime( AS726XValue as Byte )	// ?F2L80S5?
	AS726x_VirtualWriteRegister(AS726X_INT_T, AS726XValue); //WRITE	// ?F2L82S5?
	End Sub	// ?F2L83S5?

Sub AS726X_EnableInterrupt()	// ?F2L85S6?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L88S6?
	AS726XValue.6 = 1 // VALUE |= 0b01000000; //SET INT BIT	// ?F2L89S6?
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue); //WRITE	// ?F2L90S6?

	End Sub	// ?F2L91S6?

Sub AS726X_DisableInterrupt()	// ?F2L94S7?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP) 
	AS726XValue.6 = 0 // VALUE &= 0b10111111; //CLEAR INT BIT	// ?F2L98S7?
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue)

	End Sub	// ?F2L100S7?

Sub AS726X_TakeMeasurements()	// ?F2L103S8?
	
	AS726X_ClearDataAvailable(); //CLEAR DATA_RDY FLAG WHEN USING MODE 3	// ?F2L105S8?
	AS726X_SetMeasurementMode(3);	// ?F2L108S8?
	Do WHILE ( AS726X_DataAvailable() = 0 ) 
		Wait POLLING_DELAY;	// ?F2L111S8?
	Loop
	End Sub	// ?F2L114S8?

Sub AS726X_TakeMeasurementsWithBulb()	// ?F2L117S9?
	AS726X_EnableBulb(); //TURN ON BULB TO TAKE MEASUREMENT	// ?F2L122S9?
	AS726X_TakeMeasurements();	// ?F2L124S9?
	AS726X_DisableBulb(); //TURN OFF BULB TO AVOID HEATING SENSOR	// ?F2L126S9?
	End Sub	// ?F2L128S9?

Function AS7262_GetCalibratedViolet as Single

	Return AS726X_GetCalibrated(AS7262_V_CAL)
	
	End Function

Function AS7262_GetCalibratedBlue as Single

	Return AS726X_GetCalibrated(AS7262_B_CAL)
	
	End Function

Function AS7262_GetCalibratedGreen as Single

	Return AS726X_GetCalibrated(AS7262_G_CAL)
	
	End Function
	
Function AS7262_GetCalibratedYellow as Single

	Return AS726X_GetCalibrated(AS7262_Y_CAL)
	
	End Function

Function AS7262_GetCalibratedOrange as Single

	Return AS726X_GetCalibrated(AS7262_O_CAL)
	
	End Function

Function AS7262_GetCalibratedRed as Single

	Return AS726X_GetCalibrated(AS7262_R_CAL)
	
	End Function

Function AS7263_GetCalibratedR as Single

	Return AS726X_GetCalibrated(AS7263_R_CAL)
	
	End Function

Function AS7263_GetCalibratedS as Single

	Return AS726X_GetCalibrated(AS7263_S_CAL)
	
	End Function

Function AS7263_GetCalibratedT as Single

	Return AS726X_GetCalibrated(AS7263_T_CAL)
	
	End Function
	
Function AS7263_GetCalibratedU as Single

	Return AS726X_GetCalibrated(AS7263_U_CAL)
	
	End Function

Function AS7263_GetCalibratedV as Single

	Return AS726X_GetCalibrated(AS7263_V_CAL)
	
	End Function

Function AS7263_GetCalibratedW as Single

	Return AS726X_GetCalibrated(AS7263_W_CAL)
	
	End Function

Function AS726X_GetCalibrated ( AS726XCalAddress as Byte ) as Single	// ?F2L170S28?
		
	AS726X_GetCalibrated_E = AS726x_VirtualReadRegister(AS726XCalAddress + 0);	// ?F2L173S28?
	AS726X_GetCalibrated_U = AS726x_VirtualReadRegister(AS726XCalAddress + 1);	// ?F2L174S28?
	AS726X_GetCalibrated_H = AS726x_VirtualReadRegister(AS726XCalAddress + 2);	// ?F2L175S28?
	[Byte]AS726X_GetCalibrated   = [Byte]AS726x_VirtualReadRegister(AS726XCalAddress + 3);	// ?F2L176S28?
	wait 25 ms
	End Function	// ?F2L186S28?


Function  AS726X_DataAvailable()	// ?F2L197S2?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP);	// ?F2L199S2?
	
	AS726X_DataAvailable = AS726XValue.1 // (VALUE & (1 << 1)); //BIT 1 IS DATA_RDY	// ?F2L200S2?

	End Function	// ?F2L201S2?

Sub AS726X_ClearDataAvailable()	// ?F2L205S10?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP);	// ?F2L207S10?
	AS726XValue.1 = 1 // VALUE &= ~(1 << 1); //SET THE DATA_RDY BIT	// ?F2L208S10?
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue);	// ?F2L209S10?

	End Sub	// ?F2L210S10?

Sub AS726X_EnableIndicator()	// ?F2L213S11?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL)
	AS726XValue.0 = 1
	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726XValue)

	End Sub	// ?F2L228S12?


Sub AS726X_DisableIndicator()	// ?F2L222S12?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L225S12?
	AS726XValue.0 = 0 ; //CLEAR THE BIT	// ?F2L226S12?
	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726XValue);	// ?F2L227S12?

	End Sub	// ?F2L228S12?

Sub AS726X_SetIndicatorCurrent( in AS726xCurrent )	// ?F2L231S13?

	Dim AS726XValue as Byte

	IF ( AS726xCurrent > 0b11)  Then AS726xCurrent = 0b11;	// ?F2L233S13?

	AS726XValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL); //READ	// ?F2L235S13?
	; //CLEAR ICL_IND BITS	// ?F2L236S13?
	; //SET ICL_IND BITS WITH USER'S CHOICE	// ?F2L237S13?

	AS726XValue.1 = AS726xCurrent.1
	AS726XValue.2 = AS726xCurrent.0

	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726XValue); //WRITE	// ?F2L238S13?

	End Sub	// ?F2L239S13?

Sub AS726X_EnableBulb()	// ?F2L242S14?

	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L245S14?
	AS726XValue.3 = 1 //VALUE |= (1 << 3); //SET THE BIT	// ?F2L246S14?
	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726XValue);	// ?F2L247S14?

	End Sub	// ?F2L248S14?

Sub AS726X_DisableBulb()	// ?F2L251S15?
	
	Dim AS726XValue as Byte

	AS726XValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L254S15?
	AS726XValue.3 = 0 // &= ~(1 << 3); //CLEAR THE BIT	// ?F2L255S15?
	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726XValue);	// ?F2L256S15?
	
	End Sub	// ?F2L257S15?

Sub AS726X_SetBulbCurrent( AS726xCurrent )	// ?F2L264S16?
	
	Dim AS726xValue as Byte

	IF ( AS726xCurrent > 0b11 ) Then AS726xCurrent = 0b11; //LIMIT TO TWO BITS	// ?F2L266S16?
	
	AS726xValue = AS726x_VirtualReadRegister(AS726X_LED_CONTROL); //READ	// ?F2L269S16?
	AS726xValue = AS726xValue & 0b11001111; //CLEAR ICL_DRV BITS	// ?F2L270S16?
	AS726xValue = AS726xValue | FnLSL ( AS726xCurrent, 4); //SET ICL_DRV BITS WITH USER'S CHOICE	// ?F2L271S16?
	AS726x_VirtualWriteRegister(AS726X_LED_CONTROL, AS726xValue); //WRITE	// ?F2L272S16?
	
	End Sub	// ?F2L273S16?

Function AS726X_GetTemperature() As Byte	// ?F2L277S21?

	Return (AS726x_VirtualReadRegister(AS726X_DEVICE_TEMP));	// ?F2L279S21?

	End Function	// ?F2L280S21?

Sub AS726X_SoftReset()	// ?F2L292S17?
	
	Dim AS726XValue as Byte
	
	AS726XValue = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L295S17?
	AS726XValue.7 = 1  // VALUE |= (1 << 7); //SET RST BIT	// ?F2L296S17?
	AS726x_VirtualWriteRegister(AS726X_CONTROL_SETUP, AS726XValue); //WRITE	// ?F2L297S17?
	
	End Sub	// ?F2L298S17?

Function AS726x_VirtualReadRegister( In AS726xVirtualaddr As Byte) As Byte

	Dim AS726xError, AS726x_Status, AS726x_Incoming as Byte
	AS726x_Status = AS726x_ReadRegister(AS72XX_SLAVE_STATUS_REG)

	If ((AS726x_Status & AS72XX_SLAVE_RX_VALID) <> 0) Then 				//THERE IS DATA TO BE READ	
		AS726x_Incoming = AS726x_ReadRegister(AS72XX_SLAVE_READ_REG) 	//READ BUT DO NOTHING WITH IT	
	End If

	AS726xError = 0
	Do	

		AS726x_Status = AS726x_ReadRegister(AS72XX_SLAVE_STATUS_REG);	

		IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then
			AS726xError = 0
			Exit Do; // IF TX BIT IS CLEAR, IT IS OK TO WRITE	
		Else
			Wait POLLING_DELAY
			AS726xError++
		End If
	Loop While !AS726xError

	AS726x_WriteRegister(AS72XX_SLAVE_WRITE_REG, AS726xVirtualaddr)
	AS726xError = 0
	Do
		
		AS726x_Status = AS726x_ReadRegister(AS72XX_SLAVE_STATUS_REG)
		IF ((AS726x_Status & AS72XX_SLAVE_RX_VALID) <> 0) Then
			AS726xError = 0
			Exit Do ; // READ DATA IS READY.	
		Else
			Wait POLLING_DELAY
			AS726xError++
		End If
	Loop While !AS726xError 

	AS726x_VirtualReadRegister = AS726x_ReadRegister(AS72XX_SLAVE_READ_REG)
	// Always returns AS726xError for examination
	End Function	// ?F2L334S22?

Sub AS726x_VirtualWriteRegister( AS726xVirtualaddr, DATATOWRITE)	// ?F2L337S18?
	Dim AS726x_Status, AS726xError as Byte;	// ?F2L339S18?

	AS726xError = 0
	Do	// ?F2L342S18?
		// ?F2L343S18?
		AS726x_Status = AS726x_ReadRegister(AS72XX_SLAVE_STATUS_REG);	// ?F2L344S18?
		IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then 
			Exit Do // NO INBOUND TX PENDING AT SLAVE. OKAY TO WRITE NOW.	// ?F2L345S18?
		Else
			AS726xError++
			Wait POLLING_DELAY;	// ?F2L346S18?
		End If
	Loop While !AS726xError	// ?F2L347S18?

	AS726x_WriteRegister(AS72XX_SLAVE_WRITE_REG, (AS726xVirtualaddr | 0X80));	// ?F2L350S18?
	
	Do	// ?F2L353S18?
		// ?F2L354S18?
		AS726x_Status = AS726x_ReadRegister(AS72XX_SLAVE_STATUS_REG);	// ?F2L355S18?
		IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then // NO INBOUND TX PENDING AT SLAVE. OKAY TO WRITE NOW.	// ?F2L356S18?
			Exit Do
		Else
			AS726xError++
			Wait POLLING_DELAY;	// ?F2L357S18?
		End If
	Loop While !AS726xError	// ?F2L358S18?

	AS726x_WriteRegister(AS72XX_SLAVE_WRITE_REG, DATATOWRITE);	// ?F2L361S18?
	// Always returns AS726xError for examination
	End Sub	// ?F2L362S18?

Function AS726x_ReadRegister( AS726XRegisterAddr ) As Byte	// ?F2L365S23?

	#ifdef HI2C_DATA

		do
			HI2CStart                            	// generate a start signal
			HI2CSend(AS726X_ADDRESS)               		// indicate a write				
		loop While HI2CAckPollState
		HI2CSend(AS726XRegisterAddr)                // send register address

		HI2CStart
		HI2CSend(AS726X_ADDRESS + 1)               	// set the read flag

		HI2CReceive(AS726x_ReadRegister, NACK)     	// read one byte and conclude
			// Hsersend "<"
			// HserPrint AS726x_ReadRegister
			// Hserprint ">"
		HI2CStop
	#endif

	#ifdef I2C_DATA
		I2CStart                              		// generate a start signal
		I2CSend(AS726X_ADDRESS)                     // indicate a write
		I2CSend(AS726XRegisterAddr)					// send register address
		I2CReStart
		I2CSend(AS726X_ADDRESS + 1)                 // set the read flag
		I2CReceive(AS726x_ReadRegister, NACK)        // read one byte and conclude
		I2CStop
		I2CAckPoll(AS726X_ADDRESS)          		// wait for buffer write
	#endif
	
	End Function	// ?F2L379S23?

Sub AS726x_WriteRegister( in AS726XRegisterAddr, in AS726XVal)	// ?F2L382S19

	#ifdef HI2C_DATA
		do
			HI2CReStart                            	// generate a start signal
			HI2CSend(AS726X_ADDRESS)               		// indicate a write
		loop While HI2CAckPollState
		HI2CSend(AS726XRegisterAddr)                // send address as two bytes
		HI2CSend(AS726XVal)                         // then the value
		HI2CStop
	#endif

	#ifdef I2C_DATA

		I2CStart                                     // generate a start signal
		I2CSend(AS726X_ADDRESS)                      // indicate a write
		I2CSend(AS726XRegisterAddr)                  // send address as two bytes
		I2CSend(AS726XVal)                           // then the value
		I2CStop
		I2CAckPoll(AS726X_ADDR)
	#endif

	End Sub	// ?F2L388S19?
