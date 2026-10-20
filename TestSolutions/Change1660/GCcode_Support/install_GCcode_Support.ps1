# install_GCcode_Support.ps1 - adds the GCcode / SynWrite support for DIM ... AT location OVERRIDE
# (GCBASIC build 1660) to a GC Studio installation, and the highlighting of the words added to GCcode's
# grammar since 2026-09-24 (#option bootloaderhost / StringLimitCheck / StartupMethodsDisabled /
# UserCodeOnly / RemoveAVRVectors, Shift, UBound): an older installation does not colour them.
# Also (2026-10-19) GLCDSetContrast, GLCDSetDisplayInvertMode and GLCDSetDisplayNormalMode - now supported by the
# SSD1306 too (glcd_SSD1306.h) - in autocomplete, highlighting and SynWrite's list, where they are missing.
#
#   install_GCcode_Support.cmd [GC Studio folder] [-Force] [-WhatIf]     (the folder: C:\GCstudio by default)
#   e.g.  install_GCcode_Support.cmd "E:\GCstudio"
#
# It edits the installation's own files rather than copying the ones in this folder over them, so a
# newer or older GC Studio keeps everything else it has:
#   1 vscode\data\extensions\*GreatCowBasic*\syntaxes\GCB.tmLanguage.json   Override highlighted as Alias is;
#                                                                         the words above added where missing
#   2 vscode\data\extensions\*GreatCowBasic*\dist\IntelliSenseGCB.json      Dim's syntax, an Override entry
#   3 IntelliSense\GCBasic.json                                           the same (the older copy)
#   4 synwrite\data\autocomplete\gcbasic.acp                              Dim's syntax, Override -> the Dim page
# Each file changed is backed up first (<name>.bak_<date>). A file that already has the change is left
# alone. A file without the expected text is left alone and reported; with -Force it is replaced by
# this folder's copy (after the backup). -WhatIf reports what would be done and changes nothing.
param([string]$Target = 'C:\GCstudio', [switch]$Force, [switch]$WhatIf)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$utf8 = New-Object Text.UTF8Encoding($false)
$Target = $Target.TrimEnd('\')
if (-not (Test-Path (Join-Path $Target 'gcbasic'))) { Write-Host "Not a GC Studio folder (no gcbasic\ inside): $Target"; exit 1 }
$counts = @{ changed = 0; already = 0; skipped = 0; missing = 0 }

# one file: apply the edits (old -> new pairs, matched with LF line ends); $marker shows it is done
function Install-File([string]$path, [string]$shipped, [string]$marker, [object[]]$edits, [switch]$json) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { Write-Host "  missing   $rel"; $counts.missing++; return }
    $raw = [IO.File]::ReadAllText($path, $utf8)
    $crlf = $raw.Contains("`r`n")
    $text = $raw.Replace("`r`n", "`n")
    if ($text.Contains($marker)) { Write-Host "  already   $rel"; $counts.already++; return }
    $ok = $true
    foreach ($e in $edits) {
        $n = ([regex]::Matches($text, [regex]::Escape($e[0]))).Count
        if ($n -ne 1) { $ok = $false; break }
        $text = $text.Replace($e[0], $e[1])
    }
    if (-not $ok) {
        if (-not $Force) { Write-Host "  SKIPPED   $rel - not the expected text (another version): left as it is; -Force replaces it with this folder's copy"; $counts.skipped++; return }
        $text = [IO.File]::ReadAllText((Join-Path $here $shipped), $utf8).Replace("`r`n", "`n")
        Write-Host "  replaced  $rel - by this folder's $shipped (-Force)"
    }
    if ($json) { $null = ($text | ConvertFrom-Json) }          # stops here if the result is not valid JSON
    if ($crlf) { $text = $text.Replace("`n", "`r`n") }
    if ($WhatIf) { Write-Host "  would change $rel"; return }
    Copy-Item $path "$path.bak_$stamp"
    [IO.File]::WriteAllText($path, $text, $utf8)
    if ($ok) { Write-Host "  changed   $rel  (backup .bak_$stamp)" }
    $counts.changed++
}

# ---- 1 highlighting: Override is a storage modifier, as Alias
$tm = @(, @('"match": "(?i)\\b(alias)\\b"', '"match": "(?i)\\b(alias|override)\\b"'))

