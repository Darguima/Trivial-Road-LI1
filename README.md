# Trivial-Road LI1

## About the Project

This project was developed for the LI1 University of Minho Subject of the Software Engineering degree. This was our first project developed in the university and we were very impressed with the result.

#### Grade ⭐️ 19/20

### Demo 📽️

![Demo Image](./readme/demo.png)

https://user-images.githubusercontent.com/49988070/210379668-3602bce1-2cd6-43e8-901b-61e537cb54d5.mp4

### GamePad 🎮

The game is compatible with gamepads.

###### I'm lying, just remap the gamepad with [`qjoypad`](https://github.com/panzi/qjoypad)

https://user-images.githubusercontent.com/49988070/211230247-414fadf8-816c-45dc-8da8-826a0fe67c37.mp4

### Features

* Smooth Gameplay
* Bot
* There are no impossible paths in the grass paths (there is always a passage between the trees)
* Scoring System, which notifies when the maximum score has been achieved

### Controls ⌨️ (Keyboard Only)

* **Arrows** - Move the player
* **Space** - Advances the map without moving the player
* **Esc** - Enter Pause mode
* **Enter / Space** - Select options within the Menus

## Download 📥📲

You can download the game on [project's releases](https://github.com/Darguima/Trivial-Road-LI1/releases).

### The goal ⛳️

As you can easily see on the demo, the goal was develop a clone of Crossy Road game with Gloss library from Haskell.

### About the Code 🧑‍💻

Trying to bring our past coding knowledge to the project, we tried at maximum modularize the code, and make it as clean as possible. We also tried to use the best practices of the functional programming paradigm.

## Getting Started 🚀

#### Cloning the repository

```bash
$ git clone https://github.com/Darguima/Trivial-Road-LI1.git
$ git clone git@github.com:Darguima/Trivial-Road-LI1.git
```

## Compiler

To compile the code you can use `cabal`:

```bash
$ mkdir TrivialRoad -p
$ rm -r ./dist-newstyle/build &> /dev/null
$ cabal build
$ mv ./src/Main ./TrivialRoad/trivialRoad
$ cp ./assets ./TrivialRoad -r
$ cp ./highscore.txt ./TrivialRoad

# Single Command
$ mkdir TrivialRoad -p; rm -r ./dist-newstyle/build &> /dev/null; cabal build; mv ./src/Main ./TrivialRoad/trivialRoad; cp ./assets ./TrivialRoad -r; cp ./highscore.txt ./TrivialRoad
```

It will generate a `TrivialRoad` folder that contains all the necessary files for the game to run.

```bash
# Linux
$ ./TrivialRoad/trivialRoad
```

Now you can compress the folder and send it anywhere, without the need to have Haskell on other computers.

## Interpreter

You can open the Haskell interpreter (GHCi) using cabal or directly in the interpreter.

1. With `cabal`

```bash
$ cabal repl
>>> main
```

2. With GHCi (on root folder of the project)

```bash
$ ghci -i="src" -i="tests" src/Main.hs
>>> main
```

## Tests

This project uses the [HUnit](https://hackage.haskell.org/package/HUnit) library to run unit tests.

You can run the tests using one of the following alternatives:

1. With `cabal`

```bash
$ cabal test
```

2. With GHCi

```bash
$ ghci -i="src" -i="tests" tests/Spec.hs
>>> runTestsT1 -- Correr os testes tarefa 1
>>> runTestsT2 -- Correr os testes tarefa 2
>>> runTestsT3 -- Correr os testes tarefa 3
>>> runTestsT4 -- Correr os testes tarefa 4
>>> main -- Correr todos os testes
```

3. With the wrapper `runhaskell`

```bash
$ runhaskell -i="src" -i="tests" tests/Spec.hs
```

## Docs

You can generate the documentation with [Haddock](https://haskell-haddock.readthedocs.io/).

1. With `cabal`

```bash
$ cabal haddock --haddock-all
```

2. With `haddock`

```bash
$ haddock -h -o doc/html src/*.hs
```

## Developed by 🧑‍💻:

- [Afonso Pedreira](https://github.com/afooonso)
- [Dário Guimarães](https://github.com/darguima)
