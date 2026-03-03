# 8-Voice Polyphonic Music Box  
**PIC18F57Q84 • GCBASIC • Single-sample Pitch Shifting**

./Maple_Leaf_Rag.PNG

A retro-inspired **8-voice polyphonic synthesizer** on the **PIC18F57Q84**.  
Plays Scott Joplin's **Maple Leaf Rag** (public domain) using **one shared 5566-byte 8-bit waveform** — a single-cycle plucked string sound originally tuned to ≈C4 at 32 kHz.  
Pitches are shifted via a clever 16-bit fixed-point accumulator that delivers surprisingly clean results with minimal artifacts.

> “I'm still stunned that one can get away with that crude treatment and that it sounds as clean as it does.  
> I guess that is the way it was done in the samplers 40 years ago.”  
> — Roger Jönsson, March 2026

## Listen First

[▶ Demo video (clean version, no black borders)](https://youtube.com/shorts/MggEHIurixY)

Hear eight voices share **one pluck sample**, each pitch-shifted without obvious aliasing or grit in the mid-range — quite impressive for raw integer skipping at 32 kHz / 8-bit.

## Core Pitch Technique – The “Stroke of Genius”

```basic
Voice1_samplePos = Voice1_samplePos + Voice1_pitch          ' 16-bit
Voice1_sample     = Voice1_sample + Voice1_samplePos_H      ' whole-sample steps
Voice1_samplePos_H = 0                                      ' fraction carries over
```

- `pitch` (word) sets playback speed  
- Low byte acts as **fractional accumulator** → overflows naturally increment the sample index  
- Provides **sub-sample timing resolution** without division or interpolation  
- Roger stumbled upon this while testing dual sines, forgot the mechanism, then rediscovered it here

Very reminiscent of early digital samplers / wavetable synths before affordable DSP.

## Hardware Connections

| Pin       | Function                        | Notes                              |
|-----------|---------------------------------|------------------------------------|
| **RA2**   | 8-bit DAC output                | Audio → amp / piezo / speaker      |
| **RF0–RF7** | Voice activity LEDs             | 1 = voice playing (satisfying!)    |
| VDD/VSS   | 2.3–5.5 V (5 V best)            | Louder at 5 V                      |
| Others    | Unused                          | Leave floating                     |

**DAC note**: PIC18F57Q84 has **8-bit DAC**. The program code shifts the mix right 3× (`/8`) to stay ≈0–255 and avoid audio clipping.

## Features

- 8 monophonic voices from one waveform
- 5566-sample 8-bit pluck (~170 ms @ 32 kHz)
- 32 kHz Timer0 ISR playback
- Score steps every ~138 ms (Timer2, tunable via `PR2=135`)
- Auto-loop after full play + 5 s silence
- PORTF LEDs show active voices

## Building

### Requirements

- GCBASIC compiler
- PICkit programmer
- Small audio amp (LM386 etc.) + speaker
- Optional: 8 LEDs + 220–330 Ω resistors

### Steps

1. Load `Musicbox 18F57Q84` source in GCBASIC IDE
2. Compile → `.hex`
3. Program PIC18F57Q84
4. RA2 → RC low-pass (1 kΩ + 100 nF) → amp → speaker
5. Power on → ragtime begins

**Tempo tweak**:
```basic
Match_Val = 135   ' ↓ = faster; ↑ = slower
```

## Waveform Spectrogram Analysis

The source waveform (`PluckSoundL`) is a **single-cycle plucked string** tuned to ≈C4 (261.63 Hz) at 32 kHz sampling.

### Simulated / Typical Characteristics

A real plucked string (guitar/harp/piano-like) shows in a spectrogram:

- **Sharp attack** — broadband energy at t=0 (pluck transient excites many harmonics)
- **Strong initial high harmonics** — often up to 10–15 kHz or more
- **Rapid high-frequency decay** — upper partials fade fastest (air damping, internal friction)
- **Longer-lasting fundamental & low harmonics** — energy concentrates on f₀, 2f₀, 3f₀… over time
- **Slight inharmonicity** — higher partials stretch slightly sharp (stiff string effect)
- **Overall envelope**: exponential-like decay, brighter → darker timbre as note progresses

From literature on plucked strings (guitar C4 pizzicato, etc.):

- Fundamental ~260–265 Hz clear peak
- Harmonics at integer multiples (mostly), with amplitude roll-off
- High-frequency content strongest in first 20–100 ms
- After ~200–500 ms mostly fundamental remains

In simulation (decaying C4 sinusoid + some stiffness):

- Strong initial broadband burst
- Harmonics visible to ~8–10 kHz initially
- By 100–150 ms, mostly fundamental + first few overtones
- Matches the "plucky" character heard in the demo

**Expected visual** (time-horizontal, frequency-vertical, intensity-brightness):

```
Time → 
   ↑
Freq │  ┌─────── bright burst (attack + many harmonics)
     │  ├─────── fast fade of >3–4 kHz partials
     │  └─────── lingering low harmonics + fundamental
     └─────────────────────────────────────→ decay
```

Because the same sample is pitch-shifted crudely (no resampling/filtering), higher pitches will introduce more audible aliasing artifacts above ~8–10 kHz, but the original waveform's natural decay helps mask this in musical context.

## Toolchain & Workflow (Roger's Setup)

- **Sample**: 8-bit mono WAV → Xojo converter → BASIC `DATA` table
- **Score**: Harmony Assistant (MIDI import) → custom Street Organ export → sorting script → 16-byte/step word table
- Avoided full MIDI parsing for simplicity

## Limitations

- 32 kHz / 8 voices ≈ CPU limit (higher fs → breakup)
- Abrupt note ends (no ADSR)
- Hardcoded score (1154 steps) — edit requires table regeneration
- 8-bit output → some quantization noise (musical anyway)

## Possible Enhancements

- Simple per-voice decay (multiply by falling value)
- Waveform looping for sustained tones
- UART MIDI input → real synth
- Port to 10/12-bit DAC MCU (Q43/Q71 series)
- Multiple waveforms (toggle via pin/button)

## License

- Code: **GPL** (source header)
- Music: **Maple Leaf Rag** — public domain

## Credits

- **Roger Jönsson** (Line Audio) — idea, fixed-point trick, code, testing
- **Evan Venn** (Anobium) — docs cleanup, formatting, encouragement

Born from a lively March 2026 email thread capturing the delight of low-fi audio hacking.

Enjoy the ragtime — and hack freely!

Happy building!  
— The Music Box Crew Leader 😄  aka Roger