# ---- 1b highlighting: the words added to the grammar's constant list (constant.language) since 2026-09-24,
#      each only where it is missing
$words = @('bootloaderhost', 'StringLimitCheck', 'StartupMethodsDisabled', 'UserCodeOnly', 'RemoveAVRVectors', 'Shift', 'UBound')
function Install-Words([string]$path) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { return }                   # reported by the step before
    $raw = [IO.File]::ReadAllText($path, $utf8)
    $crlf = $raw.Contains("`r`n")
    $text = $raw.Replace("`r`n", "`n")
    $m = [regex]::Match($text, '("name": "constant\.language\.GCB",\s*\n\s*"match": "\(\?i\)\\\\b\()([^"]*)"')
    if (-not $m.Success) { Write-Host "  SKIPPED   $rel - its constant list (constant.language.GCB) not found: words not added"; $counts.skipped++; return }
    $have = $m.Groups[2].Value -split '[|()]'
    $missing = @($words | Where-Object { $have -notcontains $_ })    # -notcontains ignores case
    if ($missing.Count -eq 0) { Write-Host "  already   $rel (the #option words)"; $counts.already++; return }
    $text = $text.Insert($m.Groups[2].Index, ($missing -join '|') + '|')
    $null = ($text | ConvertFrom-Json)
    if ($crlf) { $text = $text.Replace("`n", "`r`n") }
    if ($WhatIf) { Write-Host ("  would add {0} to {1}" -f ($missing -join ', '), $rel); return }
    if (-not (Test-Path "$path.bak_$stamp")) { Copy-Item $path "$path.bak_$stamp" }   # one backup a run: the file as it was
    [IO.File]::WriteAllText($path, $text, $utf8)
    Write-Host ("  added     {0} to {1}" -f ($missing -join ', '), $rel)
    $counts.changed++
}

# ---- 5 the GLCD commands GLCDSetContrast / GLCDSetDisplayInvertMode / GLCDSetDisplayNormalMode (2026-10-19)
$glcdEntries = @'
                {
                    "name": "GLCDSetContrast",
                    "available": "All Microcontrollers",
                    "description": "GLCDSetContrast ( level )",
                    "funcdesc": "Sets the GLCD contrast, 0 to 255: the contrast increases as the value increases.\n\nSupported by GLCD chipsets with a contrast setting, for example SSD1306, SH1106, SH1101A."
                },
                {
                    "name": "GLCDSetDisplayInvertMode",
                    "available": "All Microcontrollers",
                    "description": "GLCDSetDisplayInvertMode",
                    "funcdesc": "Inverts the display: a set pixel is dark. The screen buffer does not change.\n\nSupported by GLCD chipsets with an invert mode, for example SSD1306, SH1106, SH1101A."
                },
                {
                    "name": "GLCDSetDisplayNormalMode",
                    "available": "All Microcontrollers",
                    "description": "GLCDSetDisplayNormalMode",
                    "funcdesc": "Sets the display to normal mode: a set pixel is lit.\n\nSupported by GLCD chipsets with an invert mode, for example SSD1306, SH1106, SH1101A."
                },

'@
function Install-Glcd([string]$path, [string]$kind) {
    $rel = $path.Substring($Target.Length + 1)
    if (-not (Test-Path $path)) { return }                   # reported by the steps before
    $raw = [IO.File]::ReadAllText($path, $utf8)
    $crlf = $raw.Contains("`r`n")
    $text = $raw.Replace("`r`n", "`n")
    if ($kind -eq 'tm') {
        if ($text.Contains('GLCDSetDisplayInvertMode')) { Write-Host "  already   $rel (the GLCD words)"; $counts.already++; return }
        if (([regex]::Matches($text, [regex]::Escape('|GLCDSetContrast|'))).Count -ne 1) { Write-Host "  SKIPPED   $rel - GLCDSetContrast not found once: GLCD words not added"; $counts.skipped++; return }
        $text = $text.Replace('|GLCDSetContrast|', '|GLCDSetContrast|GLCDSetDisplayInvertMode|GLCDSetDisplayNormalMode|')
        $null = ($text | ConvertFrom-Json)
    }
    if ($kind -eq 'json') {
        if ($text.Contains('"name": "GLCDSetDisplayInvertMode"')) { Write-Host "  already   $rel (the GLCD commands)"; $counts.already++; return }
        $i = $text.IndexOf('"name": "GLCDROTATE"')
        $j = if ($i -ge 0) { $text.IndexOf("`n                },`n", $i) } else { -1 }
        if ($j -lt 0) { Write-Host "  SKIPPED   $rel - the GLCDROTATE entry not found: GLCD commands not added"; $counts.skipped++; return }
        $j += "`n                },`n".Length
        $add = $glcdEntries.Replace("`r`n", "`n")
        if ($text.Contains('"name": "GLCDSetContrast"')) {     # GLCDSetContrast already there: only the two modes
            $add = $add.Substring($add.IndexOf("                {`n                    `"name`": `"GLCDSetDisplayInvertMode`""))
        }
        $text = $text.Insert($j, $add)
        $null = ($text | ConvertFrom-Json)
    }
    if ($kind -eq 'acp') {
        if ($text.Contains('-> GLCDSetDisplayInvertMode |')) { Write-Host "  already   $rel (the GLCD commands)"; $counts.already++; return }
        $line = "-> GLCDSetContrast | \_glcd_overview.html`n"
        if (([regex]::Matches($text, [regex]::Escape($line))).Count -ne 1) { Write-Host "  SKIPPED   $rel - GLCDSetContrast line not found once: GLCD commands not added"; $counts.skipped++; return }
        $text = $text.Replace($line, $line + "-> GLCDSetDisplayInvertMode | \_glcd_overview.html`n-> GLCDSetDisplayNormalMode | \_glcd_overview.html`n")
    }
    if ($crlf) { $text = $text.Replace("`n", "`r`n") }
    if ($WhatIf) { Write-Host "  would add the GLCD commands to $rel"; return }
    if (-not (Test-Path "$path.bak_$stamp")) { Copy-Item $path "$path.bak_$stamp" }   # one backup a run: the file as it was
    [IO.File]::WriteAllText($path, $text, $utf8)
    Write-Host "  added     the GLCD commands to $rel"
    $counts.changed++
}

# ---- 2 / 3 IntelliSense: Dim's syntax and an Override entry
$dimOld = @'
                    "name": "Dim",
                    "available": "All Microcontrollers",
                    "description": "Dim variable[, variable2 [, variable3]] [As type] [Alias othervar [, othervar2]]",
                    "funcdesc": "The Dim variable command is used to instruct Great Cow BASIC to allocate variables or to create alternate names for existing variables (using Alias) or to create variables at a specific memory location (using At)."
                },

'@
$dimNew = @'
                    "name": "Dim",
                    "available": "All Microcontrollers",
                    "description": "Dim variable[, variable2 [, variable3]] [As type] [Alias othervar [, othervar2]] [At location [Override]]",
                    "funcdesc": "The Dim variable command is used to instruct Great Cow BASIC to allocate variables or to create alternate names for existing variables (using Alias) or to create variables at a specific memory location (using At). Override after At location marks an intended overlap of that location."
                },
                {
                    "name": "Override",
                    "available": "All Microcontrollers",
                    "description": "Dim variable [As type] At location Override",
                    "funcdesc": "Override, after At location in a Dim, marks an intended overlap of a fixed location: RAM purposely allocated to parts of a program that are never in use at the same time. The compiler then gives no Memory location ... may be invalid warning for that variable. Every overlapping Dim needs its own Override, the first one too. Example: Dim NameList(768) As Byte At 0x400 Override"
                },

