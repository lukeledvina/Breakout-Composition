# Breakout-Composition

## Project Goals
Make a Breakout clone ( Completed )
Prioritize Composition over inheritance ( there were not many opportunities to do this on this project, and when there were I mostly did not execute properly )
Save high-score between play sessions ( Completed )

## Lessons Learned
The "game.gd" script for this game does way too many functions. What it should be doing is connecting a bunch of different functionality of the components under it in a relatively short script. What I did was bundle a ton of diverse functionality into one single script, instead of breaking it up into multiple isolated components, and then connecting them together through the game script.
So in the future if I ever realize that a script is serving many more purposes than a single script should, I will intervene and refactor if necessary in order to split that functionality into individual reusable components so that the code base is easier to understand, more reusable, and overall cleaner.

Also, in my "ball.gd" script, I have a ton of repeated code for when the ball is interacting with other bodies, which really should have been put into a function very early on, so just don't half-ass things and when you realize some amount of code will be repeated, put it in a function so that stuff doesn't have to be copy-pasted for the rest of development.
