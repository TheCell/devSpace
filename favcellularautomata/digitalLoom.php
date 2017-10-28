<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

<div id="controlPanel">
	<fieldset>
		<legend>
			Webmuster auswahl
		</legend>
		<label>
			<input type="radio" name="webmusterAuswahl" value="0"> Webmuster 1
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="1"> Webmuster 2
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="2"> Webmuster 3
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="3"> Webmuster 4
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="4"> Webmuster 5
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="5"> Webmuster 6
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="6"> Webmuster 7
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="7"> Webmuster 8
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="8"> Webmuster 9
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="9"> Webmuster 10
		</label>
		<label>
			<input type="radio" name="webmusterAuswahl" value="10"> Webmuster 11
		</label>
	</fieldset>

	<button onclick="init()">Starte das Weben</button>
	<button onclick="stop()">Stoppe das Weben</button>
	<a id="downloadButton" onclick="downloadCurrent()">Download der aktuellen Ansicht</a>
</div>
<canvas id="digitalLoomLittle" width="128" height="256" style="width: 256px;"></canvas>

<script type="text/javascript">
window.iterationCount = 0;
window.intervalId;
//window.currentIteration = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
window.currentIteration = [];
window.isScroll = false;
window.canvasPixelsWidth = parseInt(document.getElementById("digitalLoomLittle").width);
window.canvasPixelsHeight = parseInt(document.getElementById("digitalLoomLittle").height);
//let tempWidth = window.currentIteration.length;
window.currentIteration.length = window.canvasPixelsWidth;
window.currentIteration.fill(0);
window.currentIteration[window.currentIteration.length / 2] = 1;
</script>

<script type="text/javascript">
function downloadCurrent()
{
	link = document.getElementById("downloadButton");
	link.href = document.getElementById("digitalLoomLittle").toDataURL();
	link.download = "DigitalGewoben";
}

function stop()
{
	clearInterval(window.intervalId);
}

function init()
{
	let styleChoice;
	let radios = document.getElementsByName("webmusterAuswahl");
	for (let i = 0; i < radios.length; i++)
	{
		if (radios[i].checked)
		{
			styleChoice = parseInt(radios[i].value);
		}
	}

	styleChoice = styleChoice ? styleChoice : Math.floor(Math.random() * 10);

	switch(styleChoice)
	{
		case 0:
			console.log("rule 110");
			// ruleset 110
			window.ruleset = [0, 1, 1, 0, 1, 1, 1, 0];
		break;
		case 1:
			console.log("rule 126");
			// ruleset 126
			window.ruleset = [0, 1, 1, 1, 1, 1, 1, 0];
		break;
		case 2:
			console.log("rule 30");
			// ruleset 30
			window.ruleset = [0, 0, 0, 1, 1, 1, 1, 0];
		break;
		case 3:
			console.log("rule 54");
			// ruleset 54
			window.ruleset = [0, 0, 1, 1, 0, 1, 1, 0];
		break;
		case 4:
			console.log("rule 62");
			// ruleset 62
			window.ruleset = [0, 0, 1, 1, 1, 1, 1, 0];
		break;
		case 5:
			console.log("rule 90");
			// ruleset 90
			window.ruleset = [0, 1, 0, 1, 1, 0, 1, 0];
		break;
		case 6:
			console.log("rule 94");
			// ruleset 94
			window.ruleset = [0, 1, 0, 1, 1, 1, 1, 0];
		break;
		case 7:
			console.log("rule 102");
			// ruleset 102
			window.ruleset = [0, 1, 1, 0, 0, 1, 1, 0];
		break;
		case 8:
			console.log("rule 150");
			// ruleset 150
			window.ruleset = [1, 0, 0, 1, 0, 1, 1, 0];
		break;
		case 9:
			console.log("rule 182");
			// ruleset 182
			window.ruleset = [1, 0, 1, 1, 0, 1, 1, 0];
		break;
		case 10:
			console.log("rule 250");
			// ruleset 250
			window.ruleset = [1, 1, 1, 1, 1, 0, 1, 0];
		break;
		default:
			console.log("rule 250");
			// ruleset 250
			window.ruleset = [1, 1, 1, 1, 1, 0, 1, 0];
		break;
	}

	clearInterval(window.intervalId);
	window.intervalId = setInterval(generateNextLoomStep, 100);
}

