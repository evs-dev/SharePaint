// file:///E:/Games/PICO-8/SharePaint/index.html?pixels=A2B36CD36IG12F19J1

function loadOldEncoding() {
    const urlParams = new URLSearchParams(window.location.search);
    if (!urlParams.has('pixels')) return;
    const rows = urlParams.get('pixels').split(';');
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
    if (urlParams.has('bg')) {
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
        let char = pixels[i];
        if (isLetter(char) || i == pixels.length - 1) {
            // Save previous to runs if exists
            if (currentColourNumber >= 0 && currentColourLength > 0) {
                runs.push({ colourNumber: currentColourNumber, colourLength: currentColourLength });
            }
            currentColourNumber = letterToColourNumber(char);
            currentColourLength = 1;
        } else {
            let numberString = '';
            let n = i;
            while (n < pixels.length && !isLetter(pixels[n])) {
                numberString += pixels[n];
                n++;
            }
            let finalLength = parseInt(numberString);
            if (finalLength <= 0) {
                finalLength = 1;
            }
            currentColourLength = finalLength;
            i = n - (n == pixels.length ? 2 : 1);
        }
        //console.log(i);
        //console.log(currentColourNumber);
        //console.log(currentColourLength);
    }

    //runs.forEach((v) => console.log([v.currentColourNumber, v.currentColourLength]));
    //console.log(pixels);
    console.log(runs);

    let runIndex = -1;
    let remainingColourLength = 0;
    for (let y = 0; y <= 15; y++) {
        const index = 8192 + y * 128;
        for (let x = 0; x <= 15; x++) {
            if (remainingColourLength <= 0 && runIndex < runs.length - 1) {
                runIndex++;
                console.log(runIndex);
                remainingColourLength = runs[runIndex].colourLength;
            }
            remainingColourLength--;

            _cartdat[index + x] = (runs[runIndex].colourNumber) + 32;
        }
    }
}
