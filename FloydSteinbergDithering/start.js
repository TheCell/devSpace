let img;

function preload()
{
	img = loadImage("images/snowboardLittle.jpg");
}

function setup()
{
	createCanvas(img.width / 2, img.height / 2);
	image(img, 0, 0, img.width / 2, img.height / 2);
	createCanvas(img.width / 2, img.height / 2);
	image(img, 0, 0, img.width / 2, img.height / 2);
}