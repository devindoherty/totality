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

### Bugs
- Character creation screen points are somewhat borked
- Inputting text in dialog is literaly keyboard key strings
- Getting attacked by two enemies at once infinitely loops
- Likely more

# What did I do?
Made a retro fantasy RPG.

# Why did I design that way?
Used the StateMachine pattern because it seemed the most logical way to organize the code. The basis of the game world is the tile, the item, and the mob, with the player being its own distinct mob-like entity.  

Game loop goes something like this:

start state -> character creation state -> world_state -> player turn state -> mob turn state -> world state and looping from there.

Can also break from player state to dialog state and help state.

# What is contained in each file?
Every state is organized under the State folder. All art and music is in assets. And data that could be serialized  is in the data folder. Everything else is a main or class file. The main gamestate is contained in main.
- Tiles are immobile terrain pieces like walls and trees and such. 
- Items are interactible objects in the world like furniture and pickups. 
- Mobs are mobile entities representing creatures and other beings like that.
- Map contains all the above in tables.
- Attack is an object created when hostile creatures bump each other
- Constants sets constants
- Gamestate is the state machine
- Interact is for the interacting action in game, mostly closing doors and talking to NPCs
- Dialog is attached to mobs for conversation interaction
- Sprite reads the graphics for tables

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

## How would you rate your own design? Place an X in one of the set of brackets below. (Your answer will not have an impact on how the staff scores your design)

[ ] 1 - Poor. Work demonstrates poor understanding of week's concepts and problem set. Substantial improvements needed.

[ ] 2 - Fair. Work demonstrates fair understanding of week's concepts and problem set. Significant improvements needed.

[ ] 3 - Good. Work demonstrates good understanding of week's concepts and problem set. Some improvements needed, but at the benchmark of success for this point in the course.

[X] 4 - Better. Work demonstrates better than "good" understanding of week's concepts and problem set. Few improvements needed. Beyond the benchmark of success for this point in the course.

[ ] 5 - Best. Exceptional. No room for improvement. No modifications could improve efficiency.