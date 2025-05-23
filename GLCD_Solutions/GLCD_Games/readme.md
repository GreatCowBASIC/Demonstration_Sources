# Invaders Shooting Game

## Description
A retro-style target-shooting game designed for a microcontroller-based platform. The game displays a blue background populated with "Alien" symbols representing targets or enemies, along with a small robot at the bottom of the screen for gameplay interaction.

## Features
- **Visuals**:
  - Blue background with dynamic "alien" targets.
  - Player-controlled robot at the bottom for shooting and movement.
- **Gameplay**:
  - Player navigates and interacts with targets to score points.
  - Retro-style mechanics for nostalgic appeal.
- **Hardware**:
  - ILI9341 display module.
  - Housed in a red frame with a connected microcontroller for game logic.
  - Three switches: left, right, and fire. Switches are pulled low.
- **Development Context**:
  - Designed as a DIY electronics project integrating display, controls, and interactive visuals.

## Notes
- Ensure appropriate pin connections for the display and input hardware.
- Calibrate the microcontroller settings for optimal performance.

---

This program is for a target-shooting game implemented on a microcontroller with an ILI9341-based graphical LCD display.

## Summary of Gameplay
The player controls a cannon and shoots rockets to destroy moving sprites while dodging bombs dropped by the sprites. The game keeps track of the score and high score, providing a visual and interactive experience.

<div style="text-align: center;">
<img src="invaders.gif" alt="The schema" width="300">
</div>

## Key Components

### Setup and Initialization
- **Color Definitions**: The `#define` directives rename predefined colours (e.g., `ILI9341_RED`) to shorter names (`re`) for easier use in sprite data configuration.
- **Variables**: Game-related variables are defined, including `hits` (score), `hiscore` (high score), and sprite-specific attributes (e.g., `sprite_x`, `sprite_y` for position, `sprite_height`, `sprite_width` for dimensions).
- **Screen Setup**: The screen background is initialized, and the score and high score are displayed.

### Game Elements
- **Sprites**: Sprites representing targets and bombs are managed with arrays for position (`spx`, `spy`), direction (`dx`, `dy`), and status (`sprite_status`).
  - Starting positions and movement directions are initialized for all sprites.
  - Bomb-related attributes are set up with counters for timing bomb drops.

### Main Game Logic (Inside Loop)
The game runs within a `do` loop, continuously updating the display and game elements:

- **Sprite Movement**: Sprites move across the screen, bouncing off the edges.
  - Positions are updated based on direction (`dx`, `dy`), and previous positions are erased using the `erase_sprite` subroutine.
  - Sprites alternate between two visual frames to create animation (`frame` and `frame_count` manage this).
- **Rocket (Player's Projectile)**:
  - When the fire button is pressed, a rocket is launched from the cannon’s current position.
  - The rocket moves upward and is erased/redrawn at each step.
  - If the rocket collides with a sprite, the sprite is destroyed, score (`hits`) is incremented, and explosions are visualized.

### Cannon Movement and Interaction
- **Left and Right Buttons**: The cannon moves horizontally in response to user inputs.
- **Shoot Button**: Fires the rocket when pressed.

### Bomb Mechanics
- **Bomb Drops**: Sprites periodically drop bombs based on counters (`bomb_counter`). Bombs move downward and collide with the cannon or reach the bottom of the screen.
- **Collision Detection**: If a bomb hits the cannon, the game ends.

### Game Over and Restart
If a sprite or bomb collides with the cannon, the `dead` section is executed, displaying a circular explosion effect, and the game restarts from the `Start` label.

### Subroutines
- **`sprite`**: Draws a sprite at a specified position.
- **`erase_sprite`**: Clears the sprite’s previous position by filling it with the background colour.

### Sprite Data Table
Contains pixel data for various elements like sprites, the cannon, and the missile. Each data point corresponds to a predefined colour.
