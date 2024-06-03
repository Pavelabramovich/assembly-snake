# Assembly Snake🐍

Snake game implementation on TASM.

## Installation

To run it, just compile game.asm and run it in DosBox. The file for recording records
will be created automatically if it does not exist yet.

## Gameplay

#### Rules

- Field size if 16x16.
- Border teleports the snake to the opposite side of the field.
- If the snake runs into itself, YOU LOSE.
- For every eaten apple user get a point.
- Victory when the snake takes over the entire field.

#### Regimes

- User can choose one of three modes: easy, medium and hard.
- Each regime have a 67ms difference.

#### Game control

- User can control snake using the WASD keys or the arrow keys.
- To pause, press the space bar.
- To select different options in the menu user can use the arrow keys or the WS keys.
- To return from records to the menu press enter.
- User can exit a game at any time using the escape key.

#### Keeping records

- After the end of each game, if the user's current score more then record in a selected mode, a record will be overwritten.
- If a records file does not exists, it will be created automatically.

## Screenshots

- Menu page <br></br>
  ![Alt Text](https://i.ibb.co/X8JYSWt/image.png)
- Records <br></br>
  ![Alt Text](https://i.ibb.co/RP9NWBC/image.png)
- Regimes page <br></br>
  ![Alt Text](https://i.ibb.co/hsQbWCp/image.png)
- Game <br></br>
  ![Alt Text](https://i.postimg.cc/05H1yJNw/ezgif-com-crop.gif)
- Pause <br></br>
  ![Alt Text](https://i.ibb.co/v1CJX5Z/image.png)
- Game over <br></br>
  ![Alt Text](https://i.ibb.co/PQ0yzsn/image.png)
