const shellExec = require('shell-exec');
const spawn = require('child_process').spawn;

// mkv to mp4 is containerswap only
// https://askubuntu.com/questions/396883/how-to-simply-convert-video-files-i-e-mkv-to-mp4

// themes by https://github.com/hundredrabbits/Themes

let theme = new Theme();
theme.install(document.body);
theme.start();

function convert(optionsArr)
{
	//spawn('ffmpeg', ['-version'], { stdio: 'inherit' });
	return spawn('ffmpeg', optionsArr, { stdio: 'inherit'});
}

function ffmpegConvert()
{
	console.log("starting");
	let path = document.getElementById("inputFile").files[0].path;
	shellExec("ffmpeg -i " + path + " -c:v libx264 " + document.getElementById("outputFile").value)
	.then(output =>
	{
		console.log(output.stdout);
	});
}

function ffmpeg(command)
{
	let stdout;

	shellExec("ffmpeg " + command)
		.then(output =>
		{
			stdout = output.stdout;
			console.log(stdout);
		});

	return stdout;
}