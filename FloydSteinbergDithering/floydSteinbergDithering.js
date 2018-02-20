class floydSteinbergDithering
{
	constructor(palettsize, grayscale = true)
	{
		this.palettsize = palettsize;
		if (palettsize > 1)
		{
			this.colorGapSize = Math.round(256 / this.palettsize);
		}
		else
		{
			this.colorGapSize = 256;
		}
		this.convertToGrayscale = grayscale;
	}

	getImage(img)
	{
		img.loadPixels();
		let currentPixel = 0;

		let oldPixelR = null;
		let oldPixelG = null;
		let oldPixelB = null;
		let oldPixelA = null;

		let newPixelR = null;
		let newPixelG = null;
		let newPixelB = null;
		let newPixelA = null;

		let quantErrorR = null;
		let quantErrorG = null;
		let quantErrorB = null;
		let quantErrorA = null;

		for (let i = 0; i < 4 * (img.width * img.height); i +=4)
		{
			oldPixelR = img.pixels[i];
			oldPixelG = img.pixels[i + 1];
			oldPixelB = img.pixels[i + 2];
			// oldPixelA = img.pixels[i + 3];

			if (this.convertToGrayscale)
			{
				let grayValue = (oldPixelR + oldPixelG + oldPixelB) / 3;
				oldPixelR = grayValue;
				oldPixelG = grayValue;
				oldPixelB = grayValue;
			}

			newPixelR = this.getClosestPaletteColor(oldPixelR);
			newPixelG = this.getClosestPaletteColor(oldPixelG);
			newPixelB = this.getClosestPaletteColor(oldPixelB);
			// newPixelA = this.getClosestPaletteColor(oldPixelA);

			if (i < 2000)
			{
				console.log(newPixelR);
			}

			quantErrorR = oldPixelR - newPixelR;
			quantErrorG = oldPixelG - newPixelG;
			quantErrorB = oldPixelB - newPixelB;
			// quantErrorA = oldPixelA - newPixelA;

			// set current pixel
			img.pixels[i] = newPixelR;
			img.pixels[i + 1] = newPixelG;
			img.pixels[i + 2] = newPixelB;
			// img.pixels[i + 3] = oldPixelA;

			// add error to right pixel
			img.pixels[i + 4] = img.pixels[i + 4] + quantErrorR * 7/16;
			img.pixels[i + 5] = img.pixels[i + 5] + quantErrorG * 7/16;
			img.pixels[i + 6] = img.pixels[i + 6] + quantErrorB * 7/16;
			// img.pixels[i + 7] = img.pixels[i + 7] + quantErrorA * 7/16;

			// add error to bottom left pixel
			img.pixels[i + img.width * 4 - 4] = img.pixels[i + img.width * 4 - 4] + quantErrorR * 3/16;
			img.pixels[i + img.width * 4 - 3] = img.pixels[i + img.width * 4 - 3] + quantErrorG * 3/16;
			img.pixels[i + img.width * 4 - 2] = img.pixels[i + img.width * 4 - 2] + quantErrorB * 3/16;
			// img.pixels[i + img.width * 4 - 1] = img.pixels[i + img.width * 4 - 1] + quantErrorA * 3/16;

			// add error to bottom centre pixel
			img.pixels[i + img.width * 4] = img.pixels[i + img.width * 4] + quantErrorR * 5/16;
			img.pixels[i + img.width * 4 + 1] = img.pixels[i + img.width * 4 + 1] + quantErrorG * 5/16;
			img.pixels[i + img.width * 4 + 2] = img.pixels[i + img.width * 4 + 2] + quantErrorB * 5/16;
			// img.pixels[i + img.width * 4 + 3] = img.pixels[i + img.width * 4 + 3] + quantErrorA * 5/16;

			// add error to bottom right pixel
			img.pixels[i + img.width * 4 + 4] = img.pixels[i + img.width * 4 + 4] + quantErrorR * 1/16;
			img.pixels[i + img.width * 4 + 5] = img.pixels[i + img.width * 4 + 5] + quantErrorG * 1/16;
			img.pixels[i + img.width * 4 + 6] = img.pixels[i + img.width * 4 + 6] + quantErrorB * 1/16;
			// img.pixels[i + img.width * 4 + 7] = img.pixels[i + img.width * 4 + 7] + quantErrorA * 1/16;
		}

		img.updatePixels();
		return img;
	}

	getClosestPaletteColor(pixelValue)
	{
		let gapCount = Math.round(pixelValue / this.colorGapSize);
		return gapCount * this.colorGapSize;
	}
}