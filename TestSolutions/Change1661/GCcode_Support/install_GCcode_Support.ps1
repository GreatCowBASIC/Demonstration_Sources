# install_GCcode_Support.ps1 - adds the GCcode / SynWrite support for #option IncludePath (GCBASIC build 1661) to a
# GC Studio installation: IncludePath highlighted as the other #option words, an autocomplete entry, and the F1 help
# link in SynWrite.
#
#   install_GCcode_Support.cmd [GC Studio folder] [-WhatIf]     (the folder: GCBASIC_INSTALL_PATH, else C:\GCstudio)
#
# It edits the installation's own files rather than copying this folder's over them, so a newer or older GC Studio
# keeps everything else it has:
#   1 vscode\data\extensions\*GreatCowBasic*\syntaxes\GCB.tmLanguage.json   IncludePath in the #option word list
#   2 vscode\data\extensions\*GreatCowBasic*\dist\IntelliSenseGCB.json      an "option IncludePath" entry
#   3 IntelliSense\GCBasic.json                                           the same (the older copy)
#   4 synwrite\data\autocomplete\gcbasic.acp                              #OPTION IncludePath and IncludePath -> Help
# Each file changed is backed up first (<name>.bak_<date>). A file that already has it is left alone; a file without
# the expected text is left alone and reported. -WhatIf reports what would be done and changes nothing.
param([string]$Target = '', [switch]$WhatIf)
$ErrorActionPreference = 'Stop'
if ($Target -eq '') { $Target = if ($env:GCBASIC_INSTALL_PATH) { $env:GCBASIC_INSTALL_PATH } else { 'C:\GCstudio' } }
$Target = $Target.TrimEnd('\')
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$utf8 = New-Object Text.UTF8Encoding($false)
$latin = [Text.Encoding]::GetEncoding(28591)
if (-not (Test-Path (Join-Path $Target 'gcbasic'))) { Write-Host "STOPPED: not a GC Studio folder (no gcbasic\ inside): $Target" -ForegroundColor Red; exit 1 }
$counts = @{ changed = 0; already = 0; skipped = 0; missing = 0 }

function Save([string]$path, [string]$text, [bool]$crlf, $enc, [string]$what) {
    $rel = $path.Substring($Target.Length + 1)
    if ($crlf) { $text = $text.Replace("`n", "`r`n") }
    if ($WhatIf) { Write-Host "  would add $what to $rel"; return }
    Copy-Item $path "$path.bak_$stamp"
    [IO.File]::WriteAllText($path, $text, $enc)
    Write-Host "  added     $what to $rel  (backup .bak_$stamp)" -ForegroundColor Green
    $counts.changed++
}
function Read-Text([string]$path, $enc) {
    $raw = [IO.File]::ReadAllText($path, $enc)
    return @($raw.Replace("`r`n", "`n"), $raw.Contains("`r`n"))
}

# ---- 1 highlighting: IncludePath after bootloaderhost in the #option word list
function Install-Tm([string]$path) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { Write-Host "  missing   $rel"; $counts.missing++; return }
    $text, $crlf = Read-Text $path $utf8
    if ($text -match '\|IncludePath\|') { Write-Host "  already   $rel"; $counts.already++; return }
    if (([regex]::Matches($text, [regex]::Escape('|bootloaderhost|'))).Count -ne 1) { Write-Host "  SKIPPED   $rel - bootloaderhost not found once in the word list" -ForegroundColor Yellow; $counts.skipped++; return }
    $text = $text.Replace('|bootloaderhost|', '|bootloaderhost|IncludePath|')
    $null = ($text | ConvertFrom-Json)
    Save $path $text $crlf $utf8 'IncludePath (highlighting)'
}

# ---- 2 / 3 IntelliSense: an "option IncludePath" entry after "option BootloaderHost"
$entry = @'
                {
                    "name": "option IncludePath",
                    "available": "All Microcontrollers",
                    "description": "#option IncludePath \"folder;folder\"",
                    "funcdesc": "The folders searched for #include <...> (and #insert <...>) before GCBASIC's include folder, in the order given, separated by ;. Relative to the program's folder, or a full path. Applies to every #include <...> after it, in the program and in the files it includes. #include \"...\" is not changed. Build 1661."
                },

'@
function Install-Json([string]$path) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { Write-Host "  missing   $rel"; $counts.missing++; return }
    $text, $crlf = Read-Text $path $utf8
    if ($text.Contains('"name": "option IncludePath"')) { Write-Host "  already   $rel"; $counts.already++; return }
    $i = $text.IndexOf('"name": "option BootloaderHost"')
    $j = if ($i -ge 0) { $text.IndexOf("`n                },`n", $i) } else { -1 }
    if ($j -lt 0) { Write-Host "  SKIPPED   $rel - the option BootloaderHost entry not found" -ForegroundColor Yellow; $counts.skipped++; return }
    $j += "`n                },`n".Length
    $add = $entry.Replace("`r`n", "`n")
    $text = $text.Insert($j, $add)
    $null = ($text | ConvertFrom-Json)
    Save $path $text $crlf $utf8 'the option IncludePath entry'
}

# ---- 4 SynWrite: the #OPTION line and the F1 help line, after BootloaderHost's
function Install-Acp([string]$path) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { Write-Host "  missing   $rel"; $counts.missing++; return }
    $text, $crlf = Read-Text $path $latin
    if ($text.Contains('-> IncludePath |')) { Write-Host "  already   $rel"; $counts.already++; return }
    $a = "-> #OPTION BootloaderHost Address | \__option_bootloaderhost.html`n"
    $b = "-> BootloaderHost | \__option_bootloaderhost.html`n"
    if (([regex]::Matches($text, [regex]::Escape($a))).Count -ne 1 -or ([regex]::Matches($text, [regex]::Escape($b))).Count -ne 1) {
        Write-Host "  SKIPPED   $rel - the BootloaderHost lines not found once" -ForegroundColor Yellow; $counts.skipped++; return }
    $text = $text.Replace($a, $a + "-> #OPTION IncludePath `"folder;folder`" | \__option_includepath.html`n")
    $text = $text.Replace($b, $b + "-> IncludePath | \__option_includepath.html`n")
    Save $path $text $crlf $latin 'IncludePath (autocomplete, F1 help)'
}

Write-Host "GCcode support for #option IncludePath (build 1661) -> $Target$(if ($WhatIf) { '  (WhatIf: nothing is changed)' })" -ForegroundColor Cyan
$ext = @(Get-ChildItem (Join-Path $Target 'vscode\data\extensions') -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'greatcowbasic' })
if ($ext.Count -eq 0) { Write-Host '  missing   vscode\data\extensions\*GreatCowBasic* (GCcode extension not found)'; $counts.missing++ }
foreach ($e in $ext) {
    Install-Tm (Join-Path $e.FullName 'syntaxes\GCB.tmLanguage.json')
    Install-Json (Join-Path $e.FullName 'dist\IntelliSenseGCB.json')
}
Install-Json (Join-Path $Target 'IntelliSense\GCBasic.json')
Install-Acp (Join-Path $Target 'synwrite\data\autocomplete\gcbasic.acp')
Write-Host ("Done: {0} changed, {1} already had it, {2} skipped, {3} missing. Restart GCcode / SynWrite to load the changes." -f $counts.changed, $counts.already, $counts.skipped, $counts.missing)
try { [Console]::Beep(880, 200) } catch {}
if ($counts.skipped -gt 0) { exit 2 }
