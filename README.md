# Tic-Tac-Toe

This is a Tic-Tac-Toe game made Flutter.

## Screenshots

### Mode Selection

![Mode selection screen](./screenshots/mode-selection-screen.png)

### Game

![Game screen](./screenshots/game-screen.png)

### Modals

![Vs Player win modal](./screenshots/vs-player-win-modal.png)
![Lose modal](./screenshots/vs-cpu-lose-modal.png)
![Restart modal](./screenshots/restart-modal.png)
![Draw modal](./screenshots/draw-modal.png)

## Process

<!-- Design credit -->

### Board representation

The board is represented as a 2D List of BoardTokens (see [lib/board.dart](./lib/board.dart)). The methods modify the board in-place.

The CPU is done using the minimax algorithm. Since Tic-Tac-Toe is a simple game with around 9! (362,880) possible states, which is relatively few for a computer to go through, the CPU is impossible to beat. YOu can either draw with it or lose.

### State management

State management is done using Flutter Stateful widgets only. Since my goal with this project was to understand how Flutter works conceptually, I leaned in more towards solution provided by the Flutter framework itself. The state being managed is not only for the game logic, but also for the simple animations I have in this project.

It is not very likely, but I may refactor this project using third party state management libraries, like [GetX]() or [flutter_redux]().

## Useful Resources
