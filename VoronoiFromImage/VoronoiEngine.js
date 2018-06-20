'use strict';
// See http://www.wias-berlin.de/people/si/course/files/Fortune87-SweepLine-Voronoi.pdf
// for the paper
// http://skynet.ie/~sos/mapviewer/voronoi.php
// for a c++ solution
// http://blog.ivank.net/fortunes-algorithm-and-implementation.html
// for simpler explanation

class VoronoiEngine
{
	constructor()
	{
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
		// p, q ∈ R^2 are lexicographically ordered, p < q, if py < qy or py = qy and px < qx
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

	calculateVoronoi()
	{
		if (!this.seedPoints.length >= 1)
		{
			console.error("no seedpoints given, stopping generation");
			return;
		}

		let Q = []; // priority queue of points in the plane see sweepline paper
		let S; // Let S be a set of n points in the plane, called sites.
		let V; // V consists of the union of segments, half-lines, and lines.
		let L; // Line dividing registered points for Voronoi from yet unregistered
		let beachLine; // points and intersections which are not yet final

		Q = this.seedPoints;
		Q.forEach( function (val, index, array)
		{
			val.elementType = VoronoiEngine.elementType.SITE;
		});

		let p;
		// Sequence of regions, boundaries initiate with a copy of all p
		L = Q.slice();

		L.push
		({
			x: 0, y: 0,
			elementType: VoronoiEngine.elementType.BOUNDARIE
		});
		L.push
		({
			x: this.imageWidth, y: 0,
			elementType: VoronoiEngine.elementType.BOUNDARIE
		});
		L.push
		({
			x: 0, y: this.imageHeight,
			elementType: VoronoiEngine.elementType.BOUNDARIE
		});
		L.push
		({
			x: this.imageWidth, y: this.imageHeight,
			elementType: VoronoiEngine.elementType.BOUNDARIE
		});

		while (Q.length > 0)
		{
			p = Q.shift(); // extract minimal point
			if (p.elementType == VoronoiEngine.elementType.SITE)
			{
				console.log("is site");
			}
			else if (p.elementType == VoronoiEngine.elementType.INTERSECTION)
			{
				console.log("is intersection");
			}
		}

		//let point = ... // {x: int, y: int}
	}
}

VoronoiEngine.elementType =
{
	SITE: 0,
	INTERSECTION: 1,
	BOUNDARIE: 2,
	REGION: 3
}