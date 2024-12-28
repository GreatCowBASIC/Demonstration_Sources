//  Library for Russian LCD type 1602
'------ Usage example ------
'Use only Windows 1251 coding

sub PrintR (In PrintDataR As String)
'Sub to print a string variable on the LCD

    PrintLenR = PrintDataR(0)

    If PrintLenR = 0 Then Exit Sub
    Set LCD_RS On

    'Write Data
For SysPrintTemp = 1 To PrintLenR
// ������� ������� �����
If PrintDataR(SysPrintTemp)=192 Then SET PrintDataR(SysPrintTemp)=65  // �
If PrintDataR(SysPrintTemp)=193 Then SET PrintDataR(SysPrintTemp)=160 // �
If PrintDataR(SysPrintTemp)=194 Then SET PrintDataR(SysPrintTemp)=66  // �
If PrintDataR(SysPrintTemp)=195 Then SET PrintDataR(SysPrintTemp)=161 // �
If PrintDataR(SysPrintTemp)=196 Then SET PrintDataR(SysPrintTemp)=224 // �
If PrintDataR(SysPrintTemp)=197 Then SET PrintDataR(SysPrintTemp)=69  // �
If PrintDataR(SysPrintTemp)=168 Then SET PrintDataR(SysPrintTemp)=162 // �
If PrintDataR(SysPrintTemp)=198 Then SET PrintDataR(SysPrintTemp)=163 // �
If PrintDataR(SysPrintTemp)=199 Then SET PrintDataR(SysPrintTemp)=164 // � 
If PrintDataR(SysPrintTemp)=200 Then SET PrintDataR(SysPrintTemp)=165 // �
If PrintDataR(SysPrintTemp)=201 Then SET PrintDataR(SysPrintTemp)=166 // �
If PrintDataR(SysPrintTemp)=202 Then SET PrintDataR(SysPrintTemp)=75  // �
If PrintDataR(SysPrintTemp)=203 Then SET PrintDataR(SysPrintTemp)=167 // �
If PrintDataR(SysPrintTemp)=204 Then SET PrintDataR(SysPrintTemp)=77  // �
If PrintDataR(SysPrintTemp)=205 Then SET PrintDataR(SysPrintTemp)=72  // �
If PrintDataR(SysPrintTemp)=206 Then SET PrintDataR(SysPrintTemp)=79  // �
If PrintDataR(SysPrintTemp)=207 Then SET PrintDataR(SysPrintTemp)=168 // �
If PrintDataR(SysPrintTemp)=208 Then SET PrintDataR(SysPrintTemp)=80  // �
If PrintDataR(SysPrintTemp)=209 Then SET PrintDataR(SysPrintTemp)=67  // �
If PrintDataR(SysPrintTemp)=210 Then SET PrintDataR(SysPrintTemp)=84  // �
If PrintDataR(SysPrintTemp)=211 Then SET PrintDataR(SysPrintTemp)=169 // � 
If PrintDataR(SysPrintTemp)=212 Then SET PrintDataR(SysPrintTemp)=170 // �
If PrintDataR(SysPrintTemp)=213 Then SET PrintDataR(SysPrintTemp)=88  // �
If PrintDataR(SysPrintTemp)=214 Then SET PrintDataR(SysPrintTemp)=225 // �
If PrintDataR(SysPrintTemp)=215 Then SET PrintDataR(SysPrintTemp)=171 // �
If PrintDataR(SysPrintTemp)=216 Then SET PrintDataR(SysPrintTemp)=172 // �
If PrintDataR(SysPrintTemp)=217 Then SET PrintDataR(SysPrintTemp)=226 // �
If PrintDataR(SysPrintTemp)=218 Then SET PrintDataR(SysPrintTemp)=173 // �
If PrintDataR(SysPrintTemp)=219 Then SET PrintDataR(SysPrintTemp)=174 // �
If PrintDataR(SysPrintTemp)=220 Then SET PrintDataR(SysPrintTemp)=98  // �
If PrintDataR(SysPrintTemp)=221 Then SET PrintDataR(SysPrintTemp)=175 // �
If PrintDataR(SysPrintTemp)=222 Then SET PrintDataR(SysPrintTemp)=176 // �
If PrintDataR(SysPrintTemp)=223 Then SET PrintDataR(SysPrintTemp)=177 // �

