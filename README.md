# SharePaint

A <img src="https://hb.imgix.net/daa4f4f06ae0362be8738d5a33f17ca31bf298b3.png?auto=compress,format&s=353a7629fd36a8da21de78f42f7f4bea" width="18px"/> [PICO-8](https://www.lexaloffle.com/pico-8.php) app for creating and sharing pixel paintings.

https://evs-dev.github.io/SharePaint

## Usage

`sharepaint.js` has the ability to parse URL parameters into an image displayed using the map system in PICO-8. To save a drawing, press Enter to open the pause menu and select "`SAVE PIXELS`", and press CTRL+C. This should copy your drawing to text in your clipboard, which you can insert into a URL.

Here are the current URL parameters:
- `pixels` - the pixel data encoded with run-length encoding. Letters correspond to PICO-8 colours (A = 0 = black, H = 7 = white, etc.). Numbers are the run lengths. If there is no number following a letter, the number is presumed to be 1 unless the letter is the last character, in which case it stretches to the end of the canvas.
- `outline` - whether or not the in-app selection outline is visible or not by default (0 = invisible, >0 = visible). Can be toggled in-app by pressing Enter and selecting the "`TOGGLE OUTLINE`" option.

Here is an example of a URL:

https://evs-dev.github.io/SharePaint?pixels=c36o2c4o2c7o4c2o4c5o8h2o2c4o9ho2c5o10c6io9c6io9c7io7c9io4ic11i4c&outline=0

which results in this:

<img src="https://i.imgur.com/GdQbvAh.png" width="40%"/>
