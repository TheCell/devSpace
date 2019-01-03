'use strict';
// for the paper
// See http://www.wias-berlin.de/people/si/course/files/Fortune87-SweepLine-Voronoi.pdf
// for a c++ solution
// http://skynet.ie/~sos/mapviewer/voronoi.php
// for simpler explanation
// http://blog.ivank.net/fortunes-algorithm-and-implementation.html

class VoronoiEngine
{
	constructor()
	{
		this.imagedata = "";
		this.imageWidth = 300;
		this.imageHeight = 100;
		this.numberOfSeedPoints = 20;
		this.seedPoints = [];

		// just demo things. Generate for debug
		this.generateExample();
	}

	generateExample()
	{
		// generate random Points as Voronoi seed
		this.seedPoints = this.randomPointsInBoundaries();

		// sort by x if equal then by y
		// p, q ∈ R^2 are lexicographically ordered,
		// p < q, if px < qx and (py < qy or py = qy)
		this.seedPoints.sort((objA, objB) => {
			let lowerX = objA.x - objB.x;
			if (lowerX == 0)
			{
				let lowerY = objA.y - objB.y;
				return lowerY
			}
			return lowerX
		});
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
	randomPointsInBoundaries()
	{
		let xLength = this.imageWidth;
		let yLength = this.imageHeight;
		let numberOfSeedPoints = this.numberOfSeedPoints;
		let randomPoints = [];

		for (let i = 0; i < numberOfSeedPoints; i++)
		{
			randomPoints.push(
				new Point(
					Math.round(Math.random() * xLength),
					Math.round(Math.random() * yLength))
				);
		}

		return randomPoints;
	}

	// input is set of points (sites). Output is set of edges or polygons
	calculateVoronoi()
	{
		if (this.seedPoints.length < 1)
		{
			console.error("no seedpoints given, stopping generation");
			return;
		}

		let priorityQueue = []; // priority queue of points in the plane see sweepline paper
		let setOfPointsInPlane; // Let S be a set of n points in the plane, called sites.
		let unionOfSegmentsAndLines; // V consists of the union of segments, half-lines, and lines.
		let separationLine; // Line dividing registered points for Voronoi from yet unregistered
		let beachLine; // points and intersections which are not yet final

		// add all sites to the queue and add the element Type Site
		priorityQueue = this.seedPoints;
		priorityQueue.forEach( function (val, index, array)
		{
			val.elementType = VoronoiEngine.elementType.SITE;
		});

		// Sequence of regions, boundaries initiate with a copy of all p
		/*
		what have i written here?
		L = priorityQueue.slice();

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
		*/

		let minimalPoint;
		while (priorityQueue.length > 0)
		{
			minimalPoint = priorityQueue.shift(); // extract minimal point
			if (minimalPoint.elementType == VoronoiEngine.elementType.SITE)
			{
				console.log("is site");
				addParabola();
			}
			else
			{
				console.log("not site");
				removeParabola();
			}
		}

		//let point = ... // {x: int, y: int}
	}
}

function addParabola(pointU)
{

}

function removeParabola(parabolaP)
{

}

VoronoiEngine.elementType =
{
	SITE: 0,
	INTERSECTION: 1,
	BOUNDARIE: 2,
	REGION: 3
}