"use strict";

class Faertenleser
{
	constructor()
	{
		this.intervalTimeMS = 200;
		this.currentRoute = Object.assign(emptyFaertenleserSave);
		this.map = map;

		this.mapsPathPolyLine = new google.maps.Polyline(
		{
			path: this.currentRoute.pathPoints,
			geodesic: true,
			strokeColor: '#FF0000',
			strokeOpacity: 1.0,
			strokeWeight: 2
		});
		this.mapsPathPolyLine.setMap(this.map);
}

	startTracking()
	{
		if (typeof(window.startFaertenleser) == "undefined")
		{
			let self = this;
			window.startFaertenleser = setInterval(function ()
			{
				self.trackPoint();
			}, this.intervalTimeMS);
		}
	}

	stopTracking()
	{
		clearInterval(window.startFaertenleser);
	}

	trackPoint()
	{
		console.log("tracking...");
		let newPoint = {lat: map.center.lat(), lng: map.center.lng()};
		let lastSavedPoint = this.currentRoute.pathPoints[this.currentRoute.pathPoints.length - 1];
		if (!this.isTheSameTrackPoint(lastSavedPoint, newPoint))
		{
			this.currentRoute.pathPoints.push(newPoint);
		}

		this.updatePolylinePath(this.currentRoute.pathPoints);
	}

	isTheSameTrackPoint(point1, point2)
	{
		let theSamePoint = false;

		if (typeof(point1) == "undefined"
			|| typeof(point2) == "undefined")
		{
			return false;
		}
		if (point1.lat == point2.lat && point1.lng == point2.lng)
		{
			return true;
		}
		return false;
	}

	updatePolylinePath(path)
	{
		this.mapsPathPolyLine.setPath(path);
	}
}

let emptyFaertenleserSave =
{
	routeName: "new Track",
	pathPoints: []
}