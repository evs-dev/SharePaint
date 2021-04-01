// file:///E:/Games/PICO-8/SharePaint/index.html?pixels=A2B36CD36IG12F19J1

function loadOldEncoding() {
    const urlParams = new URLSearchParams(window.location.search);
    if (!urlParams.has('world')) return;
    const rows = urlParams.get('world').split(';');
    if (rows.length !== 16) return;
    const bg = urlParams.has('bg') ? parseInt(urlParams.get('bg')) : 12; // Light blue

    for (let y = 0; y <= 15; y++) {
        const index = 8192 + y * 128;
        const row = rows[y].split(',');
        for (let x = 0; x <= 15; x++) {
            const tile = row[x];
            _cartdat[index + x] = (tile ? parseInt(tile) : bg) + 32;
        }
    }
}

function letterToColourNumber(letterChar) {
    // 'A' = 65
    return letterChar.toUpperCase().charCodeAt(0) - 65;
}

function isLetter(char) {
    return 'abcdefghijklmnopqrstuvwxyz'.includes(char.toLowerCase());
}

function loadPixels() {
    const urlParams = new URLSearchParams(window.location.search);
    _cartdat[8192 + 16] = urlParams.has('outline') ? parseInt(urlParams.get('outline')) : 1;

    if (urlParams.has('world') || urlParams.has('bg')) {
        loadOldEncoding();
        return;
    }

    if (!urlParams.has('pixels')) return;

    // Split into list of characters
    const pixels = urlParams.get('pixels').split('');

    // Make runs
    const runs = [];
    let currentColourNumber = -1;
    let currentColourLength = 0;
    for (let i = 0; i < pixels.length; i++) {
        const char = pixels[i];
        if (isLetter(char)) {
            // Save previous to runs if exists
            if (currentColourNumber >= 0 && currentColourLength > 0) {
                runs.push({ colourNumber: currentColourNumber, colourLength: currentColourLength });
            }
            currentColourNumber = letterToColourNumber(char);
            // Enables letters without subsequent numbers to count as length 1
            currentColourLength = 1;
            // Allow the final letter to have no number and just fill the rest of the canvas
            if (i == pixels.length - 1) {
                runs.push({ colourNumber: currentColourNumber, colourLength: currentColourLength });
            }
        } else {
            let numberString = char;
            let n = i + 1;
            while (n < pixels.length && !isLetter(pixels[n])) {
                numberString += pixels[n];
                n++;
            }
            currentColourLength = parseInt(numberString);
            // Skip to next letter or end of pixels
            i = n - (n == pixels.length ? 2 : 1);
        }
    }

    console.log(runs);

    let runIndex = -1;
    let remainingColourLength = 0;
    for (let y = 0; y <= 15; y++) {
        const index = 8192 + y * 128;
        for (let x = 0; x <= 15; x++) {
            if (remainingColourLength <= 0 && runIndex < runs.length - 1) {
                runIndex++;
                remainingColourLength = runs[runIndex].colourLength;
            }
            remainingColourLength--;

            _cartdat[index + x] = runs[runIndex].colourNumber + 32;
        }
    }
}
