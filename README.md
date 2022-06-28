# Game of Life

In this project, we will implement [Conways's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), and
attempt to make your implementation as fast as possible

The Game of Life, also known simply as Life, is a cellular automaton
devised by the British mathematician John Horton Conway in 1970. It
is a zero-player game, meaning that its evolution is determined by
its initial state, requiring no further input. One interacts with the
Game of Life by creating an initial configuration and observing how
it evolves.
(Source: Wikipedia)

## Rules of the Game of Life
The universe of the Game of Life is an infinite, two-dimensional
orthogonal grid of square cells, each of which is in one of two
possible states, live or dead. Every cell interacts with its eight
neighbors, which are the cells that are horizontally, vertically, or
diagonally adjacent. At each step in time, the following transitions
occur:
• Any live cell with two or three live neighbors survives.
• Any dead cell with three live neighbors becomes a live cell.
• All other live cells die in the next generation. Similarly, all
other dead cells stay dead.
(Source: Wikipedia)


To make the program just run the Makefile
```
$ make
```

Usage:
```
./life <map> <iterations>
```
e.g.
```
./life states/tests/diehard 1000
```
the last locations of the cells after 1000 iterations will be printed out.

# GUI Bonus
(you can draw with the mouse on the maps!)

Usage:
```
$ ./life_gi states/tests/diehard
```

'r' = reset
'esc' = exit
'space' = pause

![](https://github.com/maxrantil/game_of_life/blob/main/gifs/diehard.gif)

Usage:
```
$ ./life_gi states/big_map
```

![](https://github.com/maxrantil/game_of_life/blob/main/gifs/big_map.gif)

Usage:
```
$ ./life_gi states/tests/dinnertable
```

![](https://github.com/maxrantil/game_of_life/blob/main/gifs/dinnertable.gif)

Usage:
```
$ ./life_gi states/fullscreen.txt
```

![](https://github.com/maxrantil/game_of_life/blob/main/gifs/fullscreen.gif)
