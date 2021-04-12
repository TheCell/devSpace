'use strict'
const GOLDENRATIO = 1.6180339887;
let randomStart = Math.random();

function getRandomColor(saturation = 0.25, vibrance = 0.95) {
    // see https://martin.ankerl.com/2009/12/09/how-to-create-random-colors-programmatically/
    randomStart += GOLDENRATIO;
    randomStart %= 1;
    return HSVtoRGB(randomStart, saturation, vibrance);
}

/* accepts parameters
 * h  Object = {h:x, s:y, v:z}
 * OR 
 * h, s, v
 * 0 <= h, s, v <= 1
*/
function HSVtoRGB(h, s, v) {
    var r, g, b, i, f, p, q, t;
    if (arguments.length === 1) {
        s = h.s, v = h.v, h = h.h;
    }
    i = Math.floor(h * 6);
    f = h * 6 - i;
    p = v * (1 - s);
    q = v * (1 - f * s);
    t = v * (1 - (1 - f) * s);
    switch (i % 6) {
        case 0: r = v, g = t, b = p; break;
        case 1: r = q, g = v, b = p; break;
        case 2: r = p, g = v, b = t; break;
        case 3: r = p, g = q, b = v; break;
        case 4: r = t, g = p, b = v; break;
        case 5: r = v, g = p, b = q; break;
    }
    return {
        r: Math.round(r * 255),
        g: Math.round(g * 255),
        b: Math.round(b * 255)
    };
}