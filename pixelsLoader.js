// Heart: c36o2c4o2c7o4c2o4c5o8h2o2c4o9ho2c5o10c6io9c6io9c7io7c9io4ic11i4c

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

function letterToColourNumber(char) {
    // 'A' = 65
    return char && char.toUpperCase().charCodeAt(0) - 65;
}

function isLetter(char) {
    return char && char.length === 1 && char.match(/[a-z]/i)
}

function loadPixels() {
    const urlParams = new URLSearchParams(window.location.search);
    _cartdat[8192 + 16] = urlParams.has('outline') ? parseInt(urlParams.get('outline')) : 1;

    if (urlParams.has('world') || urlParams.has('bg')) {
        loadOldEncoding();
        return;
    }

    if (!urlParams.has('pixels')) return;
    if (urlParams.get('pixels') == '') return;

    const pixels = urlParams.get('pixels').split('');

    // Remove trailing numbers
    while (!isLetter(pixels[pixels.length - 1])) {
        pixels.splice(pixels.length - 1, 1);
    }

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
            if (i === pixels.length - 1) {
                runs.push({ colourNumber: currentColourNumber, colourLength: 1 });
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
            i = n - (n === pixels.length ? 2 : 1);
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
