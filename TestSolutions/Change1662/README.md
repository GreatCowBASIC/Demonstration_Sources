# Change 1662: #option StartupMethodsDisabled leaves out the startup subs

With `#option StartupMethodsDisabled` the startup calls are written to the asm only as comments
(`;!  call INITSYS`, `;!  call INITRANDOM`, ...), so nothing calls those subs. Build 1661 still compiled them: about
66 bytes of unused code in a PIC18F46J50 program (INITSYS 52, INITRANDOM 10, USBCDCSTARTUP 4). Build 1662 compiles a
startup sub only when the program calls it itself (for example `InitSys`, or `InitGLCD` after
`#option StartupMethodsDisabled`).

The three places that asked for the startup subs now skip the request when the option is set: the startup sub of the
main program (`#startup` in the program), the startup subs of the files whose subs or constants are used, and the
`;STARTUP` request made when a file's constant is used. Without the option nothing changes.

## Test programs

Compile each with build 1662 and look at the asm.

| Program | Expected (build 1662) | Build 1661 |
|---|---|---|
| `StartupDisabled_PIC18.gcb` | `;!  call INITSYS`, `;!  call INITRANDOM`; no INITSYS or INITRANDOM routine | both routines compiled, never called |
| `StartupDisabled_PIC16.gcb` | the same, PIC16F1829 | both routines compiled, never called |
| `StartupDisabled_AVR.gcb` | the same, mega328p (`;!  rcall ...`) | both routines compiled, never called |
| `StartupDisabled_OwnStartup.gcb` | `;!  call MYSTART`; no MYSTART routine (the program's own `#startup` sub) | MYSTART compiled, never called |
| `StartupDisabled_CallsInitSys.gcb` | the program calls `InitSys` itself: INITSYS compiled and called, the same asm as 1661 | the same |
| `StartupEnabled_Unchanged.gcb` | no option: `call INITSYS` and INITSYS, the same asm as 1661 | the same |

## Checked

- The 45 PIC18F Starter Kit programs (all `#option StartupMethodsDisabled`), the 5 Demonstration_Sources programs that use
  the option, and 200 other programs picked at random: compiled with 1661 and 1662 from the same folder, the asm compared.
