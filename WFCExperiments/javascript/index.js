function setup()
{
	imgUrlToData("firstPattern.png", start);
}

setup();

function imgUrlToData(path, callback)
{
	let img = document.createElement("img");
	img.src = path;
	img.onload = function (e)
	{
		console.log(`loaded image size: x${this.width} y${this.height}`);
		let canvas = document.createElement("canvas");
		canvas.width = this.width;
		canvas.height = this.height;
		let ctx = canvas.getContext("2d");
		ctx.drawImage(this, 0, 0);
		// display input
		document.body.appendChild(canvas);
		callback(ctx.getImageData(0, 0, this.width, this.height));
	}
}

function start(imageData)
{
	let output = document.getElementById("output");
	let width = output.width;
	let height = output.height;
	ctx = output.getContext("2d");
	let imgData = ctx.createImageData(width, height);
	// input, width, height, N, outputWidth, outputHeight,
	// periodicInput, periodicOutput, symmetry, ground
	let model = new OverlappingModel(
		imageData.data,
		imageData.width,
		imageData.height,
		2,
		width,
		height,
		true,
		false,
		1,
		0);
	let success = model.generate(Math.random, 0);
	model.graphics(imgData.data)
	ctx.putImageData(imgData, 0, 0);
	console.log(success);

	if (success == false)
	{
		start(id); // try again, possibly endless
	}
	else
	{
		let world = [];
		for (let y = 0; y < 48; y++)
		{
			let row = [];
			for (let x = 0; x < 48; x++)
			{
				let color = getPixel(imgData, x, y).join(":");
				row.push(colormap[color]);
			}

			world.push(row);
		}
		console.log(world);
	}
}

function getPixel(imgData, x, y)
{
	let index = y*imgData.width+x;
	let i = index*4;
	let d = imgData.data;
	return [d[i],d[i+1],d[i+2],d[i+3]];
}

let colormap = {
	"0:0:0:255":1, //black
	"0:0:0:0":1, //black
	"255:255:255:255":0, //white
	"255:255:255:0":0 //white
}