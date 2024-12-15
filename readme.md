# Path of Totality
Just a working title. Mainly playing around with LOVE and Lua.

## Premise
In a land beset by darkness, a hero will rise to defeat the vile shadow cast by the
cult of a lunatic god, a permanent eclipse which has blotted out the light of the sun 
itself.

## Features

### Done
- Basic player movement
- Monster movement
- Basic collision
- Basic combat
- Map rewrite
- More interesting interactions
- Talking to NPCs

### Next

- Mob AI rewrite

# What did I do?
Made a retro fantasy RPG.

# Why did I design that way?
Used the StateMachine pattern because it seemed the most logical way to organize the code. The basis of the game world is the tile, the item, and the mob, with the player being its own distinct mob-like entity. Tiles are immobile terrain pieces like walls and trees and such. Items are interactible objects in the world like furniture and pickups. Mobs are mobile entities representing creatures and other beings like that.

# What is contained in each file?
Every state is organized under the State folder. All art and music is in assets. And data that could be serialized  is in the data folder. Everything else is a main or class file. The main gamestate is contained in main.

# What setup is required?
Love 11.5.

# How does one run the application?
Run using the love.exe. I set it up to run from the command line.

# Video
Link: https://youtu.be/flFr1QbvG5c

## Attributions
- Start Screen Art: https://x.com/hydrogenpixel
- Sprites: https://kenney.nl/assets/1-bit-pack
- Portraits: https://opengameart.org/content/32x32-fantasy-portrait-set