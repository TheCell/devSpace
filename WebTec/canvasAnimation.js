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