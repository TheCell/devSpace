"use strict";

function drawOnCanvas()
{
    let canvas = document.getElementById("animationCanvas");
    let colorInput = document.getElementById("drawcolor");

    let ctx = canvas.getContext("2d");
    ctx.fillStyle = "rgb(255, 255, 255)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    drawPaperPlane(ctx, colorInput.value);
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

drawOnCanvas();

function setTheme()
{
    let webtheme = "dark";

    let cookieSetting = getCookie("webtheme");
    if (cookieSetting)
    {
        webtheme = cookieSetting;
    }

    if (webtheme == "dark")
    {
        // replace all light theme with dark theme
        let elementsWithClass = document.getElementsByClassName("lightTheme");
        for (let i = elementsWithClass.length -1; i >= 0 ; i--)
        {
            elementsWithClass[i].classList.add("darkTheme");
            elementsWithClass[i].classList.remove("lightTheme");
            /*
            let newClassString = elementsWithClass[i].className.replace( /(?:^|\s)lightTheme(?!\S)/g , '' );
            elementsWithClass[i].className += " darkTheme";
            elementsWithClass[i].className = newClassString;
            */
        }
    }
    else
    {
        // replace all dark theme with light theme
        let elementsWithClass = document.getElementsByClassName("darkTheme");
        for (let i = elementsWithClass.length -1; i >= 0 ; i--)
        {
            elementsWithClass[i].classList.add("lightTheme");
            elementsWithClass[i].classList.remove("darkTheme");
            /*
            let newClassString = elementsWithClass[i].className.replace( /(?:^|\s)darkTheme(?!\S)/g , '' );
            elementsWithClass[i].className += " lightTheme";
            elementsWithClass[i].className = newClassString;
            */
        }
    }
}

function toggleColor()
{
    let webtheme = "dark";

    let cookieSetting = getCookie("webtheme");
    if (cookieSetting)
    {
        webtheme = cookieSetting;
    }

    if (webtheme == "dark")
    {
        setCookie('webtheme', "light", 1);
    }
    else
    {
        setCookie('webtheme', "dark", 1);
    }
    setTheme();
}

function setCookie(cname, cvalue, exdays)
{
    let d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(name)
{
    let value = "; " + document.cookie;
    let parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
}

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