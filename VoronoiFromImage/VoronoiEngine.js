'use strict';
// See http://www.wias-berlin.de/people/si/course/files/Fortune87-SweepLine-Voronoi.pdf
// for the paper

class VoronoiEngine
{
	constructor()
	{
		this.beachLine = 0;
		this.imagedata = "";
		this.imageWidth = 300;
		this.imageHeight = 100;
		this.numberOfSeedPoints = 10;
		this.seedPoints = [];

		// just demo things. Generate for debug
		this.generateExample();
	}

	generateExample()
	{
		// generate random Points as Voronoi seed
		this.seedPoints = this.randomPointsInBoundaries(
			this.numberOfSeedPoints,
			this.imageWidth,
			this.imageHeight);

		// sort by x if equal then by y
		this.seedPoints.sort((objA, objB) => {
			let lowerX = objA.x - objB.x;
			if (lowerX == 0)
			{
				let lowerY = objA.y - objB.y;
				return lowerY
			}
			return lowerX });
	}

	/**
	 * Draws seeds.
	 *
	 * @param      {object}  ctx     The canvas 2d context
	 */
	drawSeeds(ctx)
	{
		for (let i = this.seedPoints.length - 1; i >= 0; i--)
		{
			let currentPoint = this.seedPoints[i];
			ctx.beginPath();
			ctx.arc(currentPoint.x,currentPoint.y,1,0,2*Math.PI);
			ctx.fill();
		}
	}

	/**
	 * generate random # Points inside a rectangular
	 *
	 * @param      {number}  numberOfSeedPoints  The number of seed points
	 * @param      {number}  xLength             The x length of the bounding box
	 * @param      {number}  yLength             The y length of the bounding box
	 * @return     {Array}   [{x: int, y: int },... ]
	 */
	randomPointsInBoundaries(numberOfSeedPoints, xLength, yLength)
	{
		let randomPoints = [];
		for (let i = 0; i < numberOfSeedPoints; i++)
		{
			randomPoints.push(
				{x: Math.round(Math.random() * xLength),
				 y: Math.round(Math.random() * yLength)}
			);
		}

		return randomPoints;
	}
}