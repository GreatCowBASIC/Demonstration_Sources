@echo off
rem mTouch Monitor: serves mTouch_Monitor.html on http://localhost:8765 (Web Serial needs a secure page, and
rem localhost is one) and opens it in the default browser - use Chrome or Edge. Close this window to stop.

cd /d "%~dp0"
set PORT=8765

set PY=
where python >nul 2>nul && set PY=python
if not defined PY where py >nul 2>nul && set PY=py
if not defined PY (
    echo Python was not found. Install it from https://www.python.org/ or the Microsoft Store.
    pause
    exit /b 1
)

echo.
echo  mTouch Monitor
echo  --------------
echo  The page opens in your default browser in a moment. If it does not, or that browser is not
echo  Chrome or Edge, open Chrome or Edge and go to:
echo.
echo      http://localhost:%PORT%/mTouch_Monitor.html
echo.
echo  Then press Connect and choose the board's COM port (115200 baud). Close any terminal program
echo  that has the port open first.
echo.
echo  Close this window to stop the server.
echo.
rem Open the page two seconds from now, once the server is running
start "" /min powershell -NoProfile -Command "Start-Sleep 2; Start-Process 'http://localhost:%PORT%/mTouch_Monitor.html'"
%PY% -m http.server %PORT% --bind 127.0.0.1
