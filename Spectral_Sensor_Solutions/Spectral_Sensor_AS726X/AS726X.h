#IGNORE
#option Explicit
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

Sub AS726X_BEGIN
End Sub

#startup AS726X_Init, 95

	Sub AS726X_Init ( optional t_gain as Byte = 3, optional t_measurementmode as Byte = 3 )	// ?F2L11S1?

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

		IF ( AS726XSensorVersion <> 0X3E & AS726XSensorVersion <> 0X3F )  Then // HW VERSION FOR AS7262 AND AS7263	// ?F2L15S1?
			AS726XSensorState = False
			Exit Sub
		End If
	
		SetBulbCurrent(0b00); //SET TO 12.5MA (MINIMUM)	// ?F2L20S1?
	// 	DISABLEBULB(); //TURN OFF TO AVOID HEATING THE SENSOR	// ?F2L21S1?
	// 	SETINDICATORCURRENT(0B11); //SET TO 8MA (MAXIMUM)	// ?F2L23S1?
	// 	DISABLEINDICATOR(); //TURN OFF LIGHTS TO SAVE POWER	// ?F2L24S1?
	// 	SETINTEGRATIONTIME(50); //50 * 2.8MS = 140MS. 0 TO 255 IS VALID.	// ?F2L26S1?
	// 	SETGAIN(GAIN); //SET GAIN TO 64X	// ?F2L29S1?
	// 	SETMEASUREMENTMODE(MEASUREMENTMODE); //ONE-SHOT READING OF VBGYOR	// ?F2L31S1?
		IF (AS726XSensorVersion = 0) Then	// ?F2L33S1?
			AS726XSensorState = False
			Exit Sub
		End If	// ?F2L36S1?
		AS726XSensorState = True	// ?F2L37S1?
	
		End Sub

	// Function GETVERSION() As Byte	// ?F2L40S20?
	// 	RETURN AS726XSensorVersion;	// ?F2L42S20?
	// End Function	// ?F2L43S20?

	// Sub SETMEASUREMENTMODE(UINT8_T MODE)	// ?F2L50S3?
	// 	IF (MODE > 0B11) MODE = 0B11;	// ?F2L52S3?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L55S3?
	// 	VALUE &= 0B11110011; //CLEAR BANK BITS	// ?F2L56S3?
	// 	VALUE |= (MODE << 2); //SET BANK BITS WITH USER'S CHOICE	// ?F2L57S3?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE); //WRITE	// ?F2L58S3?
	// End Sub	// ?F2L59S3?

	// Sub SETGAIN(UINT8_T GAIN)	// ?F2L66S4?
	// 	IF (GAIN > 0B11) GAIN = 0B11;	// ?F2L68S4?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L71S4?
	// 	VALUE &= 0B11001111; //CLEAR GAIN BITS	// ?F2L72S4?
	// 	VALUE |= (GAIN << 4); //SET GAIN BITS WITH USER'S CHOICE	// ?F2L73S4?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE); //WRITE	// ?F2L74S4?
	// End Sub	// ?F2L75S4?

	// Sub SETINTEGRATIONTIME(UINT8_T INTEGRATIONVALUE)	// ?F2L80S5?
	// 	AS726xVirtualWriteRegister(AS726X_INT_T, INTEGRATIONVALUE); //WRITE	// ?F2L82S5?
	// End Sub	// ?F2L83S5?

	// Sub ENABLEINTERRUPT()	// ?F2L85S6?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L88S6?
	// 	VALUE |= 0B01000000; //SET INT BIT	// ?F2L89S6?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE); //WRITE	// ?F2L90S6?
	// End Sub	// ?F2L91S6?

	// Sub DISABLEINTERRUPT()	// ?F2L94S7?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L97S7?
	// 	VALUE &= 0B10111111; //CLEAR INT BIT	// ?F2L98S7?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE); //WRITE	// ?F2L99S7?
	// End Sub	// ?F2L100S7?

	// Sub TAKEMEASUREMENTS()	// ?F2L103S8?
	// 	CLEARDATAAVAILABLE(); //CLEAR DATA_RDY FLAG WHEN USING MODE 3	// ?F2L105S8?
	// 	SETMEASUREMENTMODE(3);	// ?F2L108S8?
	// 	WHILE (DATAAVAILABLE() == FALSE) Wait POLLING_DELAY;	// ?F2L111S8?
	// End Sub	// ?F2L114S8?

	// Sub TAKEMEASUREMENTSWITHBULB()	// ?F2L117S9?
	// 	ENABLEBULB(); //TURN ON BULB TO TAKE MEASUREMENT	// ?F2L122S9?
	// 	TAKEMEASUREMENTS();	// ?F2L124S9?
	// 	DISABLEBULB(); //TURN OFF BULB TO AVOID HEATING SENSOR	// ?F2L126S9?
	// End Sub	// ?F2L128S9?

	// FLOAT AS726X::GETCALIBRATEDVIOLET() { RETURN(GETCALIBRATEDVALUE(AS7262_V_CAL)); }	// ?F2L155S24?
	// FLOAT AS726X::GETCALIBRATEDBLUE() { RETURN(GETCALIBRATEDVALUE(AS7262_B_CAL)); }	// ?F2L156S24?
	// FLOAT AS726X::GETCALIBRATEDGREEN() { RETURN(GETCALIBRATEDVALUE(AS7262_G_CAL)); }	// ?F2L157S24?
	// FLOAT AS726X::GETCALIBRATEDYELLOW() { RETURN(GETCALIBRATEDVALUE(AS7262_Y_CAL)); }	// ?F2L158S25?
	// FLOAT AS726X::GETCALIBRATEDORANGE() { RETURN(GETCALIBRATEDVALUE(AS7262_O_CAL)); }	// ?F2L159S25?
	// FLOAT AS726X::GETCALIBRATEDRED() { RETURN(GETCALIBRATEDVALUE(AS7262_R_CAL)); }	// ?F2L160S25?
	// FLOAT AS726X::GETCALIBRATEDR() { RETURN(GETCALIBRATEDVALUE(AS7263_R_CAL)); }	// ?F2L162S26?
	// FLOAT AS726X::GETCALIBRATEDS() { RETURN(GETCALIBRATEDVALUE(AS7263_S_CAL)); }	// ?F2L163S26?
	// FLOAT AS726X::GETCALIBRATEDT() { RETURN(GETCALIBRATEDVALUE(AS7263_T_CAL)); }	// ?F2L164S26?
	// FLOAT AS726X::GETCALIBRATEDU() { RETURN(GETCALIBRATEDVALUE(AS7263_U_CAL)); }	// ?F2L165S27?
	// FLOAT AS726X::GETCALIBRATEDV() { RETURN(GETCALIBRATEDVALUE(AS7263_V_CAL)); }	// ?F2L166S27?
	// FLOAT AS726X::GETCALIBRATEDW() { RETURN(GETCALIBRATEDVALUE(AS7263_W_CAL)); }	// ?F2L167S27?
	// FLOAT AS726X::GETCALIBRATEDVALUE(UINT8_T CALADDRESS)	// ?F2L170S28?
	// {	// ?F2L171S28?
	// 	UINT8_T B0, B1, B2, B3;	// ?F2L172S28?
	// 	B0 = AS726x_VirtualReadRegister(CALADDRESS + 0);	// ?F2L173S28?
	// 	B1 = AS726x_VirtualReadRegister(CALADDRESS + 1);	// ?F2L174S28?
	// 	B2 = AS726x_VirtualReadRegister(CALADDRESS + 2);	// ?F2L175S28?
	// 	B3 = AS726x_VirtualReadRegister(CALADDRESS + 3);	// ?F2L176S28?
	// 	UINT32_T CALBYTES = 0;	// ?F2L179S28?
	// 	CALBYTES |= ((UINT32_T)B0 << (8 * 3));	// ?F2L180S28?
	// 	CALBYTES |= ((UINT32_T)B1 << (8 * 2));	// ?F2L181S28?
	// 	CALBYTES |= ((UINT32_T)B2 << (8 * 1));	// ?F2L182S28?
	// 	CALBYTES |= ((UINT32_T)B3 << (8 * 0));	// ?F2L183S28?
	// 	RETURN (CONVERTBYTESTOFLOAT(CALBYTES));	// ?F2L185S28?
	// }	// ?F2L186S28?

	// FLOAT AS726X::CONVERTBYTESTOFLOAT(UINT32_T MYLONG)	// ?F2L189S29?
	// {	// ?F2L190S29?
	// 	FLOAT MYFLOAT;	// ?F2L191S29?
	// 	MEMCPY(&MYFLOAT, &MYLONG, 4); //COPY UINT8_TS INTO A FLOAT	// ?F2L192S29?
	// 	RETURN (MYFLOAT);	// ?F2L193S29?
	// }	// ?F2L194S29?

	// Function  AS726X_DATAAVAILABLE()	// ?F2L197S2?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP);	// ?F2L199S2?
	// 	RETURN (VALUE & (1 << 1)); //BIT 1 IS DATA_RDY	// ?F2L200S2?
	// End Function	// ?F2L201S2?

	// Sub CLEARDATAAVAILABLE()	// ?F2L205S10?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP);	// ?F2L207S10?
	// 	VALUE &= ~(1 << 1); //SET THE DATA_RDY BIT	// ?F2L208S10?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE);	// ?F2L209S10?
	// End Sub	// ?F2L210S10?

	// Sub ENABLEINDICATOR()	// ?F2L213S11?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L216S11?
	// 	VALUE |= (1 << 0); //SET THE BIT	// ?F2L217S11?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE);	// ?F2L218S11?
	// End Sub	// ?F2L219S11?

	// Sub DISABLEINDICATOR()	// ?F2L222S12?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L225S12?
	// 	VALUE &= ~(1 << 0); //CLEAR THE BIT	// ?F2L226S12?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE);	// ?F2L227S12?
	// End Sub	// ?F2L228S12?

	// Sub SETINDICATORCURRENT(UINT8_T CURRENT)	// ?F2L231S13?
	// 	IF (CURRENT > 0B11) CURRENT = 0B11;	// ?F2L233S13?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL); //READ	// ?F2L235S13?
	// 	VALUE &= 0B11111001; //CLEAR ICL_IND BITS	// ?F2L236S13?
	// 	VALUE |= (CURRENT << 1); //SET ICL_IND BITS WITH USER'S CHOICE	// ?F2L237S13?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE); //WRITE	// ?F2L238S13?
	// End Sub	// ?F2L239S13?

	// Sub ENABLEBULB()	// ?F2L242S14?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L245S14?
	// 	VALUE |= (1 << 3); //SET THE BIT	// ?F2L246S14?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE);	// ?F2L247S14?
	// End Sub	// ?F2L248S14?

	// Sub DISABLEBULB()	// ?F2L251S15?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL);	// ?F2L254S15?
	// 	VALUE &= ~(1 << 3); //CLEAR THE BIT	// ?F2L255S15?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE);	// ?F2L256S15?
	// End Sub	// ?F2L257S15?

	Sub SETBULBCURRENT( CURRENT )	// ?F2L264S16?
	// 	IF (CURRENT > 0B11) CURRENT = 0B11; //LIMIT TO TWO BITS	// ?F2L266S16?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_LED_CONTROL); //READ	// ?F2L269S16?
	// 	VALUE &= 0B11001111; //CLEAR ICL_DRV BITS	// ?F2L270S16?
	// 	VALUE |= (CURRENT << 4); //SET ICL_DRV BITS WITH USER'S CHOICE	// ?F2L271S16?
	// 	AS726xVirtualWriteRegister(AS726X_LED_CONTROL, VALUE); //WRITE	// ?F2L272S16?
		End Sub	// ?F2L273S16?

	// Function GETTEMPERATURE() As Byte	// ?F2L277S21?
	// 	RETURN (AS726x_VirtualReadRegister(AS726X_DEVICE_TEMP));	// ?F2L279S21?
	// End Function	// ?F2L280S21?

	// FLOAT AS726X::GETTEMPERATUREF()	// ?F2L283S30?
	// {	// ?F2L284S30?
	// 	FLOAT TEMPERATUREF = GETTEMPERATURE();	// ?F2L285S30?
	// 	TEMPERATUREF = TEMPERATUREF * 1.8 + 32.0;	// ?F2L286S30?
	// 	RETURN (TEMPERATUREF);	// ?F2L287S30?
	// }	// ?F2L288S30?

	// Sub SOFTRESET()	// ?F2L292S17?
	// 	UINT8_T VALUE = AS726x_VirtualReadRegister(AS726X_CONTROL_SETUP); //READ	// ?F2L295S17?
	// 	VALUE |= (1 << 7); //SET RST BIT	// ?F2L296S17?
	// 	AS726xVirtualWriteRegister(AS726X_CONTROL_SETUP, VALUE); //WRITE	// ?F2L297S17?
	// End Sub	// ?F2L298S17?

	Function AS726x_VirtualReadRegister( In AS726xVirtualaddr As Byte) As Byte

		Dim AS726xError, AS726x_Status, AS726x_Incoming as Byte
		AS726x_Status = AS726xReadRegister(AS72XX_SLAVE_STATUS_REG)

		If ((AS726x_Status & AS72XX_SLAVE_RX_VALID) <> 0) Then 				//THERE IS DATA TO BE READ	
			AS726x_Incoming = AS726xReadRegister(AS72XX_SLAVE_READ_REG) 	//READ BUT DO NOTHING WITH IT	
		End If

		AS726xError = 0
		Do	

			AS726x_Status = AS726xReadRegister(AS72XX_SLAVE_STATUS_REG);	

			IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then
				AS726xError = 0
				Exit Do; // IF TX BIT IS CLEAR, IT IS OK TO WRITE	
			Else
				Wait POLLING_DELAY
				AS726xError++
			End If
		Loop While !AS726xError

		AS726xWriteRegister(AS72XX_SLAVE_WRITE_REG, AS726xVirtualaddr)
		AS726xError = 0
		Do
			
			AS726x_Status = AS726xReadRegister(AS72XX_SLAVE_STATUS_REG)
			IF ((AS726x_Status & AS72XX_SLAVE_RX_VALID) <> 0) Then
				AS726xError = 0
				Exit Do ; // READ DATA IS READY.	
			Else
				Wait POLLING_DELAY
				AS726xError++
			End If
		Loop While !AS726xError 

		AS726x_VirtualReadRegister = AS726xReadRegister(AS72XX_SLAVE_READ_REG)
		// Always returns AS726xError for examination
	End Function	// ?F2L334S22?

	Sub AS726xVirtualWriteRegister( AS726xVirtualaddr, DATATOWRITE)	// ?F2L337S18?
		Dim AS726x_Status as Byte;	// ?F2L339S18?
		D0	// ?F2L342S18?
			// ?F2L343S18?
			AS726x_Status = AS726xReadRegister(AS72XX_SLAVE_STATUS_REG);	// ?F2L344S18?
			IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then 
				Exit Do // NO INBOUND TX PENDING AT SLAVE. OKAY TO WRITE NOW.	// ?F2L345S18?
				Wait POLLING_DELAY;	// ?F2L346S18?
		Loop	// ?F2L347S18?
		AS726xWriteRegister(AS72XX_SLAVE_WRITE_REG, (AS726xVirtualaddr | 0X80));	// ?F2L350S18?
		
		Do	// ?F2L353S18?
			// ?F2L354S18?
			AS726x_Status = AS726xReadRegister(AS72XX_SLAVE_STATUS_REG);	// ?F2L355S18?
			IF ((AS726x_Status & AS72XX_SLAVE_TX_VALID) = 0) Then // NO INBOUND TX PENDING AT SLAVE. OKAY TO WRITE NOW.	// ?F2L356S18?
				Exit Do
				Wait POLLING_DELAY;	// ?F2L357S18?
		Loop	// ?F2L358S18?
		AS726xWriteRegister(AS72XX_SLAVE_WRITE_REG, DATATOWRITE);	// ?F2L361S18?
	End Sub	// ?F2L362S18?

	Function AS726xReadRegister( AS726XRegisterAddr ) As Byte	// ?F2L365S23?

		#ifdef HI2C_DATA

			do
				HI2CStart                            	// generate a start signal
				HI2CSend(AS726X_ADDRESS)               		// indicate a write				
			loop While HI2CAckPollState
			HI2CSend(AS726XRegisterAddr)                // send register address

			HI2CStart
      		HI2CSend(AS726X_ADDRESS + 1)               	// set the read flag

		    HI2CReceive(AS726xReadRegister, NACK)     	// read one byte and conclude
				// Hsersend "<"
				// HserPrint AS726xReadRegister
				// Hserprint ">"
			HI2CStop
		#endif

		#ifdef I2C_DATA
			I2CStart                              		// generate a start signal
			I2CSend(AS726X_ADDRESS)                     // indicate a write
			I2CSend(AS726XRegisterAddr)					// send register address
			I2CReStart
			I2CSend(AS726X_ADDRESS + 1)                 // set the read flag
			I2CReceive(AS726xReadRegister, NACK)        // read one byte and conclude
			I2CStop
			I2CAckPoll(AS726X_ADDRESS)          		// wait for buffer write
		#endif
		
	End Function	// ?F2L379S23?

	Sub AS726xWriteRegister( in AS726XRegisterAddr, in AS726XVal)	// ?F2L382S19?

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
