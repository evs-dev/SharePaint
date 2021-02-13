function loadWorld() {
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

loadWorld();
