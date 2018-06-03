'use strict';

class VoronoiEngine
{
	constructor()
	{
		this.beachLine = 0;
		this.imagedata = "";
		this.imageWidth = 300;
		this.imageHeight = 100;
		this.NumberOfPoints = 10;
	}

	generateExample()
	{
		// todo
	}

	voronoiPoints(xLength, yLength)
	{
		let randomPoints = this.randomPointsInBoundaries(
			this.NumberOfPoints,
			this.imageWidth,
			this.imageHeight);
	}

	randomPointsInBoundaries(NumberOfPoints, xLength, yLength)
	{
		let randomPoints = [];
		for (let i = 0; i < NumberOfPoints; i++)
		{
			randomPoints.push(
				{x: Math.round(Math.random() * xLength),
				 y: Math.round(Math.random() * yLength)}
			);
		}

		return randomPoints;
	}
}