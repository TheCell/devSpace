
let XMLHttpRequest = require('xhr2');
let timeSinceLastPaperUpdate = new Date();
let dateOfEpaperImage = new Date();
let xhr = new XMLHttpRequest();
let dataFetchingInProgress = false;

let interval = setInterval(checkForEntry, 2000);

function checkForEntry()
{
	getnewestEntryDate();
}

function getnewestEntryDate()
{
	if (dataFetchingInProgress)
	{
		console.log("fetching in progress, skipping new check");
		return;
	}

	console.log("checking Entry Date");
	xhr.open('GET', 'https://dev.thecell.eu/ePaperDisplay/newestEntry.php?newestEntryTime=1', true);
	xhr.send();
	dataFetchingInProgress = true;

	xhr.onload = function ()
	{
		let response = JSON.parse(this.responseText);
		let responseDate = new Date(response.uploadTime);

		if (responseDate.getTime() != dateOfEpaperImage.getTime())
		{
			getNewestDataAndPaint();
		}
		else
		{
			dataFetchingInProgress = false;
		}
	};

	xhr.onerror = function ()
	{
		dataFetchingInProgress = false;
		console.warn("error: ",xhr.response);
	}
}

function getNewestDataAndPaint()
{
	xhr.open('GET', 'https://dev.thecell.eu/ePaperDisplay/newestEntry.php?newestEntry=1', true);
	xhr.send();
	xhr.onload = function ()
	{
		let response = JSON.parse(this.responseText);
		updateEpaper(response);
	}
}

function updateEpaper(dataObj)
{
	let currentTime = new Date();
	if (currentTime.getTime() > (timeSinceLastPaperUpdate.getTime() + 5000))
	{
		console.log("painting now");
		//todo dataObj.imageData
		dateOfEpaperImage = new Date(dataObj.uploadTime);
		timeSinceLastPaperUpdate = currentTime;
	}
	dataFetchingInProgress = false;
}