'@
$isg = @(, @($dimOld.Replace("`r`n", "`n"), $dimNew.Replace("`r`n", "`n")))

# ---- 4 SynWrite: the Dim syntax line, and Override in the F1 help list (after Out)
$acp = @(
    @("-> Dim |Dim variable [, variable2[, variable3]] [As type] [Alias othervar [,othervar2]] [At location] / Dim Array (size) [At location]`n",
      "-> Dim |Dim variable [, variable2[, variable3]] [As type] [Alias othervar [,othervar2]] [At location [Override]] / Dim Array (size) [At location [Override]]`n"),
    @("-> Out |Dir port.bit {In / Out} (Individual Form) Dir port {In / Out / DirectionByte} (Entire Port Form) | \_dir.html`n",
      "-> Out |Dir port.bit {In / Out} (Individual Form) Dir port {In / Out / DirectionByte} (Entire Port Form) | \_dir.html`n-> Override |Dim variable [As type] At location Override | \_dim.html`n"))

Write-Host "GCcode support for DIM ... AT location OVERRIDE (build 1660) and the newer #option words -> $Target$(if ($WhatIf) { '  (WhatIf: nothing is changed)' })"
$ext = @(Get-ChildItem (Join-Path $Target 'vscode\data\extensions') -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'greatcowbasic' })
if ($ext.Count -eq 0) { Write-Host '  missing   vscode\data\extensions\*GreatCowBasic* (GCcode extension not found)'; $counts.missing++ }
foreach ($e in $ext) {
    Install-File (Join-Path $e.FullName 'syntaxes\GCB.tmLanguage.json') 'GCB.tmLanguage.json' 'alias|override' $tm -json
    Install-Words (Join-Path $e.FullName 'syntaxes\GCB.tmLanguage.json')
    Install-File (Join-Path $e.FullName 'dist\IntelliSenseGCB.json') 'IntelliSenseGCB.json' '"name": "Override"' $isg -json
    Install-Glcd (Join-Path $e.FullName 'syntaxes\GCB.tmLanguage.json') 'tm'
    Install-Glcd (Join-Path $e.FullName 'dist\IntelliSenseGCB.json') 'json'
}
Install-File (Join-Path $Target 'IntelliSense\GCBasic.json') 'GCBasic.json' '"name": "Override"' $isg -json
Install-Glcd (Join-Path $Target 'IntelliSense\GCBasic.json') 'json'
Install-File (Join-Path $Target 'synwrite\data\autocomplete\gcbasic.acp') 'gcbasic.acp' "-> Override |" $acp
Install-Glcd (Join-Path $Target 'synwrite\data\autocomplete\gcbasic.acp') 'acp'
Write-Host ("Done: {0} changed, {1} already had it, {2} skipped, {3} missing. Restart GCcode / SynWrite to load the changes." -f $counts.changed, $counts.already, $counts.skipped, $counts.missing)
if ($counts.skipped -gt 0) { exit 2 }