function generateNextLoomStep()
{
	let canvas = document.getElementById("digitalLoomLittle");
	let ctx = canvas.getContext("2d");

	// set composite to standard
	//ctx.globalCompositeOperation = 'source-over';

	// move rows one up
	window.maxIterationCount = canvasPixelsHeight -1;
	if(!window.isScroll && window.iterationCount == window.maxIterationCount)
	{
		// paint new row
		for(let i = 0; i < window.currentIteration.length -1; i++)
		{
			if(window.currentIteration[i] > 0)
			{
				ctx.fillStyle = "rgb(255, 140, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
			else
			{
				ctx.fillStyle = "rgb(0, 0, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
		};

		window.isScroll = true;
	}
	else if(window.iterationCount == window.maxIterationCount)
	{
		let imageData = ctx.getImageData(0, 1, ctx.canvas.width, ctx.canvas.height);
		ctx.putImageData(imageData, 0, 0);

		// paint new row
		for(let i = 0; i < window.currentIteration.length -1; i++)
		{
			if(window.currentIteration[i] > 0)
			{
				ctx.fillStyle = "rgb(255, 140, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
			else
			{
				ctx.fillStyle = "rgb(0, 0, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
		};
	}
	else
	{
		// paint new row
		for(let i = 0; i < window.currentIteration.length -1; i++)
		{
			if(window.currentIteration[i] > 0)
			{
				ctx.fillStyle = "rgb(255, 140, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
			else
			{
				ctx.fillStyle = "rgb(0, 0, 0)";
				ctx.fillRect(i, window.iterationCount, 1, 1);
			}
		};

		ctx.fillStyle = "rgb(0, 0, 0)";
		ctx.fillRect(0, window.iterationCount + 1, ctx.canvas.width, ctx.canvas.height);

		window.iterationCount++;
	}

	// fill the ignored left outermost pixel
	if(window.currentIteration[0] > 0)
	{
		ctx.fillStyle = "rgb(255, 140, 0)";
		ctx.fillRect(0, canvasPixelsHeight -1, 1, 1);
	}
	else
	{
		ctx.fillStyle = "rgb(0, 0, 0)";
		ctx.fillRect(0, canvasPixelsHeight -1, 1, 1);
	}

	// fill the ignored right outermost pixel
	if(window.currentIteration[window.currentIteration.length] > 0)
	{
		ctx.fillStyle = "rgb(255, 140, 0)";
		ctx.fillRect(canvasPixelsWidth -1, canvasPixelsHeight -1, 1, 1);
	}
	else
	{
		ctx.fillStyle = "rgb(0, 0, 0)";
		ctx.fillRect(canvasPixelsWidth -1, canvasPixelsHeight -1, 1, 1);
	}

	// calc next iteration
	window.currentIteration = generateNextIteration(window.currentIteration, window.ruleset);
}

function generateNextIteration(inputarr, ruleset)
{
	let copyArr = inputarr.slice();

	// go thourgh arr excluding first and last index
	for (var i = 1; i < inputarr.length - 1; i++)
	{
		copyArr[i] = ruleToResult(ruleset, inputarr[i - 1], inputarr[i], inputarr[i + 1]);
	}

	return copyArr;
}

function ruleToResult(ruleset, first, second, third)
{
	let inputString = "" + first + second + third;
	switch(inputString)
	{
		// 1: 111
		case "111":
			return ruleset[0];
		break;
		// 2: 110
		case "110":
			return ruleset[1];
		break;
		// 3: 101
		case "101":
			return ruleset[2];
		break;
		// 4: 100
		case "100":
			return ruleset[3];
		break;
		// 5: 011
		case "011":
			return ruleset[4];
		break;
		// 6: 010
		case "010":
			return ruleset[5];
		break;
		// 7: 001
		case "001":
			return ruleset[6];
		break;
		// 8: 000
		case "000":
			return ruleset[7];
		break;
		default:
			return 0;
		break;
	}
}
</script>
<!--
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-75635403-2', 'auto');
	ga('send', 'pageview');
</script>
-->
</body>
</html>