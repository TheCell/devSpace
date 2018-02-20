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
	let fsd = new floydSteinbergDithering(4);

	p.preload = function ()
	{
		img = p.loadImage("images/snowboardLittle.jpg");
	}

	p.setup = function ()
	{
		p.createCanvas(img.width / 2, img.height / 2);
		// p.image(img, 0, 0, img.width / 2, img.height / 2);
		img = fsd.getImage(img);
		p.image(img, 0, 0, img.width / 2, img.height / 2);
	};

	p.draw = function ()
	{

	};

	// p.mousePressed = function ()
	// {
	// 	gray = (gray + 16) % 256;
	// };
};

let inputImageDiv = document.getElementById('inputImageDiv');
let outputImageDiv = document.getElementById('outputImageDiv');

new p5(inputSketch, inputImageDiv);
new p5(outputSketch, outputImageDiv);

