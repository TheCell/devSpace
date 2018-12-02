"use strict";
Math.lerp = function (value1, value2, amount)
{
    amount = amount < 0 ? 0 : amount;
    amount = amount > 1 ? 1 : amount;
    return value1 + (value2 - value1) * amount;
};

function drawOnCanvas()
{
    let canvas = document.getElementById("animationCanvas");

    let ctx = canvas.getContext("2d");
    window.setInterval(animateCanvas, 50);
}

function animateCanvas()
{
    if (typeof(window.animationLerp) != "undefined")
    {
        if (window.animationLerp > 1.0)
        {
            window.animationLerp = 0;
        }
        else
        {
            window.animationLerp = window.animationLerp + 0.04;
        }
    }
    else
    {
        window.animationLerp = 0;
    }
    let canvas = document.getElementById("animationCanvas");
    let ctx = canvas.getContext("2d");
    ctx.fillStyle = "rgb(255, 255, 255)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    animatePlane(ctx, window.animationLerp);
}

function animatePlane(ctx, lerpValue)
{
    ctx.save();
    let rotationRadiant = -Math.lerp(0, Math.PI / 16, lerpValue);
    ctx.rotate(rotationRadiant);
    let colorInput = document.getElementById("drawcolor");
    drawWind(ctx);
    drawPaperPlane(ctx, colorInput.value);
    ctx.restore();
}

function drawPaperPlane(ctx, color)
{
    ctx.fillStyle = color;
    ctx.lineWidth = 5;
    ctx.strokeStyle = color;
    ctx.beginPath();
    ctx.moveTo(180, 77);
    ctx.lineTo(55.5, 96);
    ctx.lineTo(86, 122);
    ctx.lineTo(90.5, 158);
    ctx.lineTo(106, 132);
    ctx.lineTo(150.5, 146);
    ctx.lineTo(180, 77);
    ctx.stroke();
    // width = "250px" height = "200px"
    ctx.closePath();

    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.moveTo(180, 77);
    ctx.lineTo(86, 122);
    ctx.lineTo(180, 77);
    ctx.lineTo(106, 132)
    ctx.stroke();
    ctx.closePath();
}

function drawWind(ctx)
{
    let color = "rgb(40, 70, 200)";

    ctx.lineWidth = 5;
    ctx.strokeStyle = color;
    ctx.beginPath();
    ctx.moveTo(71,110);
    ctx.quadraticCurveTo(47,109,43,126);
    ctx.quadraticCurveTo(32,152,17,139);
    ctx.stroke();
    ctx.closePath();

    ctx.beginPath();
    ctx.moveTo(71+18,110+33);
    ctx.quadraticCurveTo(47+18,109+33,43+18,126+33);
    ctx.quadraticCurveTo(32+18,152+33,17+18,139+33);
    ctx.stroke();
    ctx.closePath();

    ctx.beginPath();
    ctx.moveTo(71+71,110+35);
    ctx.quadraticCurveTo(47+71,109+35,43+71,126+35);
    ctx.quadraticCurveTo(32+71,152+35,17+71,139+35);
    ctx.stroke();
    ctx.closePath();
}

drawOnCanvas();

// helpfull things
function getMousePos(canvas, evt)
{
    let rect = canvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}
let canvasToDrawTo = document.getElementById('animationCanvas');
let context = canvasToDrawTo.getContext('2d');

canvasToDrawTo.addEventListener('mouseup', function (evt)
{
    let mousePos = getMousePos(canvasToDrawTo, evt);
    let message = 'ctx.lineTo(' + mousePos.x + ',' + mousePos.y + ')';
    console.log(message);
}, false);