// ��������� ������� �����
If PrintDataR(SysPrintTemp)=224 Then SET PrintDataR(SysPrintTemp)=97  // �
If PrintDataR(SysPrintTemp)=225 Then SET PrintDataR(SysPrintTemp)=178 // �
If PrintDataR(SysPrintTemp)=226 Then SET PrintDataR(SysPrintTemp)=179 // �
If PrintDataR(SysPrintTemp)=227 Then SET PrintDataR(SysPrintTemp)=180 // �
If PrintDataR(SysPrintTemp)=228 Then SET PrintDataR(SysPrintTemp)=227 // �
If PrintDataR(SysPrintTemp)=229 Then SET PrintDataR(SysPrintTemp)=101 // �
If PrintDataR(SysPrintTemp)=184 Then SET PrintDataR(SysPrintTemp)=181 // �
If PrintDataR(SysPrintTemp)=230 Then SET PrintDataR(SysPrintTemp)=182 // �
If PrintDataR(SysPrintTemp)=231 Then SET PrintDataR(SysPrintTemp)=183 // � 
If PrintDataR(SysPrintTemp)=232 Then SET PrintDataR(SysPrintTemp)=184 // �
If PrintDataR(SysPrintTemp)=233 Then SET PrintDataR(SysPrintTemp)=185 // �
If PrintDataR(SysPrintTemp)=234 Then SET PrintDataR(SysPrintTemp)=186 // �
If PrintDataR(SysPrintTemp)=235 Then SET PrintDataR(SysPrintTemp)=187 // �
If PrintDataR(SysPrintTemp)=236 Then SET PrintDataR(SysPrintTemp)=188 // �
If PrintDataR(SysPrintTemp)=237 Then SET PrintDataR(SysPrintTemp)=189 // �
If PrintDataR(SysPrintTemp)=238 Then SET PrintDataR(SysPrintTemp)=111 // �
If PrintDataR(SysPrintTemp)=239 Then SET PrintDataR(SysPrintTemp)=190 // �
If PrintDataR(SysPrintTemp)=240 Then SET PrintDataR(SysPrintTemp)=112 // �
If PrintDataR(SysPrintTemp)=241 Then SET PrintDataR(SysPrintTemp)=99  // �
If PrintDataR(SysPrintTemp)=242 Then SET PrintDataR(SysPrintTemp)=191 // �
If PrintDataR(SysPrintTemp)=243 Then SET PrintDataR(SysPrintTemp)=121 // � 
If PrintDataR(SysPrintTemp)=244 Then SET PrintDataR(SysPrintTemp)=228 // �
If PrintDataR(SysPrintTemp)=245 Then SET PrintDataR(SysPrintTemp)=120 // �
If PrintDataR(SysPrintTemp)=246 Then SET PrintDataR(SysPrintTemp)=229 // �
If PrintDataR(SysPrintTemp)=247 Then SET PrintDataR(SysPrintTemp)=192 // �
If PrintDataR(SysPrintTemp)=248 Then SET PrintDataR(SysPrintTemp)=193 // �
If PrintDataR(SysPrintTemp)=249 Then SET PrintDataR(SysPrintTemp)=230 // �
If PrintDataR(SysPrintTemp)=250 Then SET PrintDataR(SysPrintTemp)=194 // �
If PrintDataR(SysPrintTemp)=251 Then SET PrintDataR(SysPrintTemp)=195 // �
If PrintDataR(SysPrintTemp)=252 Then SET PrintDataR(SysPrintTemp)=196 // �
If PrintDataR(SysPrintTemp)=253 Then SET PrintDataR(SysPrintTemp)=197 // �
If PrintDataR(SysPrintTemp)=254 Then SET PrintDataR(SysPrintTemp)=198 // �
If PrintDataR(SysPrintTemp)=255 Then SET PrintDataR(SysPrintTemp)=199 // �

LCDWriteByte PrintDataR(SysPrintTemp)
Next

End Sub
