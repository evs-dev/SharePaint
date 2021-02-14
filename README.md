# SharePaint

A <img src="https://hb.imgix.net/daa4f4f06ae0362be8738d5a33f17ca31bf298b3.png?auto=compress,format&s=353a7629fd36a8da21de78f42f7f4bea" width="18px"/> [PICO-8](https://www.lexaloffle.com/pico-8.php) app for creating and sharing pixel paintings.

https://evs-dev.github.io/SharePaint

## Usage

`sharepaint.js` has the ability to parse URL parameters into an image displayed using the map system in PICO-8. To save a drawing, press Enter to open the pause menu and select "`SAVE WORLD`", and press CTRL+C. This should copy your drawing to text in your clipboard, which you can insert into a URL.

Here are the current URL parameters:
- `world` - the drawing pixel data. Drawings are 16x16, and are separated into rows by `;`. Each pixel in a row is separated by `,`, but some are left out because they are majority-coloured pixels; they will be the colour specified by `bg`.
- `bg` - the background colour which `world` substitutes in to empty pixel data (e.g. an empty row [`;`] will be the colour specified by `bg` instead of some default colour). If no colour is specified, it defaults to 12 (light blue). `bg` is added automatically by `save_world()` in `sharepaint.js` and is determined by finding the most common colour (the majority).
- `outline` - whether or not the in-app selection outline is visible or not by default (0 = invisible, >0 = visible). Can be toggled in-app by pressing Enter and selecting the "`TOGGLE OUTLINE`" option.

Here is an example of a URL:

https://evs-dev.github.io/SharePaint?world=;;,,,,14,14,,,,,14,14,;,,,14,14,14,14,,,14,14,14,14,;,,14,14,14,14,14,14,14,14,7,7,14,14,;,,14,14,14,14,14,14,14,14,14,7,14,14,;,,,14,14,14,14,14,14,14,14,14,14,;,,,8,14,14,14,14,14,14,14,14,14,;,,,8,14,14,14,14,14,14,14,14,14,;,,,,8,14,14,14,14,14,14,14,;,,,,,8,14,14,14,14,8,;,,,,,,8,8,8,8,;;;;&bg=2&outline=0

which results in this:

<img src="https://i.imgur.com/GdQbvAh.png" width="40%"/>
