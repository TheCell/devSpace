"use strict";

let inputSketch = function (p)
{
	let img = null;

	p.preload = function ()
	{
		img = p.loadImage("images/snowboardLittle.jpg");
	}

	p.setup = function ()
	{
		p.createCanvas(img.width / 2, img.height / 2);
		p.image(img, 0, 0, img.width / 2, img.height / 2);
	}

p.draw = function ()
	{

	}
}

let outputSketch = function (p)
{
	let img = null;
	let factor = 1;

	p.preload = function ()
	{
		img = p.loadImage("images/snowboardLittle.jpg");
	}

	p.setup = function ()
	{
		p.createCanvas(img.width / 2, img.height / 2);
		p.noSmooth();
	};

	p.draw = function ()
	{
		let fsd = new floydSteinbergDithering(factor);
		img = fsd.getImage(img);
		p.image(img, 0, 0, img.width / 2, img.height / 2);
		console.log("drawing");
	};

	p.mousePressed = function ()
	{
		factor = (factor * 2) % 255;
		console.log("mouse pressed, factor: " + factor);
		img = p.loadImage("images/snowboardLittle.jpg");
	};
};

let inputImageCanvas = document.getElementById('inputImageCanvas');
let outputImageCanvas = document.getElementById('outputImageCanvas');

new p5(inputSketch, 'inputImageDiv');
new p5(outputSketch, 'outputImageDiv');

